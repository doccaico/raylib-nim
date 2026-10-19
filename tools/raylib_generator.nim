import std / [json, nre, enumerate, strutils]

const RAYLIB_H = "\"raylib.h\""

const filePath = "api/raylib_api.json"
let jsonNode = parseFile(filePath)

var buf: string
var missing: string

var definesNode = jsonNode["defines"]
var posDefines: int = 0
var structsNode = jsonNode["structs"]
var posStructs: int = 0
var aliasesNode = jsonNode["aliases"]
var posAliases: int = 0
var enumsNode = jsonNode["enums"]
var posEnums: int = 0
var callbacksNode = jsonNode["callbacks"]
var posCallbacks: int = 0
var functionsNode = jsonNode["functions"]

proc newline() = buf &= "\n"

proc comment(body: string, nl: bool = false) =
  buf &= body
  if nl: newline()

proc skip(pos: var int) = inc pos

proc addSetting() =
  buf &= """
import std / [paths]

when not defined(windows):
  quit("This binding is Windows only")

const projectDir = currentSourcePath().Path.parentDir()
const raylibHeaderDir = projectDir / Path"include"

when defined(gcc):
  const lib = projectDir / Path"lib" / Path"windows" / Path"mingw-w64" / Path"libraylib.a"
  {.passL: lib.}
  {.passL: "-lopengl32 -lgdi32 -lwinmm -luser32 -lshell32".}
  {.passC: "-I" & raylibHeaderDir.string .}

when defined(vcc):
  const lib = projectDir / Path"lib" / Path"windows" / Path"msvc16" / Path"raylib.lib"
  {.passL: lib.}
  {.passL: "msvcrt.lib opengl32.lib gdi32.lib winmm.lib user32.lib shell32.lib".}
  {.passL: "/link /NODEFAULTLIB:LIBCMT".}
  {.passC: "/I" & raylibHeaderDir.string .}
""".strip()

proc addConst(targetName: string, pre: string = "", past: string = "") =
  let item = definesNode[posDefines]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "const " & targetName & "* = " & pre & $item["value"] & past & "\n"
  else:
    missing &= "Missing: " & targetName & "\n"
  inc posDefines

proc addDefineString(body: string, nl: bool = false) =
  buf &= body
  if nl: newline()
  inc posDefines

proc addRawString(body: string, nl: bool = false) =
  buf &= body
  if nl: newline()

proc addConstColor(targetName: string) =
  let item = definesNode[posDefines]
  let name = item["name"].getStr
  if name == targetName:
    var vList: array[4, string]
    for i, m in enumerate(item["value"].getStr.findIter(re"\d+")):
      vList[i] = m.match
    buf &= "const " & targetName & "* = Color("
    buf &= "r: " & vList[0] & ", g: " & vList[1] & ", b: " & vList[2] & ", a: " & vList[3]
    buf &= ") # " & item["description"].getStr & "\n"
  else:
    missing &= "Missing: " & targetName & "\n"
  inc posDefines

