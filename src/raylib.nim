when defined(unix):
  const LIB_RAYLIB* = "libraylib.so"
elif defined(macosx):
  const LIB_RAYLIB* = "libraylib.dylib"
elif defined(windows):
  const LIB_RAYLIB* = "raylib.dll"


const
  PI* = 3.141592653589793
  DEG2RAD* = (PI / 180.0)
  RAD2DEG* = (180.0 / PI)
  MAX_TOUCH_POINTS* = 10

const
  FLAG_FULLSCREEN_MODE* = 0x00000002
  FLAG_WINDOW_RESIZABLE* = 0x00000004
  FLAG_WINDOW_UNDECORATED* = 0x00000008
  FLAG_WINDOW_TRANSPARENT* = 0x00000010
  FLAG_MSAA_4X_HINT* = 0x00000020
  FLAG_VSYNC_HINT* = 0x00000040
  FLAG_WINDOW_HIDDEN* = 0x00000080
  FLAG_WINDOW_ALWAYS_RUN* = 0x00000100
  FLAG_WINDOW_MINIMIZED* = 0x00000200
  FLAG_WINDOW_MAXIMIZED* = 0x00000400
  FLAG_WINDOW_UNFOCUSED* = 0x00000800
  FLAG_WINDOW_TOPMOST* = 0x00001000
  FLAG_WINDOW_HIGHDPI* = 0x00002000
  FLAG_INTERLACED_HINT* = 0x00010000

const
  LOG_ALL* = 0
  LOG_TRACE* = 1
  LOG_DEBUG* = 2
  LOG_INFO* = 3
  LOG_WARNING* = 4
  LOG_ERROR* = 5
  LOG_FATAL* = 6
  LOG_NONE* = 7

const
  KEY_SPACE* = 32
  KEY_APOSTROPHE* = 39
  KEY_COMMA* = 44
  KEY_MINUS* = 45
  KEY_PERIOD* = 46
  KEY_SLASH* = 47
  KEY_ZERO* = 48
  KEY_ONE* = 49
  KEY_TWO* = 50
  KEY_THREE* = 51
  KEY_FOUR* = 52
  KEY_FIVE* = 53
  KEY_SIX* = 54
  KEY_SEVEN* = 55
  KEY_EIGHT* = 56
  KEY_NINE* = 57
  KEY_SEMICOLON* = 59
  KEY_EQUAL* = 61
  KEY_A* = 65
  KEY_B* = 66
  KEY_C* = 67
  KEY_D* = 68
  KEY_E* = 69
  KEY_F* = 70
  KEY_G* = 71
  KEY_H* = 72
  KEY_I* = 73
  KEY_J* = 74
  KEY_K* = 75
  KEY_L* = 76
  KEY_M* = 77
  KEY_N* = 78
  KEY_O* = 79
  KEY_P* = 80
  KEY_Q* = 81
  KEY_R* = 82
  KEY_S* = 83
  KEY_T* = 84
  KEY_U* = 85
  KEY_V* = 86
  KEY_W* = 87
  KEY_X* = 88
  KEY_Y* = 89
  KEY_Z* = 90
  KEY_LEFT_BRACKET* = 91
  KEY_BACKSLASH* = 92
  KEY_RIGHT_BRACKET* = 93
  KEY_GRAVE* = 96
  KEY_ESCAPE* = 256
  KEY_ENTER* = 257
  KEY_TAB* = 258
  KEY_BACKSPACE* = 259
  KEY_INSERT* = 260
  KEY_DELETE* = 261
  KEY_RIGHT* = 262
  KEY_LEFT* = 263
  KEY_DOWN* = 264
  KEY_UP* = 265
  KEY_PAGE_UP* = 266
  KEY_PAGE_DOWN* = 267
  KEY_HOME* = 268
  KEY_END* = 269
  KEY_CAPS_LOCK* = 280
  KEY_SCROLL_LOCK* = 281
  KEY_NUM_LOCK* = 282
  KEY_PRINT_SCREEN* = 283
  KEY_PAUSE* = 284
  KEY_F1* = 290
  KEY_F2* = 291
  KEY_F3* = 292
  KEY_F4* = 293
  KEY_F5* = 294
  KEY_F6* = 295
  KEY_F7* = 296
  KEY_F8* = 297
  KEY_F9* = 298
  KEY_F10* = 299
  KEY_F11* = 300
  KEY_F12* = 301
  KEY_KP_0* = 320
  KEY_KP_1* = 321
  KEY_KP_2* = 322
  KEY_KP_3* = 323
  KEY_KP_4* = 324
  KEY_KP_5* = 325
  KEY_KP_6* = 326
  KEY_KP_7* = 327
  KEY_KP_8* = 328
  KEY_KP_9* = 329
  KEY_KP_DECIMAL* = 330
  KEY_KP_DIVIDE* = 331
  KEY_KP_MULTIPLY* = 332
  KEY_KP_SUBTRACT* = 333
  KEY_KP_ADD* = 334
  KEY_KP_ENTER* = 335
  KEY_KP_EQUAL* = 336
  KEY_LEFT_SHIFT* = 340
  KEY_LEFT_CONTROL* = 341
  KEY_LEFT_ALT* = 342
  KEY_LEFT_SUPER* = 343
  KEY_RIGHT_SHIFT* = 344
  KEY_RIGHT_CONTROL* = 345
  KEY_RIGHT_ALT* = 346
  KEY_RIGHT_SUPER* = 347
  KEY_KB_MENU* = 348

const
  KEY_BACK* = 4
  KEY_VOLUME_UP* = 24
  KEY_VOLUME_DOWN* = 25
  KEY_MENU* = 82

const
  MOUSE_LEFT_BUTTON* = 0
  MOUSE_RIGHT_BUTTON* = 1
  MOUSE_MIDDLE_BUTTON* = 2

const
  MOUSE_CURSOR_DEFAULT* = 0
  MOUSE_CURSOR_ARROW* = 1
  MOUSE_CURSOR_IBEAM* = 2
  MOUSE_CURSOR_CROSSHAIR* = 3
  MOUSE_CURSOR_POINTING_HAND* = 4
  MOUSE_CURSOR_RESIZE_EW* = 5
  MOUSE_CURSOR_RESIZE_NS* = 6
  MOUSE_CURSOR_RESIZE_NWSE* = 7
  MOUSE_CURSOR_RESIZE_NESW* = 8
  MOUSE_CURSOR_RESIZE_ALL* = 9
  MOUSE_CURSOR_NOT_ALLOWED* = 10

const
  GAMEPAD_PLAYER1* = 0
  GAMEPAD_PLAYER2* = 1
  GAMEPAD_PLAYER3* = 2
  GAMEPAD_PLAYER4* = 3

const
  GAMEPAD_BUTTON_UNKNOWN* = 0
  GAMEPAD_BUTTON_LEFT_FACE_UP* = 1
  GAMEPAD_BUTTON_LEFT_FACE_RIGHT* = 2
  GAMEPAD_BUTTON_LEFT_FACE_DOWN* = 3
  GAMEPAD_BUTTON_LEFT_FACE_LEFT* = 4
  GAMEPAD_BUTTON_RIGHT_FACE_UP* = 5
  GAMEPAD_BUTTON_RIGHT_FACE_RIGHT* = 6
  GAMEPAD_BUTTON_RIGHT_FACE_DOWN* = 7
  GAMEPAD_BUTTON_RIGHT_FACE_LEFT* = 8
  GAMEPAD_BUTTON_LEFT_TRIGGER_1* = 9
  GAMEPAD_BUTTON_LEFT_TRIGGER_2* = 10
  GAMEPAD_BUTTON_RIGHT_TRIGGER_1* = 11
  GAMEPAD_BUTTON_RIGHT_TRIGGER_2* = 12
  GAMEPAD_BUTTON_MIDDLE_LEFT* = 13
  GAMEPAD_BUTTON_MIDDLE* = 14
  GAMEPAD_BUTTON_MIDDLE_RIGHT* = 15
  GAMEPAD_BUTTON_LEFT_THUMB* = 16
  GAMEPAD_BUTTON_RIGHT_THUMB* = 17

