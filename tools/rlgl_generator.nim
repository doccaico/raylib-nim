import std / [json, enumerate, strutils]

const filePath = "api/rlgl_api.json"
let jsonNode = parseFile(filePath)

var buf: string
var missing: string

var definesNode = jsonNode["defines"]
var posDefines: int = 0
var structsNode = jsonNode["structs"]
var posStructs: int = 0
var enumsNode = jsonNode["enums"]
var posEnums: int = 0
var functionsNode = jsonNode["functions"]

proc newline() = buf &= "\n"

proc skip(pos: var int) = inc pos

proc addSetting() =
  buf &= """
from raylib import
  PixelFormat, TextureFilter, BlendMode, ShaderLocationIndex, ShaderUniformDataType,
  ShaderAttributeDataType, Matrix, Vector2, Vector3, Color
export
  PixelFormat, TextureFilter, BlendMode, ShaderLocationIndex, ShaderUniformDataType,
  ShaderAttributeDataType, Matrix, Vector2, Vector3, Color
""".strip()

proc addConst(targetName: string, pre: string = "", past: string = "") =
  let item = definesNode[posDefines]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "const " & targetName & "* = " & pre & $item["value"] & past
    if item["description"].getStr != "": buf &= "# " & item["description"].getStr
    buf &= "\n"
  else:
    missing &= "Missing: " & targetName & "\n"
  inc posDefines

proc addRawString(body: string, nl: bool = false) =
  buf &= body
  if nl: newline()

proc addEnum(targetName: string, nl: bool = false) =
  let item = enumsNode[posEnums]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "# " & item["description"].getStr & "\n"
    buf &= "  " & name & "* {.size: sizeof(int32).} = enum" & "\n"
    for value in item["values"]:
      buf &= "    " & value["name"].getStr & " = " & $value["value"].getInt & " # " & value["description"].getStr & "\n"
  else:
    missing &= "Missing: " & targetName & "\n"
  if nl: newline()
  inc posEnums

proc convType(typeName: string): (bool, string) =
  case typeName
  of "bool": (true, "bool")
  of "float": (true, "float32")
  of "float *": (true, "ptr float32")
  of "const float *": (true, "ptr float32")
  of "double": (true, "float64")
  of "int": (true, "int32")
  of "int *": (true, "ptr int32")
  of "unsigned short *": (true, "ptr uint16")
  of "unsigned int": (true, "uint32")
  of "unsigned int *": (true, "ptr uint32")
  of "unsigned int[5]": (true, "array[5, uint32]")
  of "const char *": (true, "cstring")
  of "unsigned char": (true, "uint8")
  of "unsigned char *": (true, "ptr uint8")
  of "void": (true, "void")
  of "void *": (true, "pointer")
  of "const void *": (true, "pointer")
  of "Matrix": (true, "Matrix")
  of "rlRenderBatch": (true, "rlRenderBatch")
  of "rlRenderBatch *": (true, "ptr rlRenderBatch")
  of "rlDrawCall *": (true, "ptr rlDrawCall")
  of "rlVertexBuffer *": (true, "ptr rlVertexBuffer")
  of "const Matrix *": (true, "ptr Matrix")
  else: (false, "not found type: " & typeName & "\n")

proc addType(targetName: string, nl: bool = false) =
  let item = structsNode[posStructs]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "# " & item["description"].getStr & "\n"
    buf &= "  " & name & "* " & "{.completeStruct, bycopy, importc, header: \"rlgl.h\".} = object" & "\n"
    for field in item["fields"]:

      # maybe this is rlparser's bug?
      case field["type"].getStr
      of "#if defined(GRAPHICS_API_OPENGL_11) || defined(GRAPHICS_API_OPENunsigned int *",
         "#endif",
         "#if defined(GRAPHICS_API_OPENGL_ES2)": continue

      # maybe this is rlparser's bug?
      if field["name"].getStr == "indices" and field["type"].getStr == "unsigned short *":
        continue

      let (ok, ret) = convType(field["type"].getStr)
      if ok:
        let typ = if field["name"].getStr == "type": "`type`" else: field["name"].getStr
        buf &= "    " & typ & "*: " & ret & " # " & field["description"].getStr & "\n"
      else:
        missing &= ret 
  else:
    missing &= "Missing: " & targetName & "\n"
  if nl: newline()
  inc posStructs

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

skip(posDefines) # RLGL_H

addConst("RLGL_VERSION")
newline()