proc convType(typeName: string): (bool, string) =
  case typeName
  of "bool": (true, "bool")
  of "float": (true, "float32")
  of "float *": (true, "ptr float32")
  of "const float *": (true, "ptr float32")
  of "float[2]": (true, "array[2, float32]")
  of "float[4]": (true, "array[4, float32]")
  of "long": (true, "clong")
  of "int": (true, "int32")
  of "int *": (true, "ptr int32")
  of "int[4]": (true, "array[4, int32]")
  of "const int *": (true, "ptr int32")
  of "char": (true, "int8")
  of "char *": (true, "cstring")
  of "char **": (true, "cstringArray")
  of "char[32]": (true, "array[32, char]")
  of "const char *": (true, "cstring")
  of "const unsigned char *": (true, "ptr uint8")
  of "unsigned int": (true, "uint32")
  of "unsigned int *": (true, "ptr uint32")
  of "unsigned char": (true, "uint8")
  of "unsigned char *": (true, "ptr uint8")
  of "unsigned short *": (true, "ptr uint16")
  of "double": (true, "float64")
  of "void": (true, "void")
  of "void *": (true, "pointer")
  of "const void *": (true, "pointer")
  of "Texture": (true, "Texture")
  of "Rectangle": (true, "Rectangle")
  of "Rectangle **": (true, "ptr ptr Rectangle")
  of "Image": (true, "Image")
  of "Image *": (true, "ptr Image")
  of "Texture2D": (true, "Texture2D")
  of "Rectangle *": (true, "ptr Rectangle")
  of "GlyphInfo *": (true, "ptr GlyphInfo")
  of "Vector2": (true, "Vector2")
  of "Vector2 *": (true, "ptr Vector2")
  of "const Vector2 *": (true, "ptr Vector2")
  of "Vector3": (true, "Vector3")
  of "const Vector3 *": (true, "ptr Vector3")
  of "Vector4": (true, "Vector4")
  of "NPatchInfo": (true, "NPatchInfo")
  of "Texture2D *": (true, "ptr Texture2D")
  of "RenderTexture2D": (true, "RenderTexture2D")
  of "TextureCubemap": (true, "TextureCubemap")
  of "Shader": (true, "Shader")
  of "MaterialMap *": (true, "ptr MaterialMap")
  of "Color": (true, "Color")
  of "Color *": (true, "ptr Color")
  of "Font": (true, "Font")
  of "GlyphInfo": (true, "GlyphInfo")
  of "const GlyphInfo *": (true, "ptr GlyphInfo")
  of "Quaternion": (true, "Quaternion")
  of "BoneInfo *": (true, "ptr BoneInfo")
  of "ModelAnimPose": (true, "ModelAnimPose")
  of "ModelAnimPose *": (true, "ptr ModelAnimPose")
  of "Camera": (true, "Camera")
  of "Camera *": (true, "ptr Camera")
  of "Camera2D": (true, "Camera2D")
  of "Camera3D": (true, "Camera3D")
  of "VrStereoConfig": (true, "VrStereoConfig")
  of "VrDeviceInfo": (true, "VrDeviceInfo")
  of "Matrix": (true, "Matrix")
  of "Matrix *": (true, "ptr Matrix")
  of "const Matrix *": (true, "ptr Matrix")
  of "Matrix[2]": (true, "array[2, Matrix]")
  of "Mesh": (true, "Mesh")
  of "Mesh *": (true, "ptr Mesh")
  of "Sound": (true, "Sound")
  of "Material": (true, "Material")
  of "Model": (true, "Model")
  of "Model *": (true, "ptr Model")
  of "ModelAnimation": (true, "ModelAnimation")
  of "ModelAnimation *": (true, "ptr ModelAnimation")
  of "Ray": (true, "Ray")
  of "RayCollision": (true, "RayCollision")
  of "BoundingBox": (true, "BoundingBox")
  of "Wave": (true, "Wave")
  of "Wave *": (true, "ptr Wave")
  of "Material *": (true, "ptr Material")
  of "ModelSkeleton": (true, "ModelSkeleton")
  of "FilePathList": (true, "FilePathList")
  of "rAudioBuffer *": (true, "ptr rAudioBuffer")
  of "rAudioProcessor *": (true, "ptr rAudioProcessor")
  of "AudioStream": (true, "AudioStream")
  of "AutomationEvent": (true, "AutomationEvent")
  of "AutomationEvent *": (true, "ptr AutomationEvent")
  of "AutomationEventList": (true, "AutomationEventList")
  of "AutomationEventList *": (true, "ptr AutomationEventList")
  of "Transform *": (true, "ptr Transform")
  of "AudioCallback": (true, "AudioCallback")
  of "TraceLogCallback": (true, "TraceLogCallback")
  of "SaveFileDataCallback": (true, "SaveFileDataCallback")
  of "LoadFileDataCallback": (true, "LoadFileDataCallback")
  of "SaveFileTextCallback": (true, "SaveFileTextCallback")
  of "LoadFileTextCallback": (true, "LoadFileTextCallback")
  of "Music": (true, "Music")
  of "va_list": (true, "va_list")
  of "...": (true, "")
  else: (false, "not found type: " & typeName & "\n")

proc addType(targetName: string, nl: bool = false) =
  let item = structsNode[posStructs]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "# " & item["description"].getStr & "\n"
    buf &= "  " & name & "* " & "{.completeStruct, bycopy, importc, header: " & RAYLIB_H & ".} = object" & "\n"
    for field in item["fields"]:
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