const
  GAMEPAD_AXIS_LEFT_X* = 0
  GAMEPAD_AXIS_LEFT_Y* = 1
  GAMEPAD_AXIS_RIGHT_X* = 2
  GAMEPAD_AXIS_RIGHT_Y* = 3
  GAMEPAD_AXIS_LEFT_TRIGGER* = 4
  GAMEPAD_AXIS_RIGHT_TRIGGER* = 5

const
  LOC_VERTEX_POSITION* = 0
  LOC_VERTEX_TEXCOORD01* = 1
  LOC_VERTEX_TEXCOORD02* = 2
  LOC_VERTEX_NORMAL* = 3
  LOC_VERTEX_TANGENT* = 4
  LOC_VERTEX_COLOR* = 5
  LOC_MATRIX_MVP* = 6
  LOC_MATRIX_MODEL* = 7
  LOC_MATRIX_VIEW* = 8
  LOC_MATRIX_PROJECTION* = 9
  LOC_VECTOR_VIEW* = 10
  LOC_COLOR_DIFFUSE* = 11
  LOC_COLOR_SPECULAR* = 12
  LOC_COLOR_AMBIENT* = 13
  LOC_MAP_ALBEDO* = 14
  LOC_MAP_METALNESS* = 15
  LOC_MAP_NORMAL* = 16
  LOC_MAP_ROUGHNESS* = 17
  LOC_MAP_OCCLUSION* = 18
  LOC_MAP_EMISSION* = 19
  LOC_MAP_HEIGHT* = 20
  LOC_MAP_CUBEMAP* = 21
  LOC_MAP_IRRADIANCE* = 22
  LOC_MAP_PREFILTER* = 23
  LOC_MAP_BRDF* = 24

  LOC_MAP_DIFFUSE* = LOC_MAP_ALBEDO
  LOC_MAP_SPECULAR* = LOC_MAP_METALNESS

const
  UNIFORM_FLOAT* = 0
  UNIFORM_VEC2* = 1
  UNIFORM_VEC3* = 2
  UNIFORM_VEC4* = 3
  UNIFORM_INT* = 4
  UNIFORM_IVEC2* = 5
  UNIFORM_IVEC3* = 6
  UNIFORM_IVEC4* = 7
  UNIFORM_SAMPLER2D* = 8

const
  MAP_ALBEDO* = 0
  MAP_METALNESS* = 1
  MAP_NORMAL* = 2
  MAP_ROUGHNESS* = 3
  MAP_OCCLUSION* = 4
  MAP_EMISSION* = 5
  MAP_HEIGHT* = 6
  MAP_CUBEMAP* = 7
  MAP_IRRADIANCE* = 8
  MAP_PREFILTER* = 9
  MAP_BRDF* = 10

  MAP_DIFFUSE* = MAP_ALBEDO
  MAP_SPECULAR* = MAP_METALNESS

const
  UNCOMPRESSED_GRAYSCALE* = 1
  UNCOMPRESSED_GRAY_ALPHA* = 2
  UNCOMPRESSED_R5G6B5* = 3
  UNCOMPRESSED_R8G8B8* = 4
  UNCOMPRESSED_R5G5B5A1* = 5
  UNCOMPRESSED_R4G4B4A4* = 6
  UNCOMPRESSED_R8G8B8A8* = 7
  UNCOMPRESSED_R32* = 8
  UNCOMPRESSED_R32G32B32* = 9
  UNCOMPRESSED_R32G32B32A32* = 10
  COMPRESSED_DXT1_RGB* = 11
  COMPRESSED_DXT1_RGBA* = 12
  COMPRESSED_DXT3_RGBA* = 13
  COMPRESSED_DXT5_RGBA* = 14
  COMPRESSED_ETC1_RGB* = 15
  COMPRESSED_ETC2_RGB* = 16
  COMPRESSED_ETC2_EAC_RGBA* = 17
  COMPRESSED_PVRT_RGB* = 18
  COMPRESSED_PVRT_RGBA* = 19
  COMPRESSED_ASTC_4x4_RGBA* = 20
  COMPRESSED_ASTC_8x8_RGBA* = 21

const
  FILTER_POINT* = 0
  FILTER_BILINEAR* = 1
  FILTER_TRILINEAR* = 2
  FILTER_ANISOTROPIC_4X* = 3
  FILTER_ANISOTROPIC_8X* = 4
  FILTER_ANISOTROPIC_16X* = 5

const
  WRAP_REPEAT* = 0
  WRAP_CLAMP* = 1
  WRAP_MIRROR_REPEAT* = 2
  WRAP_MIRROR_CLAMP* = 3

const
  CUBEMAP_AUTO_DETECT* = 0
  CUBEMAP_LINE_VERTICAL* = 1
  CUBEMAP_LINE_HORIZONTAL* = 2
  CUBEMAP_CROSS_THREE_BY_FOUR* = 3
  CUBEMAP_CROSS_FOUR_BY_THREE* = 4
  CUBEMAP_PANORAMA* = 5

const
  FONT_DEFAULT* = 0
  FONT_BITMAP* = 1
  FONT_SDF* = 2

const
  BLEND_ALPHA* = 0
  BLEND_ADDITIVE* = 1
  BLEND_MULTIPLIED* = 2
  BLEND_ADD_COLORS* = 3
  BLEND_SUBTRACT_COLORS* = 4
  BLEND_CUSTOM* = 5

const
  GESTURE_NONE* = 0
  GESTURE_TAP* = 1
  GESTURE_DOUBLETAP* = 2
  GESTURE_HOLD* = 4
  GESTURE_DRAG* = 8
  GESTURE_SWIPE_RIGHT* = 16
  GESTURE_SWIPE_LEFT* = 32
  GESTURE_SWIPE_UP* = 64
  GESTURE_SWIPE_DOWN* = 128
  GESTURE_PINCH_IN* = 256
  GESTURE_PINCH_OUT* = 512

const
  CAMERA_CUSTOM* = 0
  CAMERA_FREE* = 1
  CAMERA_ORBITAL* = 2
  CAMERA_FIRST_PERSON* = 3
  CAMERA_THIRD_PERSON* = 4

const
  CAMERA_PERSPECTIVE* = 0
  CAMERA_ORTHOGRAPHIC* = 1

const
  NPT_9PATCH* = 0
  NPT_3PATCH_VERTICAL* = 1
  NPT_3PATCH_HORIZONTAL* = 2

type
  Vector2* {.bycopy.} = object
    x*: cfloat
    y*: cfloat

type
  Vector3* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat

type
  Vector4* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat
    w*: cfloat
  Quaternion* = Vector4

type
  Matrix* {.bycopy.} = object
    m0*, m4*, m8*, m12*: cfloat
    m1*, m5*, m9*, m13*: cfloat
    m2*, m6*, m10*, m14*: cfloat
    m3*, m7*, m11*, m15*: cfloat

