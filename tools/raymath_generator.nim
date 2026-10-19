import std / [json, enumerate, strutils]

const RAYMATH_H = "\"raymath.h\""

const filePath = "api/raymath_api.json"
let jsonNode = parseFile(filePath)

var buf: string
var missing: string

var functionsNode = jsonNode["functions"]

proc newline() = buf &= "\n"

proc addSetting() =
  buf &= """
from raylib import
  Vector2, Vector3, Vector4, Quaternion, Matrix
export
  Vector2, Vector3, Vector4, Quaternion, Matrix
""".strip()

proc addRawString(body: string, nl: bool = false) =
  buf &= body
  if nl: newline()

proc convType(typeName: string): (bool, string) =
  case typeName
  of "float": (true, "float32")
  of "float *": (true, "ptr float32")
  of "float3": (true, "Float3")
  of "float16": (true, "Float16")
  of "double": (true, "float64")
  of "int": (true, "int32")
  of "Vector2": (true, "Vector2")
  of "Vector3": (true, "Vector3")
  of "Vector3 *": (true, "ptr Vector3")
  of "const Vector3": (true, "Vector3")
  of "Vector4": (true, "Vector4")
  of "Quaternion": (true, "Quaternion")
  of "Quaternion *": (true, "ptr Quaternion")
  of "Matrix": (true, "Matrix")
  of "void": (true, "void")
  else: (false, "not found type: " & typeName & "\n")

proc addFunctions() =
  for item in functionsNode:
    let name = item["name"].getStr

    var returnType: string
    let (ok, ret) = convType(item["returnType"].getStr)
    if ok:
      returnType = if ret == "void": "" else: ": " & ret
    else:
      missing &= ret

    if "params" in item:
      let paramsLen = item["params"].len
      buf &= "proc " & name & "*("
      if item["params"].len == 0:
        buf &= ")" & returnType

      for i, param in enumerate(item["params"]):
        let (ok, ret) = convType(param["type"].getStr)
        if ok:
          let name = case param["name"].getStr 
          of "type": "`type`"
          of "ptr": "`ptr`"
          of "end": "`end`"
          of "from": "`from`"

          else: param["name"].getStr
          buf &= name & ": " & ret
          if i == paramsLen - 1: buf &= ")" & returnType else: buf &= ", "
        else:
          missing &= ret

    else:
      buf &= "proc " & name & "*()" & returnType

    newline()


## Main
addSetting()

newline()
newline()

addRawString("""
type
  float3* {.completeStruct, bycopy.} = object
    v*: array[3, float32]
  float16* {.completeStruct, bycopy.} = object
    v*: array[16, float32]""", nl=true)

newline()

addRawString("""
template MatrixToFloat*(mat: untyped): untyped =
  (MatrixToFloatV(mat).v)""", nl=true)

newline()

addRawString("""
template Vector3ToFloat*(vec: untyped): untyped =
  (Vector3ToFloatV(vec).v)""", nl=true)

newline()

addRawString("{.push callconv: cdecl, header: " & RAYMATH_H & ".}", nl=true)

newline()
addFunctions()
newline()

addRawString("{.pop.}", nl=true)

if missing != "": echo missing

writeFile("raymath.nim", buf)