proc addAlias(targetName: string, nl: bool = false) =
  let item = aliasesNode[posAliases]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "# " & item["description"].getStr & "\n"
    buf &= "  " & name & "* = " & item["type"].getStr & "\n"
  else:
    missing &= "Missing: " & targetName & "\n"
  if nl: newline()
  inc posAliases

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

proc addCallback(targetName: string, nl: bool = false) =
  let item = callbacksNode[posCallbacks]
  let name = item["name"].getStr
  if name == targetName:
    buf &= "# " & item["description"].getStr & "\n"

    var returnType: string
    let (ok, ret) = convType(item["returnType"].getStr)
    if ok:
      returnType = if ret == "void": "" else: ": " & ret
    else:
      missing &= ret

    let paramsLen = item["params"].len
    buf &= "  " & name & " = proc("
    for i, param in enumerate(item["params"]):

      let (ok, ret) = convType(param["type"].getStr)
      if ok:
        let typ = if ret == "cstring": "ConstCstring" else: ret
        buf &= param["name"].getStr & ": " & typ
        if i == paramsLen - 1: buf &= ")" & returnType else: buf &= ", "
      else:
        missing &= ret
    buf &= " {.cdecl.}"
  else:
    missing &= "Missing: " & targetName & "\n"
  if nl: newline()
  inc posCallbacks

proc addFunctions() =
  for item in functionsNode:
    let name = item["name"].getStr

    case name
    of "TraceLog", "TextFormat": continue

    buf &= "# " & item["description"].getStr & "\n"

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

# addRawString("{.push completeStruct, bycopy, importc, header: " & RAYLIB_H & ".}", nl=true)

newline()

addRawString("type", nl=true)

addType("Vector2", nl=true)
addType("Vector3", nl=true)
addType("Vector4", nl=true)
addType("Matrix", nl=true)
addType("Color", nl=true)
addType("Rectangle", nl=true)
addType("Image", nl=true)
addType("Texture", nl=true)
addType("RenderTexture", nl=true)
addType("NPatchInfo", nl=true)
addType("GlyphInfo", nl=true)
addType("Font", nl=true)
addType("Camera3D", nl=true)
addType("Camera2D", nl=true)
addType("Mesh", nl=true)
addType("Shader", nl=true)
addType("MaterialMap", nl=true)
addType("Material", nl=true)
addType("Transform", nl=true)
addType("BoneInfo", nl=true)
addType("ModelSkeleton", nl=true)
addType("Model", nl=true)
addType("ModelAnimation", nl=true)
addType("Ray", nl=true)
addType("RayCollision", nl=true)
addType("BoundingBox", nl=true)
addType("Wave", nl=true)
addType("AudioStream", nl=true)
addType("Sound", nl=true)
addType("Music", nl=true)
addType("VrDeviceInfo", nl=true)
addType("VrStereoConfig", nl=true)
addType("FilePathList", nl=true)
addType("AutomationEvent", nl=true)
addType("AutomationEventList", nl=true)

comment("# Opaque structs declaration", nl=true)
comment("# NOTE: Actual structs are defined internally in raudio module", nl=true)

addRawString("  rAudioBuffer* {.importc, nodecl, bycopy.} = object", nl=true)
addRawString("  rAudioProcessor* {.importc, nodecl, bycopy.} = object", nl=true)

newline()

addAlias("Quaternion", nl=true)
addAlias("Texture2D", nl=true)
addAlias("TextureCubemap", nl=true)
addAlias("RenderTexture2D", nl=true)
addAlias("Camera", nl=true)
addRawString("  ModelAnimPose* = ptr Transform", nl=true)

newline()
# addRawString("{.pop.}", nl=true)
newline()