type
  Color* {.bycopy.} = object
    r*: cuchar
    g*: cuchar
    b*: cuchar
    a*: cuchar

type
  Rectangle* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    width*: cfloat
    height*: cfloat

type
  Image* {.bycopy.} = object
    data*: pointer
    width*: cint
    height*: cint
    mipmaps*: cint
    format*: cint

type
  Texture* {.bycopy.} = object
    id*: cuint
    width*: cint
    height*: cint
    mipmaps*: cint
    format*: cint
  Texture2D* = Texture
  TextureCubemap* = Texture

type
  RenderTexture* {.bycopy.} = object
    id*: cuint
    texture*: Texture
    depth*: Texture
  RenderTexture2D* = RenderTexture

type
  NPatchInfo* {.bycopy.} = object
    source*: Rectangle
    left*: cint
    top*: cint
    right*: cint
    bottom*: cint
    `type`*: cint

type
  CharInfo* {.bycopy.} = object
    value*: cint
    offsetX*: cint
    offsetY*: cint
    advanceX*: cint
    image*: Image

type
  Font* {.bycopy.} = object
    baseSize*: cint
    charsCount*: cint
    charsPadding*: cint
    texture*: Texture2D
    recs*: ptr Rectangle
    chars*: ptr CharInfo
  SpriteFont* = Font

type
  Camera3D* {.bycopy.} = object
    position*: Vector3
    target*: Vector3
    up*: Vector3
    fovy*: cfloat
    `type`*: cint
  Camera* = Camera3D

type
  Camera2D* {.bycopy.} = object
    offset*: Vector2
    target*: Vector2
    rotation*: cfloat
    zoom*: cfloat

type
  Mesh* {.bycopy.} = object
    vertexCount*: cint
    triangleCount*: cint

    vertices*: ptr cfloat
    texcoords*: ptr cfloat
    texcoords2*: ptr cfloat
    normals*: ptr cfloat
    tangents*: ptr cfloat
    colors*: ptr cuchar
    indices*: ptr cushort

    animVertices*: ptr cfloat
    animNormals*: ptr cfloat
    boneIds*: ptr cint
    boneWeights*: ptr cfloat

    vaoId*: cuint
    vboId*: ptr cuint

type
  Shader* {.bycopy.} = object
    id*: cuint
    locs*: ptr cint

type
  MaterialMap* {.bycopy.} = object
    texture*: Texture2D
    color*: Color
    value*: cfloat

type
  Material* {.bycopy.} = object
    shader*: Shader
    maps*: ptr MaterialMap
    params*: ptr cfloat

type
  Transform* {.bycopy.} = object
    translation*: Vector3
    rotation*: Quaternion
    scale*: Vector3

type
  BoneInfo* {.bycopy.} = object
    name*: array[32, char]
    parent*: cint

type
  Model* {.bycopy.} = object
    transform*: Matrix
    meshCount*: cint
    materialCount*: cint
    meshes*: ptr Mesh
    materials*: ptr Material
    meshMaterial*: ptr cint
    boneCount*: cint
    bones*: ptr BoneInfo
    bindPose*: ptr Transform

type
  ModelAnimation* {.bycopy.} = object
    boneCount*: cint
    frameCount*: cint
    bones*: ptr BoneInfo
    framePoses*: ptr ptr Transform

type
  Ray* {.bycopy.} = object
    position*: Vector3
    direction*: Vector3

type
  RayHitInfo* {.bycopy.} = object
    hit*: bool
    distance*: cfloat
    position*: Vector3
    normal*: Vector3

type
  BoundingBox* {.bycopy.} = object
    min*: Vector3
    max*: Vector3

type
  Wave* {.bycopy.} = object
    sampleCount*: cuint
    sampleRate*: cuint
    sampleSize*: cuint
    channels*: cuint
    data*: pointer

type
  rAudioBuffer* {.bycopy.} = object

type
  AudioStream* {.bycopy.} = object
    buffer*: ptr rAudioBuffer
    sampleRate*: cuint
    sampleSize*: cuint
    channels*: cuint

type
  Sound* {.bycopy.} = object
    stream*: AudioStream
    sampleCount*: cuint

type
  Music* {.bycopy.} = object
    stream*: AudioStream
    sampleCount*: cuint
    looping*: bool
    ctxType*: cint
    ctxData*: pointer

type
  VrDeviceInfo* {.bycopy.} = object
    hResolution*: cint
    vResolution*: cint
    hScreenSize*: cfloat
    vScreenSize*: cfloat
    vScreenCenter*: cfloat
    eyeToScreenDistance*: cfloat
    lensSeparationDistance*: cfloat
    interpupillaryDistance*: cfloat
    lensDistortionValues*: array[4, cfloat]
    chromaAbCorrection*: array[4, cfloat]

type
  VaList* {.importc: "va_list", header: "<stdarg.h>".} = object

type
  TraceLogCallback* = proc(logType: cint; text: cstring; args: VaList) {.cdecl.}

const
  LIGHTGRAY* = Color(r: 200.cuchar, g: 200.cuchar, b: 200.cuchar, a: 255.cuchar)
  GRAY* = Color(r: 130.cuchar, g: 130.cuchar, b: 130.cuchar, a: 255.cuchar)
  DARKGRAY* = Color(r: 80.cuchar, g: 80.cuchar, b: 80.cuchar, a: 255.cuchar)
  YELLOW* = Color(r: 253.cuchar, g: 249.cuchar, b: 0.cuchar, a: 255.cuchar)
  GOLD* = Color(r: 255.cuchar, g: 203.cuchar, b: 0.cuchar, a: 255.cuchar)
  ORANGE* = Color(r: 255.cuchar, g: 161.cuchar, b: 0.cuchar, a: 255.cuchar)
  PINK* = Color(r: 255.cuchar, g: 109.cuchar, b: 194.cuchar, a: 255.cuchar)
  RED* = Color(r: 230.cuchar, g: 41.cuchar, b: 55.cuchar, a: 255.cuchar)
  MAROON* = Color(r: 190.cuchar, g: 33.cuchar, b: 55.cuchar, a: 255.cuchar)
  GREEN* = Color(r: 0.cuchar, g: 228.cuchar, b: 48.cuchar, a: 255.cuchar)
  LIME* = Color(r: 0.cuchar, g: 158.cuchar, b: 47.cuchar, a: 255.cuchar)
  DARKGREEN* = Color(r: 0.cuchar, g: 117.cuchar, b: 44.cuchar, a: 255.cuchar)
  SKYBLUE* = Color(r: 102.cuchar, g: 191.cuchar, b: 255.cuchar, a: 255.cuchar)
  BLUE* = Color(r: 0.cuchar, g: 121.cuchar, b: 241.cuchar, a: 255.cuchar)
  DARKBLUE* = Color(r: 0.cuchar, g: 82.cuchar, b: 172.cuchar, a: 255.cuchar)
  PURPLE* = Color(r: 200.cuchar, g: 122.cuchar, b: 255.cuchar, a: 255.cuchar)
  VIOLET* = Color(r: 135.cuchar, g: 60.cuchar, b: 190.cuchar, a: 255.cuchar)
  DARKPURPLE* = Color(r: 112.cuchar, g: 31.cuchar, b: 126.cuchar, a: 255.cuchar)
  BEIGE* = Color(r: 211.cuchar, g: 176.cuchar, b: 131.cuchar, a: 255.cuchar)
  BROWN* = Color(r: 127.cuchar, g: 106.cuchar, b: 79.cuchar, a: 255.cuchar)
  DARKBROWN* = Color(r: 76.cuchar, g: 63.cuchar, b: 47.cuchar, a: 255.cuchar)

  WHITE* = Color(r: 255.cuchar, g: 255.cuchar, b: 255.cuchar, a: 255.cuchar)
  BLACK* = Color(r: 0.cuchar, g: 0.cuchar, b: 0.cuchar, a: 255.cuchar)
  BLANK* = Color(r: 0.cuchar, g: 0.cuchar, b: 0.cuchar, a: 0.cuchar)
  MAGENTA* = Color(r: 255.cuchar, g: 0.cuchar, b: 255.cuchar, a: 255.cuchar)
  RAYWHITE* = Color(r: 245.cuchar, g: 245.cuchar, b: 245.cuchar, a: 255.cuchar)