skip(posDefines) # RLAPI
skip(posDefines) # TRACELOG(level, ...)
skip(posDefines) # RL_MALLOC(sz)
skip(posDefines) # RL_CALLOC(n,sz)
skip(posDefines) # RL_REALLOC(n,sz)
skip(posDefines) # RL_FREE(p)
skip(posDefines) # GRAPHICS_API_OPENGL_33
skip(posDefines) # GRAPHICS_API_OPENGL_11
skip(posDefines) # GRAPHICS_API_OPENGL_ES2
addConst("RL_DEFAULT_BATCH_BUFFER_ELEMENTS")
addConst("RL_DEFAULT_BATCH_BUFFERS")
addConst("RL_DEFAULT_BATCH_DRAWCALLS")
addConst("RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS")
addConst("RL_MAX_MATRIX_STACK_SIZE")
addConst("RL_MAX_SHADER_LOCATIONS")
addConst("RL_CULL_DISTANCE_NEAR")
addConst("RL_CULL_DISTANCE_FAR")
addConst("RL_TEXTURE_WRAP_S")
addConst("RL_TEXTURE_WRAP_T")
addConst("RL_TEXTURE_MAG_FILTER")
addConst("RL_TEXTURE_MIN_FILTER")
addConst("RL_TEXTURE_FILTER_NEAREST")
addConst("RL_TEXTURE_FILTER_LINEAR")
addConst("RL_TEXTURE_FILTER_MIP_NEAREST")
addConst("RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR")
addConst("RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST")
addConst("RL_TEXTURE_FILTER_MIP_LINEAR")
addConst("RL_TEXTURE_FILTER_ANISOTROPIC")
addConst("RL_TEXTURE_MIPMAP_BIAS_RATIO")
addConst("RL_TEXTURE_WRAP_REPEAT")
addConst("RL_TEXTURE_WRAP_CLAMP")
addConst("RL_TEXTURE_WRAP_MIRROR_REPEAT")
addConst("RL_TEXTURE_WRAP_MIRROR_CLAMP")
addConst("RL_MODELVIEW")
addConst("RL_PROJECTION")
addConst("RL_TEXTURE")
addConst("RL_LINES")
addConst("RL_TRIANGLES")
addConst("RL_QUADS")
addConst("RL_UNSIGNED_BYTE")
addConst("RL_FLOAT")
addConst("RL_STREAM_DRAW")
addConst("RL_STREAM_READ")
addConst("RL_STREAM_COPY")
addConst("RL_STATIC_DRAW")
addConst("RL_STATIC_READ")
addConst("RL_STATIC_COPY")
addConst("RL_DYNAMIC_DRAW")
addConst("RL_DYNAMIC_READ")
addConst("RL_DYNAMIC_COPY")
addConst("RL_FRAGMENT_SHADER")
addConst("RL_VERTEX_SHADER")
addConst("RL_COMPUTE_SHADER")
addConst("RL_ZERO")
addConst("RL_ONE")
addConst("RL_SRC_COLOR")
addConst("RL_ONE_MINUS_SRC_COLOR")
addConst("RL_SRC_ALPHA")
addConst("RL_ONE_MINUS_SRC_ALPHA")
addConst("RL_DST_ALPHA")
addConst("RL_ONE_MINUS_DST_ALPHA")
addConst("RL_DST_COLOR")
addConst("RL_ONE_MINUS_DST_COLOR")
addConst("RL_SRC_ALPHA_SATURATE")
addConst("RL_CONSTANT_COLOR")
addConst("RL_ONE_MINUS_CONSTANT_COLOR")
addConst("RL_CONSTANT_ALPHA")
addConst("RL_ONE_MINUS_CONSTANT_ALPHA")
addConst("RL_FUNC_ADD")
addConst("RL_MIN")
addConst("RL_MAX")
addConst("RL_FUNC_SUBTRACT")
addConst("RL_FUNC_REVERSE_SUBTRACT")
addConst("RL_BLEND_EQUATION")
addConst("RL_BLEND_EQUATION_RGB")
addConst("RL_BLEND_EQUATION_ALPHA")
addConst("RL_BLEND_DST_RGB")
addConst("RL_BLEND_SRC_RGB")
addConst("RL_BLEND_DST_ALPHA")
addConst("RL_BLEND_SRC_ALPHA")
addConst("RL_BLEND_COLOR")
addConst("RL_READ_FRAMEBUFFER")
addConst("RL_DRAW_FRAMEBUFFER")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_POSITION")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_NORMAL")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_COLOR")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_TANGENT")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD2")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_INDICES")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_BONEINDICES")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_BONEWEIGHTS")
addConst("RL_DEFAULT_SHADER_ATTRIB_LOCATION_INSTANCETRANSFORM")
skip(posDefines) # RL_BOOL_TYPE
skip(posDefines) # RL_MATRIX_TYPE
skip(posDefines) # RL_SHADER_LOC_MAP_DIFFUSE
skip(posDefines) # RL_SHADER_LOC_MAP_SPECULAR

newline()

addRawString("type", nl=true)

skip(posStructs) # Matrix
addType("rlVertexBuffer", nl=true)
addType("rlDrawCall", nl=true)
addType("rlRenderBatch", nl=true)

newline()

addEnum("rlGlVersion", nl=true)
skip(posEnums) # rlTraceLogLevel
addEnum("rlPixelFormat", nl=true)
addEnum("rlTextureFilter", nl=true)
addEnum("rlBlendMode", nl=true)
addEnum("rlShaderLocationIndex", nl=true)
addEnum("rlShaderUniformDataType", nl=true)
addEnum("rlShaderAttributeDataType", nl=true)
addEnum("rlFramebufferAttachType", nl=true)
addEnum("rlFramebufferAttachTextureType", nl=true)
addEnum("rlCullMode", nl=true)


addRawString("{.push callconv: cdecl, header: \"rlgl.h\".}", nl=true)

newline()
addFunctions()
newline()

addRawString("{.pop.}", nl=true)

if missing != "": echo missing

writeFile("rlgl.nim", buf)