skip(posDefines) # RAYLIB_H
addConst("RAYLIB_VERSION_MAJOR")
addConst("RAYLIB_VERSION_MINOR")
addConst("RAYLIB_VERSION_PATCH")
addConst("RAYLIB_VERSION")
newline()
skip(posDefines) # __declspec(x)
skip(posDefines) # RLAPI
addDefineString("const PI* = 3.141592653589793'f", nl=true)
addDefineString("const DEG2RAD* = (PI / 180.0'f)", nl=true)
addDefineString("const RAD2DEG* = (180.0'f / PI)", nl=true)
skip(posDefines) # RL_MALLOC(sz)
skip(posDefines) # RL_CALLOC(n,sz)
skip(posDefines) # RL_REALLOC(ptr,sz)
skip(posDefines) # RL_FREE(ptr)
skip(posDefines) # CLITERAL(type)
skip(posDefines) # RL_COLOR_TYPE
skip(posDefines) # RL_RECTANGLE_TYPE
skip(posDefines) # RL_VECTOR2_TYPE
skip(posDefines) # RL_VECTOR3_TYPE
skip(posDefines) # RL_VECTOR4_TYPE
skip(posDefines) # RL_QUATERNION_TYPE
skip(posDefines) # RL_MATRIX_TYPE

newline()

addConstColor("LIGHTGRAY")
addConstColor("GRAY")
addConstColor("DARKGRAY")
addConstColor("YELLOW")
addConstColor("GOLD")
addConstColor("ORANGE")
addConstColor("PINK")
addConstColor("RED")
addConstColor("MAROON")
addConstColor("GREEN")
addConstColor("LIME")
addConstColor("DARKGREEN")
addConstColor("SKYBLUE")
addConstColor("BLUE")
addConstColor("DARKBLUE")
addConstColor("PURPLE")
addConstColor("VIOLET")
addConstColor("DARKPURPLE")
addConstColor("BEIGE")
addConstColor("BROWN")
addConstColor("DARKBROWN")
addConstColor("WHITE")
addConstColor("BLACK")
addConstColor("BLANK")
addConstColor("MAGENTA")
addConstColor("RAYWHITE")

newline()

addRawString("type", nl=true)

addEnum("ConfigFlags", nl=true)
addEnum("TraceLogLevel", nl=true)
addEnum("KeyboardKey", nl=true)
addEnum("MouseButton", nl=true)
addEnum("MouseCursor", nl=true)
addEnum("GamepadButton", nl=true)
addEnum("GamepadAxis", nl=true)
addEnum("MaterialMapIndex", nl=true)
addEnum("ShaderLocationIndex", nl=true)
addEnum("ShaderUniformDataType", nl=true)
addEnum("ShaderAttributeDataType", nl=true)
addEnum("PixelFormat", nl=true)
addEnum("TextureFilter", nl=true)
addEnum("TextureWrap", nl=true)
addEnum("CubemapLayout", nl=true)
addEnum("FontType", nl=true)
addEnum("BlendMode", nl=true)
addEnum("Gesture", nl=true)
addEnum("CameraMode", nl=true)
addEnum("CameraProjection", nl=true)
addEnum("NPatchLayout", nl=true)

# Callbacks
addRawString("type va_list {.importc: \"va_list\", header: \"<stdarg.h>\".} = object # Only used by TraceLogCallback", nl=true)
addRawString("proc vsprintf*(s: cstring, format: cstring, args: va_list) {.cdecl, importc: \"vsprintf\", header: \"<stdio.h>\".}", nl=true)
addRawString("type ConstCstring {.importc: \"const char *\".} = cstring", nl=true)

newline()

comment("# Callbacks to hook some internal functions", nl=true)
comment("# WARNING: This callbacks are intended for advance users", nl=true)

newline()

addRawString("type", nl=true)

addCallback("TraceLogCallback", nl=true)
addCallback("LoadFileDataCallback", nl=true)
addCallback("SaveFileDataCallback", nl=true)
addCallback("LoadFileTextCallback", nl=true)
addCallback("SaveFileTextCallback", nl=true)
addCallback("AudioCallback", nl=true)

newline()
newline()

addRawString("{.push callconv: cdecl, importc, header: " & RAYLIB_H & ".}", nl=true)

newline()

addFunctions()

newline()
newline()

comment("# Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)", nl=true)
addRawString("proc TraceLog*(logLevel: TraceLogLevel, text: cstring) {.varargs.}", nl=true)
comment("# Text formatting with variables (sprintf() style)", nl=true)
addRawString("proc TextFormat*(text: cstring): cstring {.varargs.}", nl=true);

newline()

addRawString("{.pop.}", nl=true)

if missing != "": echo missing

writeFile("raylib.nim", buf)