template FormatText*(text: cstring; args: varargs[untyped]): cstring =
  TextFormat(text, args)
template LoadText*(fileName: cstring): cstring =
  LoadFileText(fileName)
template GetExtension*(filename: cstring) =
  GetFileExtension(filename)
template GetImageData*(image: Image) =
  LoadImageColors(image)

when defined(emscripten):
  {.push cdecl, importc.}
else:
  {.push cdecl, dynlib: LIB_RAYLIB, importc.}

proc InitWindow*(width: cint; height: cint; title: cstring)
proc WindowShouldClose*(): bool
proc CloseWindow*()
proc IsWindowReady*(): bool
proc IsWindowFullscreen*(): bool
proc IsWindowHidden*(): bool
proc IsWindowMinimized*(): bool
proc IsWindowMaximized*(): bool
proc IsWindowFocused*(): bool
proc IsWindowResized*(): bool
proc IsWindowState*(flag: cuint): bool
proc SetWindowState*(flags: cuint)
proc ClearWindowState*(flags: cuint)
proc ToggleFullscreen*()
proc MaximizeWindow*()
proc MinimizeWindow*()
proc RestoreWindow*()
proc SetWindowIcon*(image: Image)
proc SetWindowTitle*(title: cstring)
proc SetWindowPosition*(x: cint; y: cint)
proc SetWindowMonitor*(monitor: cint)
proc SetWindowMinSize*(width: cint; height: cint)
proc SetWindowSize*(width: cint; height: cint)
proc GetWindowHandle*(): pointer
proc GetScreenWidth*(): cint
proc GetScreenHeight*(): cint
proc GetMonitorCount*(): cint
proc GetMonitorPosition*(monitor: cint): Vector2
proc GetMonitorWidth*(monitor: cint): cint
proc GetMonitorHeight*(monitor: cint): cint
proc GetMonitorPhysicalWidth*(monitor: cint): cint
proc GetMonitorPhysicalHeight*(monitor: cint): cint
proc GetMonitorRefreshRate*(monitor: cint): cint
proc GetWindowPosition*(): Vector2
proc GetWindowScaleDPI*(): Vector2
proc GetMonitorName*(monitor: cint): cstring
proc SetClipboardText*(text: cstring)
proc GetClipboardText*(): cstring
proc ShowCursor*()
proc HideCursor*()
proc IsCursorHidden*(): bool
proc EnableCursor*()
proc DisableCursor*()
proc IsCursorOnScreen*(): bool
proc ClearBackground*(color: Color)
proc BeginDrawing*()
proc EndDrawing*()
proc BeginMode2D*(camera: Camera2D)
proc EndMode2D*()
proc BeginMode3D*(camera: Camera3D)
proc EndMode3D*()
proc BeginTextureMode*(target: RenderTexture2D)
proc EndTextureMode*()
proc BeginScissorMode*(x: cint; y: cint; width: cint; height: cint)
proc EndScissorMode*()
proc GetMouseRay*(mousePosition: Vector2; camera: Camera): Ray
proc GetCameraMatrix*(camera: Camera): Matrix
proc GetCameraMatrix2D*(camera: Camera2D): Matrix
proc GetWorldToScreen*(position: Vector3; camera: Camera): Vector2
proc GetWorldToScreenEx*(position: Vector3; camera: Camera; width: cint;
    height: cint): Vector2
proc GetWorldToScreen2D*(position: Vector2; camera: Camera2D): Vector2
proc GetScreenToWorld2D*(position: Vector2; camera: Camera2D): Vector2
proc SetTargetFPS*(fps: cint)
proc GetFPS*(): cint
proc GetFrameTime*(): cfloat
proc GetTime*(): cdouble
proc SetConfigFlags*(flags: cuint)
proc SetTraceLogLevel*(logType: cint)
proc SetTraceLogExit*(logType: cint)
proc SetTraceLogCallback*(callback: TraceLogCallback)
proc TraceLog*(logType: cint; text: cstring) {.varargs.}
proc MemAlloc*(size: cint): pointer
proc MemFree*(`ptr`: pointer)
proc TakeScreenshot*(fileName: cstring)
proc GetRandomValue*(min: cint; max: cint): cint
proc LoadFileData*(fileName: cstring; bytesRead: ptr cuint): ptr cuchar
proc UnloadFileData*(data: ptr cuchar)
proc SaveFileData*(fileName: cstring; data: pointer; bytesToWrite: cuint): bool
proc LoadFileText*(fileName: cstring): cstring
proc UnloadFileText*(text: ptr cuchar)
proc SaveFileText*(fileName: cstring; text: cstring): bool
proc FileExists*(fileName: cstring): bool
proc DirectoryExists*(dirPath: cstring): bool
proc IsFileExtension*(fileName: cstring; ext: cstring): bool
proc GetFileExtension*(fileName: cstring): cstring
proc GetFileName*(filePath: cstring): cstring
proc GetFileNameWithoutExt*(filePath: cstring): cstring
proc GetDirectoryPath*(filePath: cstring): cstring
proc GetPrevDirectoryPath*(dirPath: cstring): cstring
proc GetWorkingDirectory*(): cstring
proc GetDirectoryFiles*(dirPath: cstring; count: ptr cint): cstringArray
proc ClearDirectoryFiles*()
proc ChangeDirectory*(dir: cstring): bool
proc IsFileDropped*(): bool
proc GetDroppedFiles*(count: ptr cint): cstringArray
proc ClearDroppedFiles*()
proc GetFileModTime*(fileName: cstring): clong
proc CompressData*(data: ptr cuchar; dataLength: cint;
    compDataLength: ptr cint): ptr cuchar
proc DecompressData*(compData: ptr cuchar; compDataLength: cint;
    dataLength: ptr cint): ptr cuchar
proc SaveStorageValue*(position: cuint; value: cint): bool
proc LoadStorageValue*(position: cuint): cint
proc OpenURL*(url: cstring)
proc IsKeyPressed*(key: cint): bool
proc IsKeyDown*(key: cint): bool
proc IsKeyReleased*(key: cint): bool
proc IsKeyUp*(key: cint): bool
proc SetExitKey*(key: cint)
proc GetKeyPressed*(): cint
proc GetCharPressed*(): cint
proc IsGamepadAvailable*(gamepad: cint): bool
proc IsGamepadName*(gamepad: cint; name: cstring): bool
proc GetGamepadName*(gamepad: cint): cstring
proc IsGamepadButtonPressed*(gamepad: cint; button: cint): bool
proc IsGamepadButtonDown*(gamepad: cint; button: cint): bool
proc IsGamepadButtonReleased*(gamepad: cint; button: cint): bool
proc IsGamepadButtonUp*(gamepad: cint; button: cint): bool
proc GetGamepadButtonPressed*(): cint
proc GetGamepadAxisCount*(gamepad: cint): cint
proc GetGamepadAxisMovement*(gamepad: cint; axis: cint): cfloat
proc IsMouseButtonPressed*(button: cint): bool
proc IsMouseButtonDown*(button: cint): bool
proc IsMouseButtonReleased*(button: cint): bool
proc IsMouseButtonUp*(button: cint): bool
proc GetMouseX*(): cint
proc GetMouseY*(): cint
proc GetMousePosition*(): Vector2
proc SetMousePosition*(x: cint; y: cint)
proc SetMouseOffset*(offsetX: cint; offsetY: cint)
proc SetMouseScale*(scaleX: cfloat; scaleY: cfloat)
proc GetMouseWheelMove*(): cfloat
proc GetMouseCursor*(): cint
proc SetMouseCursor*(cursor: cint)
proc GetTouchX*(): cint
proc GetTouchY*(): cint
proc GetTouchPosition*(index: cint): Vector2
proc SetGesturesEnabled*(gestureFlags: cuint)
proc IsGestureDetected*(gesture: cint): bool
proc GetGestureDetected*(): cint
proc GetTouchPointsCount*(): cint
proc GetGestureHoldDuration*(): cfloat
proc GetGestureDragVector*(): Vector2
proc GetGestureDragAngle*(): cfloat
proc GetGesturePinchVector*(): Vector2
proc GetGesturePinchAngle*(): cfloat
proc SetCameraMode*(camera: Camera; mode: cint)
proc UpdateCamera*(camera: ptr Camera)
proc SetCameraPanControl*(keyPan: cint)
proc SetCameraAltControl*(keyAlt: cint)
proc SetCameraSmoothZoomControl*(keySmoothZoom: cint)
proc SetCameraMoveControls*(keyFront: cint; keyBack: cint; keyRight: cint;
                           keyLeft: cint; keyUp: cint; keyDown: cint)
proc DrawPixel*(posX: cint; posY: cint; color: Color)
proc DrawPixelV*(position: Vector2; color: Color)
proc DrawLine*(startPosX: cint; startPosY: cint; endPosX: cint; endPosY: cint;
              color: Color)
proc DrawLineV*(startPos: Vector2; endPos: Vector2; color: Color)
proc DrawLineEx*(startPos: Vector2; endPos: Vector2; thick: cfloat; color: Color)
proc DrawLineBezier*(startPos: Vector2; endPos: Vector2; thick: cfloat; color: Color)
proc DrawLineStrip*(points: ptr Vector2; pointsCount: cint; color: Color)
proc DrawCircle*(centerX: cint; centerY: cint; radius: cfloat; color: Color)
proc DrawCircleSector*(center: Vector2; radius: cfloat; startAngle: cint;
                      endAngle: cint; segments: cint; color: Color)
proc DrawCircleSectorLines*(center: Vector2; radius: cfloat; startAngle: cint;
                           endAngle: cint; segments: cint; color: Color)
proc DrawCircleGradient*(centerX: cint; centerY: cint; radius: cfloat; color1: Color;
                        color2: Color)
proc DrawCircleV*(center: Vector2; radius: cfloat; color: Color)
proc DrawCircleLines*(centerX: cint; centerY: cint; radius: cfloat; color: Color)
proc DrawEllipse*(centerX: cint; centerY: cint; radiusH: cfloat; radiusV: cfloat;
                 color: Color)
proc DrawEllipseLines*(centerX: cint; centerY: cint; radiusH: cfloat; radiusV: cfloat;
                      color: Color)
proc DrawRing*(center: Vector2; innerRadius: cfloat; outerRadius: cfloat;
              startAngle: cint; endAngle: cint; segments: cint; color: Color)
proc DrawRingLines*(center: Vector2; innerRadius: cfloat; outerRadius: cfloat;
                   startAngle: cint; endAngle: cint; segments: cint; color: Color)
proc DrawRectangle*(posX: cint; posY: cint; width: cint; height: cint; color: Color)
proc DrawRectangleV*(position: Vector2; size: Vector2; color: Color)
proc DrawRectangleRec*(rec: Rectangle; color: Color)
proc DrawRectanglePro*(rec: Rectangle; origin: Vector2; rotation: cfloat; color: Color)
proc DrawRectangleGradientV*(posX: cint; posY: cint; width: cint; height: cint;
                            color1: Color; color2: Color)
proc DrawRectangleGradientH*(posX: cint; posY: cint; width: cint; height: cint;
                            color1: Color; color2: Color)
proc DrawRectangleGradientEx*(rec: Rectangle; col1: Color; col2: Color; col3: Color;
                             col4: Color)
proc DrawRectangleLines*(posX: cint; posY: cint; width: cint; height: cint; color: Color)
proc DrawRectangleLinesEx*(rec: Rectangle; lineThick: cint; color: Color)
proc DrawRectangleRounded*(rec: Rectangle; roundness: cfloat; segments: cint;
                          color: Color)
proc DrawRectangleRoundedLines*(rec: Rectangle; roundness: cfloat; segments: cint;
                               lineThick: cint; color: Color)
proc DrawTriangle*(v1: Vector2; v2: Vector2; v3: Vector2; color: Color)
proc DrawTriangleLines*(v1: Vector2; v2: Vector2; v3: Vector2; color: Color)
proc DrawTriangleFan*(points: ptr Vector2; pointsCount: cint; color: Color)
proc DrawTriangleStrip*(points: ptr Vector2; pointsCount: cint; color: Color)
proc DrawPoly*(center: Vector2; sides: cint; radius: cfloat; rotation: cfloat;
              color: Color)
proc DrawPolyLines*(center: Vector2; sides: cint; radius: cfloat; rotation: cfloat;
                   color: Color)
proc CheckCollisionRecs*(rec1: Rectangle; rec2: Rectangle): bool
proc CheckCollisionCircles*(center1: Vector2; radius1: cfloat; center2: Vector2;
                           radius2: cfloat): bool
proc CheckCollisionCircleRec*(center: Vector2; radius: cfloat;
    rec: Rectangle): bool
proc CheckCollisionPointRec*(point: Vector2; rec: Rectangle): bool
proc CheckCollisionPointCircle*(point: Vector2; center: Vector2;
    radius: cfloat): bool
proc CheckCollisionPointTriangle*(point: Vector2; p1: Vector2; p2: Vector2;
    p3: Vector2): bool
proc CheckCollisionLines*(startPos1: Vector2; endPos1: Vector2; startPos2: Vector2;
                         endPos2: Vector2; collisionPoint: ptr Vector2): bool
proc GetCollisionRec*(rec1: Rectangle; rec2: Rectangle): Rectangle
proc LoadImage*(fileName: cstring): Image
proc LoadImageRaw*(fileName: cstring; width: cint; height: cint; format: cint;
                  headerSize: cint): Image
proc LoadImageAnim*(fileName: cstring; frames: ptr cint): Image
proc LoadImageFromMemory*(fileType: cstring; fileData: ptr cuchar;
    dataSize: cint): Image
proc UnloadImage*(image: Image)
proc ExportImage*(image: Image; fileName: cstring): bool
proc ExportImageAsCode*(image: Image; fileName: cstring): bool
proc GenImageColor*(width: cint; height: cint; color: Color): Image
proc GenImageGradientV*(width: cint; height: cint; top: Color;
    bottom: Color): Image
proc GenImageGradientH*(width: cint; height: cint; left: Color;
    right: Color): Image
proc GenImageGradientRadial*(width: cint; height: cint; density: cfloat; inner: Color;
                            outer: Color): Image
proc GenImageChecked*(width: cint; height: cint; checksX: cint; checksY: cint;
                     col1: Color; col2: Color): Image
proc GenImageWhiteNoise*(width: cint; height: cint; factor: cfloat): Image
proc GenImagePerlinNoise*(width: cint; height: cint; offsetX: cint; offsetY: cint;
                         scale: cfloat): Image
proc GenImageCellular*(width: cint; height: cint; tileSize: cint): Image
proc ImageCopy*(image: Image): Image
proc ImageFromImage*(image: Image; rec: Rectangle): Image
proc ImageText*(text: cstring; fontSize: cint; color: Color): Image
proc ImageTextEx*(font: Font; text: cstring; fontSize: cfloat; spacing: cfloat;
                 tint: Color): Image
proc ImageFormat*(image: ptr Image; newFormat: cint)
proc ImageToPOT*(image: ptr Image; fill: Color)
proc ImageCrop*(image: ptr Image; crop: Rectangle)
proc ImageAlphaCrop*(image: ptr Image; threshold: cfloat)
proc ImageAlphaClear*(image: ptr Image; color: Color; threshold: cfloat)
proc ImageAlphaMask*(image: ptr Image; alphaMask: Image)
proc ImageAlphaPremultiply*(image: ptr Image)
proc ImageResize*(image: ptr Image; newWidth: cint; newHeight: cint)
proc ImageResizeNN*(image: ptr Image; newWidth: cint; newHeight: cint)
proc ImageResizeCanvas*(image: ptr Image; newWidth: cint; newHeight: cint;
                       offsetX: cint; offsetY: cint; fill: Color)
proc ImageMipmaps*(image: ptr Image)
proc ImageDither*(image: ptr Image; rBpp: cint; gBpp: cint; bBpp: cint; aBpp: cint)
proc ImageFlipVertical*(image: ptr Image)
proc ImageFlipHorizontal*(image: ptr Image)
proc ImageRotateCW*(image: ptr Image)
proc ImageRotateCCW*(image: ptr Image)
proc ImageColorTint*(image: ptr Image; color: Color)
proc ImageColorInvert*(image: ptr Image)
proc ImageColorGrayscale*(image: ptr Image)
proc ImageColorContrast*(image: ptr Image; contrast: cfloat)
proc ImageColorBrightness*(image: ptr Image; brightness: cint)
proc ImageColorReplace*(image: ptr Image; color: Color; replace: Color)
proc LoadImageColors*(image: Image): ptr Color
proc LoadImagePalette*(image: Image; maxPaletteSize: cint;
    colorsCount: ptr cint): ptr Color
proc UnloadImageColors*(colors: ptr Color)
proc UnloadImagePalette*(colors: ptr Color)
proc GetImageAlphaBorder*(image: Image; threshold: cfloat): Rectangle
proc ImageClearBackground*(dst: ptr Image; color: Color)
proc ImageDrawPixel*(dst: ptr Image; posX: cint; posY: cint; color: Color)
proc ImageDrawPixelV*(dst: ptr Image; position: Vector2; color: Color)
proc ImageDrawLine*(dst: ptr Image; startPosX: cint; startPosY: cint; endPosX: cint;
                   endPosY: cint; color: Color)
proc ImageDrawLineV*(dst: ptr Image; start: Vector2; `end`: Vector2; color: Color)
proc ImageDrawCircle*(dst: ptr Image; centerX: cint; centerY: cint; radius: cint;
                     color: Color)
proc ImageDrawCircleV*(dst: ptr Image; center: Vector2; radius: cint; color: Color)
proc ImageDrawRectangle*(dst: ptr Image; posX: cint; posY: cint; width: cint;
                        height: cint; color: Color)
proc ImageDrawRectangleV*(dst: ptr Image; position: Vector2; size: Vector2; color: Color)
proc ImageDrawRectangleRec*(dst: ptr Image; rec: Rectangle; color: Color)
proc ImageDrawRectangleLines*(dst: ptr Image; rec: Rectangle; thick: cint; color: Color)
proc ImageDraw*(dst: ptr Image; src: Image; srcRec: Rectangle; dstRec: Rectangle;
               tint: Color)
proc ImageDrawText*(dst: ptr Image; text: cstring; posX: cint; posY: cint; fontSize: cint;
                   color: Color)
proc ImageDrawTextEx*(dst: ptr Image; font: Font; text: cstring; position: Vector2;
                     fontSize: cfloat; spacing: cfloat; tint: Color)
proc LoadTexture*(fileName: cstring): Texture2D
proc LoadTextureFromImage*(image: Image): Texture2D
proc LoadTextureCubemap*(image: Image; layoutType: cint): TextureCubemap
proc LoadRenderTexture*(width: cint; height: cint): RenderTexture2D
proc UnloadTexture*(texture: Texture2D)
proc UnloadRenderTexture*(target: RenderTexture2D)
proc UpdateTexture*(texture: Texture2D; pixels: pointer)
proc UpdateTextureRec*(texture: Texture2D; rec: Rectangle; pixels: pointer)
proc GetTextureData*(texture: Texture2D): Image
proc GetScreenData*(): Image
proc GenTextureMipmaps*(texture: ptr Texture2D)
proc SetTextureFilter*(texture: Texture2D; filterMode: cint)
proc SetTextureWrap*(texture: Texture2D; wrapMode: cint)
proc DrawTexture*(texture: Texture2D; posX: cint; posY: cint; tint: Color)
proc DrawTextureV*(texture: Texture2D; position: Vector2; tint: Color)
proc DrawTextureEx*(texture: Texture2D; position: Vector2; rotation: cfloat;
                   scale: cfloat; tint: Color)
proc DrawTextureRec*(texture: Texture2D; source: Rectangle; position: Vector2;
                    tint: Color)
proc DrawTextureQuad*(texture: Texture2D; tiling: Vector2; offset: Vector2;
                     quad: Rectangle; tint: Color)
proc DrawTextureTiled*(texture: Texture2D; source: Rectangle; dest: Rectangle;
                      origin: Vector2; rotation: cfloat; scale: cfloat; tint: Color)
proc DrawTexturePro*(texture: Texture2D; source: Rectangle; dest: Rectangle;
                    origin: Vector2; rotation: cfloat; tint: Color)
proc DrawTextureNPatch*(texture: Texture2D; nPatchInfo: NPatchInfo; dest: Rectangle;
                       origin: Vector2; rotation: cfloat; tint: Color)
proc Fade*(color: Color; alpha: cfloat): Color
proc ColorToInt*(color: Color): cint
proc ColorNormalize*(color: Color): Vector4
proc ColorFromNormalized*(normalized: Vector4): Color
proc ColorToHSV*(color: Color): Vector3
proc ColorFromHSV*(hue: cfloat; saturation: cfloat; value: cfloat): Color
proc ColorAlpha*(color: Color; alpha: cfloat): Color
proc ColorAlphaBlend*(dst: Color; src: Color; tint: Color): Color
proc GetColor*(hexValue: cint): Color
proc GetPixelColor*(srcPtr: pointer; format: cint): Color
proc SetPixelColor*(dstPtr: pointer; color: Color; format: cint)
proc GetPixelDataSize*(width: cint; height: cint; format: cint): cint
proc GetFontDefault*(): Font
proc LoadFont*(fileName: cstring): Font
proc LoadFontEx*(fileName: cstring; fontSize: cint; fontChars: ptr cint;
                charsCount: cint): Font
proc LoadFontFromImage*(image: Image; key: Color; firstChar: cint): Font
proc LoadFontFromMemory*(fileType: cstring; fileData: ptr cuchar; dataSize: cint;
                        fontSize: cint; fontChars: ptr cint;
                            charsCount: cint): Font
proc LoadFontData*(fileData: ptr cuchar; dataSize: cint; fontSize: cint;
                  fontChars: ptr cint; charsCount: cint;
                      `type`: cint): ptr CharInfo
proc GenImageFontAtlas*(chars: ptr CharInfo; recs: ptr ptr Rectangle; charsCount: cint;
                       fontSize: cint; padding: cint; packMethod: cint): Image
proc UnloadFontData*(chars: ptr CharInfo; charsCount: cint)
proc UnloadFont*(font: Font)
proc DrawFPS*(posX: cint; posY: cint)
proc DrawText*(text: cstring; posX: cint; posY: cint; fontSize: cint; color: Color)
proc DrawTextEx*(font: Font; text: cstring; position: Vector2; fontSize: cfloat;
                spacing: cfloat; tint: Color)
proc DrawTextRec*(font: Font; text: cstring; rec: Rectangle; fontSize: cfloat;
                 spacing: cfloat; wordWrap: bool; tint: Color)
proc DrawTextRecEx*(font: Font; text: cstring; rec: Rectangle; fontSize: cfloat;
                   spacing: cfloat; wordWrap: bool; tint: Color;
                       selectStart: cint;
                   selectLength: cint; selectTint: Color; selectBackTint: Color)
proc DrawTextCodepoint*(font: Font; codepoint: cint; position: Vector2;
                       fontSize: cfloat; tint: Color)
proc MeasureText*(text: cstring; fontSize: cint): cint
proc MeasureTextEx*(font: Font; text: cstring; fontSize: cfloat;
    spacing: cfloat): Vector2
proc GetGlyphIndex*(font: Font; codepoint: cint): cint
proc TextCopy*(dst: cstring; src: cstring): cint
proc TextIsEqual*(text1: cstring; text2: cstring): bool
proc TextLength*(text: cstring): cuint
proc TextFormat*(text: cstring): cstring {.varargs.}
proc TextSubtext*(text: cstring; position: cint; length: cint): cstring
proc TextReplace*(text: cstring; replace: cstring; by: cstring): cstring
proc TextInsert*(text: cstring; insert: cstring; position: cint): cstring
proc TextJoin*(textList: cstringArray; count: cint; delimiter: cstring): cstring
proc TextSplit*(text: cstring; delimiter: char; count: ptr cint): cstringArray
proc TextAppend*(text: cstring; append: cstring; position: ptr cint)
proc TextFindIndex*(text: cstring; find: cstring): cint
proc TextToUpper*(text: cstring): cstring
proc TextToLower*(text: cstring): cstring
proc TextToPascal*(text: cstring): cstring
proc TextToInteger*(text: cstring): cint
proc TextToUtf8*(codepoints: ptr cint; length: cint): cstring
proc GetCodepoints*(text: cstring; count: ptr cint): ptr cint
proc GetCodepointsCount*(text: cstring): cint
proc GetNextCodepoint*(text: cstring; bytesProcessed: ptr cint): cint
proc CodepointToUtf8*(codepoint: cint; byteLength: ptr cint): cstring
proc DrawLine3D*(startPos: Vector3; endPos: Vector3; color: Color)
proc DrawPoint3D*(position: Vector3; color: Color)
proc DrawCircle3D*(center: Vector3; radius: cfloat; rotationAxis: Vector3;
                  rotationAngle: cfloat; color: Color)
proc DrawTriangle3D*(v1: Vector3; v2: Vector3; v3: Vector3; color: Color)
proc DrawTriangleStrip3D*(points: ptr Vector3; pointsCount: cint; color: Color)
proc DrawCube*(position: Vector3; width: cfloat; height: cfloat; length: cfloat;
              color: Color)
proc DrawCubeV*(position: Vector3; size: Vector3; color: Color)
proc DrawCubeWires*(position: Vector3; width: cfloat; height: cfloat; length: cfloat;
                   color: Color)
proc DrawCubeWiresV*(position: Vector3; size: Vector3; color: Color)
proc DrawCubeTexture*(texture: Texture2D; position: Vector3; width: cfloat;
                     height: cfloat; length: cfloat; color: Color)
proc DrawSphere*(centerPos: Vector3; radius: cfloat; color: Color)
proc DrawSphereEx*(centerPos: Vector3; radius: cfloat; rings: cint; slices: cint;
                  color: Color)
proc DrawSphereWires*(centerPos: Vector3; radius: cfloat; rings: cint; slices: cint;
                     color: Color)
proc DrawCylinder*(position: Vector3; radiusTop: cfloat; radiusBottom: cfloat;
                  height: cfloat; slices: cint; color: Color)
proc DrawCylinderWires*(position: Vector3; radiusTop: cfloat; radiusBottom: cfloat;
                       height: cfloat; slices: cint; color: Color)
proc DrawPlane*(centerPos: Vector3; size: Vector2; color: Color)
proc DrawRay*(ray: Ray; color: Color)
proc DrawGrid*(slices: cint; spacing: cfloat)
proc DrawGizmo*(position: Vector3)
proc LoadModel*(fileName: cstring): Model
proc LoadModelFromMesh*(mesh: Mesh): Model
proc UnloadModel*(model: Model)
proc UnloadModelKeepMeshes*(model: Model)
proc LoadMeshes*(fileName: cstring; meshCount: ptr cint): ptr Mesh
proc UnloadMesh*(mesh: Mesh)
proc ExportMesh*(mesh: Mesh; fileName: cstring): bool
proc LoadMaterials*(fileName: cstring; materialCount: ptr cint): ptr Material
proc LoadMaterialDefault*(): Material
proc UnloadMaterial*(material: Material)
proc SetMaterialTexture*(material: ptr Material; mapType: cint;
    texture: Texture2D)
proc SetModelMeshMaterial*(model: ptr Model; meshId: cint; materialId: cint)
proc LoadModelAnimations*(fileName: cstring;
    animsCount: ptr cint): ptr ModelAnimation
proc UpdateModelAnimation*(model: Model; anim: ModelAnimation; frame: cint)
proc UnloadModelAnimation*(anim: ModelAnimation)
proc IsModelAnimationValid*(model: Model; anim: ModelAnimation): bool
proc GenMeshPoly*(sides: cint; radius: cfloat): Mesh
proc GenMeshPlane*(width: cfloat; length: cfloat; resX: cint; resZ: cint): Mesh
proc GenMeshCube*(width: cfloat; height: cfloat; length: cfloat): Mesh
proc GenMeshSphere*(radius: cfloat; rings: cint; slices: cint): Mesh
proc GenMeshHemiSphere*(radius: cfloat; rings: cint; slices: cint): Mesh
proc GenMeshCylinder*(radius: cfloat; height: cfloat; slices: cint): Mesh
proc GenMeshTorus*(radius: cfloat; size: cfloat; radSeg: cint;
    sides: cint): Mesh
proc GenMeshKnot*(radius: cfloat; size: cfloat; radSeg: cint; sides: cint): Mesh
proc GenMeshHeightmap*(heightmap: Image; size: Vector3): Mesh
proc GenMeshCubicmap*(cubicmap: Image; cubeSize: Vector3): Mesh
proc MeshBoundingBox*(mesh: Mesh): BoundingBox
proc MeshTangents*(mesh: ptr Mesh)
proc MeshBinormals*(mesh: ptr Mesh)
proc MeshNormalsSmooth*(mesh: ptr Mesh)
proc DrawModel*(model: Model; position: Vector3; scale: cfloat; tint: Color)
proc DrawModelEx*(model: Model; position: Vector3; rotationAxis: Vector3;
                 rotationAngle: cfloat; scale: Vector3; tint: Color)
proc DrawModelWires*(model: Model; position: Vector3; scale: cfloat; tint: Color)
proc DrawModelWiresEx*(model: Model; position: Vector3; rotationAxis: Vector3;
                      rotationAngle: cfloat; scale: Vector3; tint: Color)
proc DrawBoundingBox*(box: BoundingBox; color: Color)
proc DrawBillboard*(camera: Camera; texture: Texture2D; center: Vector3; size: cfloat;
                   tint: Color)
proc DrawBillboardRec*(camera: Camera; texture: Texture2D; source: Rectangle;
                      center: Vector3; size: cfloat; tint: Color)
proc CheckCollisionSpheres*(center1: Vector3; radius1: cfloat; center2: Vector3;
                           radius2: cfloat): bool
proc CheckCollisionBoxes*(box1: BoundingBox; box2: BoundingBox): bool
proc CheckCollisionBoxSphere*(box: BoundingBox; center: Vector3;
    radius: cfloat): bool
proc CheckCollisionRaySphere*(ray: Ray; center: Vector3; radius: cfloat): bool
proc CheckCollisionRaySphereEx*(ray: Ray; center: Vector3; radius: cfloat;
                               collisionPoint: ptr Vector3): bool
proc CheckCollisionRayBox*(ray: Ray; box: BoundingBox): bool
proc GetCollisionRayMesh*(ray: Ray; mesh: Mesh; transform: Matrix): RayHitInfo
proc GetCollisionRayModel*(ray: Ray; model: Model): RayHitInfo
proc GetCollisionRayTriangle*(ray: Ray; p1: Vector3; p2: Vector3;
    p3: Vector3): RayHitInfo
proc GetCollisionRayGround*(ray: Ray; groundHeight: cfloat): RayHitInfo
proc LoadShader*(vsFileName: cstring; fsFileName: cstring): Shader
proc LoadShaderCode*(vsCode: cstring; fsCode: cstring): Shader
proc UnloadShader*(shader: Shader)
proc GetShaderDefault*(): Shader
proc GetTextureDefault*(): Texture2D
proc GetShapesTexture*(): Texture2D
proc GetShapesTextureRec*(): Rectangle
proc SetShapesTexture*(texture: Texture2D; source: Rectangle)
proc GetShaderLocation*(shader: Shader; uniformName: cstring): cint
proc GetShaderLocationAttrib*(shader: Shader; attribName: cstring): cint
proc SetShaderValue*(shader: Shader; uniformLoc: cint; value: pointer;
                    uniformType: cint)
proc SetShaderValueV*(shader: Shader; uniformLoc: cint; value: pointer;
                     uniformType: cint; count: cint)
proc SetShaderValueMatrix*(shader: Shader; uniformLoc: cint; mat: Matrix)
proc SetShaderValueTexture*(shader: Shader; uniformLoc: cint;
    texture: Texture2D)
proc SetMatrixProjection*(proj: Matrix)
proc SetMatrixModelview*(view: Matrix)
proc GetMatrixModelview*(): Matrix
proc GetMatrixProjection*(): Matrix
proc GenTextureCubemap*(shader: Shader; panorama: Texture2D; size: cint;
    format: cint): TextureCubemap
proc GenTextureIrradiance*(shader: Shader; cubemap: TextureCubemap;
    size: cint): TextureCubemap
proc GenTexturePrefilter*(shader: Shader; cubemap: TextureCubemap;
    size: cint): TextureCubemap
proc GenTextureBRDF*(shader: Shader; size: cint): Texture2D
proc BeginShaderMode*(shader: Shader)
proc EndShaderMode*()
proc BeginBlendMode*(mode: cint)
proc EndBlendMode*()
proc InitVrSimulator*()
proc CloseVrSimulator*()
proc UpdateVrTracking*(camera: ptr Camera)
proc SetVrConfiguration*(info: VrDeviceInfo; distortion: Shader)
proc IsVrSimulatorReady*(): bool
proc ToggleVrMode*()
proc BeginVrDrawing*()
proc EndVrDrawing*()
proc InitAudioDevice*()
proc CloseAudioDevice*()
proc IsAudioDeviceReady*(): bool
proc SetMasterVolume*(volume: cfloat)
proc LoadWave*(fileName: cstring): Wave
proc LoadWaveFromMemory*(fileType: cstring; fileData: ptr cuchar;
    dataSize: cint): Wave
proc LoadSound*(fileName: cstring): Sound
proc LoadSoundFromWave*(wave: Wave): Sound
proc UpdateSound*(sound: Sound; data: pointer; samplesCount: cint)
proc UnloadWave*(wave: Wave)
proc UnloadSound*(sound: Sound)
proc ExportWave*(wave: Wave; fileName: cstring): bool
proc ExportWaveAsCode*(wave: Wave; fileName: cstring): bool
proc PlaySound*(sound: Sound)
proc StopSound*(sound: Sound)
proc PauseSound*(sound: Sound)
proc ResumeSound*(sound: Sound)
proc PlaySoundMulti*(sound: Sound)
proc StopSoundMulti*()
proc GetSoundsPlaying*(): cint
proc IsSoundPlaying*(sound: Sound): bool
proc SetSoundVolume*(sound: Sound; volume: cfloat)
proc SetSoundPitch*(sound: Sound; pitch: cfloat)
proc WaveFormat*(wave: ptr Wave; sampleRate: cint; sampleSize: cint;
    channels: cint)
proc WaveCopy*(wave: Wave): Wave
proc WaveCrop*(wave: ptr Wave; initSample: cint; finalSample: cint)
proc LoadWaveSamples*(wave: Wave): ptr cfloat
proc UnloadWaveSamples*(samples: ptr cfloat)
proc LoadMusicStream*(fileName: cstring): Music
proc UnloadMusicStream*(music: Music)
proc PlayMusicStream*(music: Music)
proc UpdateMusicStream*(music: Music)
proc StopMusicStream*(music: Music)
proc PauseMusicStream*(music: Music)
proc ResumeMusicStream*(music: Music)
proc IsMusicPlaying*(music: Music): bool
proc SetMusicVolume*(music: Music; volume: cfloat)
proc SetMusicPitch*(music: Music; pitch: cfloat)
proc GetMusicTimeLength*(music: Music): cfloat
proc GetMusicTimePlayed*(music: Music): cfloat
proc InitAudioStream*(sampleRate: cuint; sampleSize: cuint;
    channels: cuint): AudioStream
proc UpdateAudioStream*(stream: AudioStream; data: pointer; samplesCount: cint)
proc CloseAudioStream*(stream: AudioStream)
proc IsAudioStreamProcessed*(stream: AudioStream): bool
proc PlayAudioStream*(stream: AudioStream)
proc PauseAudioStream*(stream: AudioStream)
proc ResumeAudioStream*(stream: AudioStream)
proc IsAudioStreamPlaying*(stream: AudioStream): bool
proc StopAudioStream*(stream: AudioStream)
proc SetAudioStreamVolume*(stream: AudioStream; volume: cfloat)
proc SetAudioStreamPitch*(stream: AudioStream; pitch: cfloat)
proc SetAudioStreamBufferSizeDefault*(size: cint)

{.pop.}
