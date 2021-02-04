when defined(unix):
  const LIB_RAYLIB* = "libraylib.so"
elif defined(macosx):
  const LIB_RAYLIB* = "libraylib.dylib"
elif defined(windows):
  const LIB_RAYLIB* = "raylib.dll"

##----------------------------------------------------------------------------------
## Some basic Defines
##----------------------------------------------------------------------------------

const
  PI* = 3.141592653589793
  DEG2RAD* = (PI / 180.0)
  RAD2DEG* = (180.0 / PI)
  MAX_TOUCH_POINTS* = 10

##----------------------------------------------------------------------------------
## Enumerators Definition
##----------------------------------------------------------------------------------

# System config flags
# NOTE: Used for bit masks
const
  FLAG_RESERVED* = 1 # Reserved
  FLAG_FULLSCREEN_MODE* = 2 # Set to run program in fullscreen
  FLAG_WINDOW_RESIZABLE* = 4 # Set to allow resizable window
  FLAG_WINDOW_UNDECORATED* = 8 # Set to disable window decoration (frame and buttons)
  FLAG_WINDOW_TRANSPARENT* = 16 # Set to allow transparent window
  FLAG_WINDOW_HIDDEN* = 128 # Set to create the window initially hidden
  FLAG_WINDOW_ALWAYS_RUN* = 256 # Set to allow windows running while minimized
  FLAG_MSAA_4X_HINT* = 32 # Set to try enabling MSAA 4X
  FLAG_VSYNC_HINT* = 64 # Set to try enabling V-Sync on GPU

# Trace log type
const
    LOG_ALL* = 0 # Display all logs
    LOG_TRACE* = 1
    LOG_DEBUG* = 2
    LOG_INFO* = 3
    LOG_WARNING* = 4
    LOG_ERROR* = 5
    LOG_FATAL* = 6
    LOG_NONE* = 7 # Disable logging

# Keyboard keys
const
  # Alphanumeric keys
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

  # Function keys
  KEY_SPACE* = 32
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
  KEY_LEFT_SHIFT* = 340
  KEY_LEFT_CONTROL* = 341
  KEY_LEFT_ALT* = 342
  KEY_LEFT_SUPER* = 343
  KEY_RIGHT_SHIFT* = 344
  KEY_RIGHT_CONTROL* = 345
  KEY_RIGHT_ALT* = 346
  KEY_RIGHT_SUPER* = 347
  KEY_KB_MENU* = 348
  KEY_LEFT_BRACKET* = 91
  KEY_BACKSLASH* = 92
  KEY_RIGHT_BRACKET* = 93
  KEY_GRAVE* = 96

  # Keypad keys
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

# Android buttons
const
  KEY_BACK* = 4
  KEY_MENU* = 82
  KEY_VOLUME_UP* = 24
  KEY_VOLUME_DOWN* = 25

# Mouse buttons
const
  MOUSE_LEFT_BUTTON* = 0
  MOUSE_RIGHT_BUTTON* = 1
  MOUSE_MIDDLE_BUTTON* = 2

# Gamepad number
const
  GAMEPAD_PLAYER1* = 0
  GAMEPAD_PLAYER2* = 1
  GAMEPAD_PLAYER3* = 2
  GAMEPAD_PLAYER4* = 3

# Gamepad Buttons
const
  # This is here just for error checking
  GAMEPAD_BUTTON_UNKNOWN* = 0

  # This is normally a DPAD
  GAMEPAD_BUTTON_LEFT_FACE_UP* = 1
  GAMEPAD_BUTTON_LEFT_FACE_RIGHT* = 2
  GAMEPAD_BUTTON_LEFT_FACE_DOWN* = 3
  GAMEPAD_BUTTON_LEFT_FACE_LEFT* = 4

  # This normally corresponds with PlayStation and Xbox controllers
  # XBOX: [Y,X,A,B]
  # PS3: [Triangle,Square,Cross,Circle]
  # No support for 6 button controllers though..
  GAMEPAD_BUTTON_RIGHT_FACE_UP* = 5
  GAMEPAD_BUTTON_RIGHT_FACE_RIGHT* = 6
  GAMEPAD_BUTTON_RIGHT_FACE_DOWN* = 7
  GAMEPAD_BUTTON_RIGHT_FACE_LEFT* = 8

  # Triggers
  GAMEPAD_BUTTON_LEFT_TRIGGER_1* = 9
  GAMEPAD_BUTTON_LEFT_TRIGGER_2* = 10
  GAMEPAD_BUTTON_RIGHT_TRIGGER_1* = 11
  GAMEPAD_BUTTON_RIGHT_TRIGGER_2* = 12

  # These are buttons in the center of the gamepad
  GAMEPAD_BUTTON_MIDDLE_LEFT* = 13
  GAMEPAD_BUTTON_MIDDLE* = 14
  GAMEPAD_BUTTON_MIDDLE_RIGHT* = 15

  # These are the joystick press in buttons
  GAMEPAD_BUTTON_LEFT_THUMB* = 16
  GAMEPAD_BUTTON_RIGHT_THUMB* = 17

const
  # This is here just for error checking
  GAMEPAD_AXIS_UNKNOWN* = 0

  # Left stick
  GAMEPAD_AXIS_LEFT_X* = 1
  GAMEPAD_AXIS_LEFT_Y* = 2

  # Right stick
  GAMEPAD_AXIS_RIGHT_X* = 3
  GAMEPAD_AXIS_RIGHT_Y* = 4

  # Pressure levels for the back triggers
  GAMEPAD_AXIS_LEFT_TRIGGER* = 5
  GAMEPAD_AXIS_RIGHT_TRIGGER* = 6

# Shader location point type
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
  LOC_MAP_ALBEDO* = 14 # LOC_MAP_DIFFUSE
  LOC_MAP_METALNESS* = 15 # LOC_MAP_SPECULAR
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

# Shader uniform data types
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

# Material map type
const
  MAP_ALBEDO* = 0 # MAP_DIFFUSE
  MAP_METALNESS* = 1 # MAP_SPECULAR
  MAP_NORMAL* = 2
  MAP_ROUGHNESS* = 3
  MAP_OCCLUSION* = 4
  MAP_EMISSION* = 5
  MAP_HEIGHT* = 6
  MAP_CUBEMAP* = 7 # NOTE: Uses GL_TEXTURE_CUBE_MAP
  MAP_IRRADIANCE* = 8 # NOTE: Uses GL_TEXTURE_CUBE_MAP
  MAP_PREFILTER* = 9 # NOTE: Uses GL_TEXTURE_CUBE_MAP
  MAP_BRDF* = 10

  MAP_DIFFUSE*  = MAP_ALBEDO
  MAP_SPECULAR* = MAP_METALNESS

# Pixel formats
# NOTE: Support depends on OpenGL version and platform
const
  UNCOMPRESSED_GRAYSCALE* = 1 # 8 bit per pixel (no alpha)
  UNCOMPRESSED_GRAY_ALPHA* = 2 # 8*2 bpp (2 channels)
  UNCOMPRESSED_R5G6B5* = 3 # 16 bpp
  UNCOMPRESSED_R8G8B8* = 4 # 24 bpp
  UNCOMPRESSED_R5G5B5A1* = 5 # 16 bpp (1 bit alpha)
  UNCOMPRESSED_R4G4B4A4* = 6 # 16 bpp (4 bit alpha)
  UNCOMPRESSED_R8G8B8A8* = 7 # 32 bpp
  UNCOMPRESSED_R32* = 8 # 32 bpp (1 channel - float)
  UNCOMPRESSED_R32G32B32* = 9 # 32*3 bpp (3 channels - float)
  UNCOMPRESSED_R32G32B32A32* = 10 # 32*4 bpp (4 channels - float)
  COMPRESSED_DXT1_RGB* = 11 # 4 bpp (no alpha)
  COMPRESSED_DXT1_RGBA* = 12 # 4 bpp (1 bit alpha)
  COMPRESSED_DXT3_RGBA* = 13 # 8 bpp
  COMPRESSED_DXT5_RGBA* = 14 # 8 bpp
  COMPRESSED_ETC1_RGB* = 15 # 4 bpp
  COMPRESSED_ETC2_RGB* = 16 # 4 bpp
  COMPRESSED_ETC2_EAC_RGBA* = 17 # 8 bpp
  COMPRESSED_PVRT_RGB* = 18 # 4 bpp
  COMPRESSED_PVRT_RGBA* = 19 # 4 bpp
  COMPRESSED_ASTC_4x4_RGBA* = 20 # 8 bpp
  COMPRESSED_ASTC_8x8_RGBA* = 21 # 2 bpp

# Texture parameters: filter mode
# NOTE 1: Filtering considers mipmaps if available in the texture
# NOTE 2: Filter is accordingly set for minification and magnification
const
  FILTER_POINT* = 0 # No filter, just pixel aproximation
  FILTER_BILINEAR* = 1 # Linear filtering
  FILTER_TRILINEAR* = 2 # Trilinear filtering (linear with mipmaps)
  FILTER_ANISOTROPIC_4X* = 3 # Anisotropic filtering 4x
  FILTER_ANISOTROPIC_8X* = 4 # Anisotropic filtering 8x
  FILTER_ANISOTROPIC_16X* = 5 # Anisotropic filtering 16x

# Cubemap layout type
const
  CUBEMAP_AUTO_DETECT* = 0 # Automatically detect layout type
  CUBEMAP_LINE_VERTICAL* = 1 # Layout is defined by a vertical line with faces
  CUBEMAP_LINE_HORIZONTAL* = 2 # Layout is defined by an horizontal line with faces
  CUBEMAP_CROSS_THREE_BY_FOUR* = 3 # Layout is defined by a 3x4 cross with cubemap faces
  CUBEMAP_CROSS_FOUR_BY_THREE* = 4 # Layout is defined by a 4x3 cross with cubemap faces
  CUBEMAP_PANORAMA* = 5 # Layout is defined by a panorama image (equirectangular map)

# Texture parameters: wrap mode
const
  WRAP_REPEAT* = 0 # Repeats texture in tiled mode
  WRAP_CLAMP* = 1 # Clamps texture to edge pixel in tiled mode
  WRAP_MIRROR_REPEAT* = 2 # Mirrors and repeats the texture in tiled mode
  WRAP_MIRROR_CLAMP* = 3 # Mirrors and clamps to border the texture in tiled mode

# Font type, defines generation method
const
  FONT_DEFAULT* = 0 # Default font generation, anti-aliased
  FONT_BITMAP* = 1 # Bitmap font generation, no anti-aliasing
  FONT_SDF* = 2 # SDF font generation, requires external shader

# Color blending modes (pre-defined)
const
  BLEND_ALPHA* = 0 # Blend textures considering alpha (default)
  BLEND_ADDITIVE* = 1 # Blend textures adding colors
  BLEND_MULTIPLIED* = 2 # Blend textures multiplying colors

# Gestures type
# NOTE: It could be used as flags to enable only some gestures
const
  GESTURE_NONE* = 0
  GESTURE_TAP* = 1
  GESTURE_DOUBLETAP* = 2
  GESTURE_HOLD* = 4
  GESTURE_DRAG* = 8
  GESTURE_SWIPE_RIGHT* = 16
  GESTURE_SWIPE_LEFT*  = 32
  GESTURE_SWIPE_UP* = 64
  GESTURE_SWIPE_DOWN* = 128
  GESTURE_PINCH_IN* = 256
  GESTURE_PINCH_OUT* = 512

# Camera system modes
const
  CAMERA_CUSTOM* = 0
  CAMERA_FREE* = 1
  CAMERA_ORBITAL* = 2
  CAMERA_FIRST_PERSON* = 3
  CAMERA_THIRD_PERSON* = 4

# Camera projection modes
const
  CAMERA_PERSPECTIVE* = 0
  CAMERA_ORTHOGRAPHIC* = 1

# Type of n-patch
const
  NPT_9PATCH* = 0 # Npatch defined by 3x3 tiles
  NPT_3PATCH_VERTICAL* = 1 # Npatch defined by 1x3 tiles
  NPT_3PATCH_HORIZONTAL* = 2 # Npatch defined by 3x1 tiles

##----------------------------------------------------------------------------------
## Structures Definition
##----------------------------------------------------------------------------------

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
  Texture2D* {.bycopy.} = object
    id*: cuint
    width*: cint
    height*: cint
    mipmaps*: cint
    format*: cint
  Texture* = Texture2D
  TextureCubemap* = Texture2D

type
  RenderTexture2D* {.bycopy.} = object
    id*: cuint
    texture*: Texture2D
    depth*: Texture2D
    depthTexture*: bool
  RenderTexture* = RenderTexture2D

type
  NPatchInfo* {.bycopy.} = object
    sourceRec*: Rectangle
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
    name*: array[32, cchar]
    parent*: cint

type
  Model* {.bycopy.} = object
    transform*: Matrix
    meshCount*: cint
    meshes*: ptr Mesh
    materialCount: cint
    materials*: ptr Material
    meshMaterial*: ptr cint
    boneCount*: cint
    bones*: ptr BoneInfo
    bindPose*: ptr Transform

type
  ModelAnimation* {.bycopy.} = object
    boneCount*: cint
    bones*: ptr BoneInfo
    frameCount*: cint
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
    cahnnels*: cuint

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

## Required for: va_list - Only used by TraceLogCallback
type
  VaList* {.importc: "va_list", header:"<stdarg.h>".} = object
## Callbacks to be implemented by users
type
  TraceLogCallback* = proc(logType: cint; text: cstring; args: VaList) {.cdecl.}

const
  LIGHTGRAY* = Color(r:200.cuchar, g:200.cuchar, b:200.cuchar, a:255.cuchar)  # Light Gray
  GRAY* = Color(r:130.cuchar, g:130.cuchar, b:130.cuchar, a:255.cuchar)  # Gray
  DARKGRAY* = Color(r:80.cuchar, g:80.cuchar, b:80.cuchar, a:255.cuchar)  # Dark Gray
  YELLOW* = Color(r:253.cuchar, g:249.cuchar, b:0.cuchar, a:255.cuchar)  # Yellow
  GOLD* = Color(r:255.cuchar, g:203.cuchar, b:0.cuchar, a:255.cuchar)  # Gold
  ORANGE* = Color(r:255.cuchar, g:161.cuchar, b:0.cuchar, a:255.cuchar)  # Orange
  PINK* = Color(r:255.cuchar, g:109.cuchar, b:194.cuchar, a:255.cuchar)  # Pink
  RED* = Color(r:230.cuchar, g:41.cuchar, b:55.cuchar, a:255.cuchar)  # Red
  MAROON* = Color(r:190.cuchar, g:33.cuchar, b:55.cuchar, a:255.cuchar)  # Maroon
  GREEN* = Color(r:0.cuchar, g:228.cuchar, b:48.cuchar, a:255.cuchar)  # Green
  LIME* = Color(r:0.cuchar, g:158.cuchar, b:47.cuchar, a:255.cuchar)  # Lime
  DARKGREEN* = Color(r:0.cuchar, g:117.cuchar, b:44.cuchar, a:255.cuchar)  # Dark Green
  SKYBLUE* = Color(r:102.cuchar, g:191.cuchar, b:255.cuchar, a:255.cuchar)  # Sky Blue
  BLUE* = Color(r:0.cuchar, g:121.cuchar, b:241.cuchar, a:255.cuchar)  # Blue
  DARKBLUE* = Color(r:0.cuchar, g:82.cuchar, b:172.cuchar, a:255.cuchar)  # Dark Blue
  PURPLE* = Color(r:200.cuchar, g:122.cuchar, b:255.cuchar, a:255.cuchar)  # Purple
  VIOLET* = Color(r:135.cuchar, g:60.cuchar, b:190.cuchar, a:255.cuchar)  # Violet
  DARKPURPLE* = Color(r:112.cuchar, g:31.cuchar, b:126.cuchar, a:255.cuchar)  # Dark Purple
  BEIGE* = Color(r:211.cuchar, g:176.cuchar, b:131.cuchar, a:255.cuchar)  # Beige
  BROWN* = Color(r:127.cuchar, g:106.cuchar, b:79.cuchar, a:255.cuchar)  # Brown
  DARKBROWN* = Color(r:76.cuchar, g:63.cuchar, b:47.cuchar, a:255.cuchar)  # Dark Brown

  WHITE* = Color(r:255.cuchar, g:255.cuchar, b:255.cuchar, a:255.cuchar)  # White
  BLACK* = Color(r:0.cuchar, g:0.cuchar, b:0.cuchar, a:255.cuchar)  # Black
  BLANK* = Color(r:0.cuchar, g:0.cuchar, b:0.cuchar, a:0.cuchar)  # Blank (Transparent)
  MAGENTA* = Color(r:255.cuchar, g:0.cuchar, b:255.cuchar, a:255.cuchar)  # Magenta
  RAYWHITE* = Color(r:245.cuchar, g:245.cuchar, b:245.cuchar, a:255.cuchar)  # MyownWhite (raylib logo)


{.push cdecl, dynlib: LIB_RAYLIB, importc.}

##------------------------------------------------------------------------------------
## Window and Graphics Device Functions
##------------------------------------------------------------------------------------

#### Window-related functions

##  Initialize window and OpenGL context
proc InitWindow*(width: cint; height: cint; title: cstring)
##  Check if KEY_ESCAPE pressed or Close icon pressed
proc WindowShouldClose*(): bool
##  Close window and unload OpenGL context
proc CloseWindow*()
##  Check if window has been initialized successfully
proc IsWindowReady*(): bool
##  Check if window has been minimized (or lost focus)
proc IsWindowMinimized*(): bool
##  Check if window has been resized
proc IsWindowResized*(): bool
##  Check if window is currently hidden
proc IsWindowHidden*(): bool
##  Check if window is currently fullscreen
proc IsWindowFullscreen*(): bool
##  Toggle fullscreen mode (only PLATFORM_DESKTOP)
proc ToggleFullscreen*()
##  Show the window
proc UnhideWindow*()
##  Hide the window
proc HideWindow*()
##  Set icon for window (only PLATFORM_DESKTOP)
proc SetWindowIcon*(image: Image)
##  Set title for window (only PLATFORM_DESKTOP)
proc SetWindowTitle*(title: cstring)
##  Set window position on screen (only PLATFORM_DESKTOP)
proc SetWindowPosition*(x: cint; y: cint)
##  Set monitor for the current window (fullscreen mode)
proc SetWindowMonitor*(monitor: cint)
##  Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
proc SetWindowMinSize*(width: cint; height: cint)
##  Set window dimensions
proc SetWindowSize*(width: cint; height: cint)
##  Get native window handle
proc GetWindowHandle*(): pointer
##  Get current screen width
proc GetScreenWidth*(): cint
##  Get current screen height
proc GetScreenHeight*(): cint
##  Get number of connected monitors
proc GetMonitorCount*(): cint
##  Get primary monitor width
proc GetMonitorWidth*(monitor: cint): cint
##  Get primary monitor height
proc GetMonitorHeight*(monitor: cint): cint
##  Get primary monitor physical width in millimetres
proc GetMonitorPhysicalWidth*(monitor: cint): cint
##  Get primary monitor physical height in millimetres
proc GetMonitorPhysicalHeight*(monitor: cint): cint
##  Get window position XY on monitor
proc GetWindowPosition*(): Vector2
##  Get the human-readable, UTF-8 encoded name of the primary monitor
proc GetMonitorName*(monitor: cint): cstring
##  Get clipboard text content
proc GetClipboardText*(): cstring
##  Set clipboard text content
proc SetClipboardText*(text: cstring)

####  Cursor-related functions

##  Shows cursor
proc ShowCursor*()
##  Hides cursor
proc HideCursor*()
##  Check if cursor is not visible
proc IsCursorHidden*(): bool
##  Enables cursor (unlock cursor)
proc EnableCursor*()
##  Disables cursor (lock cursor)
proc DisableCursor*()

####  Drawing-related functions

##  Set background color (framebuffer clear color)
proc ClearBackground*(color: Color)
##  Setup canvas (framebuffer) to start drawing
proc BeginDrawing*()
##  End canvas drawing and swap buffers (double buffering)
proc EndDrawing*()
##  Initialize 2D mode with custom camera (2D)
proc BeginMode2D*(camera: Camera2D)
##  Ends 2D mode with custom camera
proc EndMode2D*()
##  Initializes 3D mode with custom camera (3D)
proc BeginMode3D*(camera: Camera3D)
##  Ends 3D mode and returns to default 2D orthographic mode
proc EndMode3D*()
##  Initializes render texture for drawing
proc BeginTextureMode*(target: RenderTexture2D)
##  Ends drawing to render texture
proc EndTextureMode*()
##  Begin scissor mode (define screen area for following drawing)
proc BeginScissorMode*(x: cint; y: cint; width: cint; height: cint)
##  End scissor mode
proc EndScissorMode*()

####  Screen-space-related functions

##  Returns a ray trace from mouse position
proc GetMouseRay*(mousePosition: Vector2; camera: Camera): Ray
##  Returns camera transform matrix (view matrix)
proc GetCameraMatrix*(camera: Camera): Matrix
##  Returns camera 2d transform matrix
proc GetCameraMatrix2D*(camera: Camera2D): Matrix
##  Returns the screen space position for a 3d world space position
proc GetWorldToScreen*(position: Vector3; camera: Camera): Vector2
##  Returns size position for a 3d world space position
proc GetWorldToScreenEx*(position: Vector3; camera: Camera; width: cint; height: cint): Vector2
##  Returns the screen space position for a 2d camera world space position
proc GetWorldToScreen2D*(position: Vector2; camera: Camera2D): Vector2
##  Returns the world space position for a 2d camera screen space position
proc GetScreenToWorld2D*(position: Vector2; camera: Camera2D): Vector2

####  Timing-related functions

## Set target FPS (maximum)
proc SetTargetFPS*(fps: cint)
##  Returns current FPS
proc GetFPS*(): cint
##  Returns time in seconds for last frame drawn
proc GetFrameTime*(): cfloat
##  Returns elapsed time in seconds since InitWindow()
proc GetTime*(): cdouble

####  Color-related functions

##  Returns hexadecimal value for a Color
proc ColorToInt*(color: Color): cint
##  Returns color normalized as float [0..1]
proc ColorNormalize*(color: Color): Vector4
##  Returns color from normalized values [0..1]
proc ColorFromNormalized*(normalized: Vector4): Color
##  Returns HSV values for a Color
proc ColorToHSV*(color: Color): Vector3
##  Returns a Color from HSV values
proc ColorFromHSV*(hsv: Vector3): Color
##  Returns a Color struct from hexadecimal value
proc GetColor*(hexValue: cint): Color
##  Color fade-in or fade-out, alpha goes from 0.0f to 1.0f
proc Fade*(color: Color; alpha: cfloat): Color
##  Setup window configuration flags (view FLAGS)
proc SetConfigFlags*(flags: cuint)
##  Set the current threshold (minimum) log level
proc SetTraceLogLevel*(logType: cint)
##  Set the exit threshold (minimum) log level
proc SetTraceLogExit*(logType: cint)
##  Set a trace log callback to enable custom logging
proc SetTraceLogCallback*(callback: TraceLogCallback)
##  Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR)
proc TraceLog*(logType: cint; text: cstring) {.varargs.}
##  Takes a screenshot of current screen (saved a .png)
proc TakeScreenshot*(fileName: cstring)
##  Returns a random value between min and max (both included)
proc GetRandomValue*(min: cint; max: cint): cint

####  Files management functions

##  Load file data as byte array (read)
proc LoadFileData*(fileName: cstring; bytesRead: ptr cuint): ptr cuchar
##  Save data to file from byte array (write)
proc SaveFileData*(fileName: cstring; data: pointer; bytesToWrite: cuint)
##  Load text data from file (read), returns a '\0' terminated string
proc LoadFileText*(fileName: cstring): cstring
##  Save text data to file (write), string must be '\0' terminated
proc SaveFileText*(fileName: cstring; text: cstring)
##  Check if file exists
proc FileExists*(fileName: cstring): bool
##  Check file extension
proc IsFileExtension*(fileName: cstring; ext: cstring): bool
##  Check if a directory path exists
proc DirectoryExists*(dirPath: cstring): bool
##  Get pointer to extension for a filename string
proc GetFileExtension*(fileName: cstring): cstring
##  Get pointer to filename for a path string
proc GetFileName*(filePath: cstring): cstring
##  Get filename string without extension (uses static string)
proc GetFileNameWithoutExt*(filePath: cstring): cstring
##  Get full path for a given fileName with path (uses static string)
proc GetDirectoryPath*(filePath: cstring): cstring
##  Get previous directory path for a given path (uses static string)
proc GetPrevDirectoryPath*(dirPath: cstring): cstring
##  Get current working directory (uses static string)
proc GetWorkingDirectory*(): cstring
##  Get filenames in a directory path (memory should be freed)
proc GetDirectoryFiles*(dirPath: cstring; count: ptr cint): cstringArray
##  Clear directory files paths buffers (free memory)
proc ClearDirectoryFiles*()
##  Change working directory, returns true if success
proc ChangeDirectory*(dir: cstring): bool
##  Check if a file has been dropped into window
proc IsFileDropped*(): bool
##  Get dropped files names (memory should be freed)
proc GetDroppedFiles*(count: ptr cint): cstringArray
##  Clear dropped files paths buffer (free memory)
proc ClearDroppedFiles*()
##  Get file modification time (last write time)
proc GetFileModTime*(fileName: cstring): clong
##  Compress data (DEFLATE algorythm)
proc CompressData*(data: ptr cuchar; dataLength: cint; compDataLength: ptr cint): ptr cuchar
##  Decompress data (DEFLATE algorythm)
proc DecompressData*(compData: ptr cuchar; compDataLength: cint; dataLength: ptr cint): ptr cuchar

####  Persistent storage management

##  Save integer value to storage file (to defined position)
proc SaveStorageValue*(position: cuint; value: cint)
##  Load integer value from storage file (from defined position)
proc LoadStorageValue*(position: cuint): cint
##  Open URL with default system browser (if available)
proc OpenURL*(url: cstring)

##------------------------------------------------------------------------------------
## Input Handling Functions
##------------------------------------------------------------------------------------

####  Input-related functions: keyb

##  Detect if a key has been pressed once
proc IsKeyPressed*(key: cint): bool
##  Detect if a key is being pressed
proc IsKeyDown*(key: cint): bool
##  Detect if a key has been released once
proc IsKeyReleased*(key: cint): bool
##  Detect if a key is NOT being pressed
proc IsKeyUp*(key: cint): bool
##  Get latest key pressed
proc GetKeyPressed*(): cint
##  Set a custom key to exit program (default is ESC)
proc SetExitKey*(key: cint)

####  Input-related functions: gamepads

##  Detect if a gamepad is available
proc IsGamepadAvailable*(gamepad: cint): bool
##  Check gamepad name (if available)
proc IsGamepadName*(gamepad: cint; name: cstring): bool
##  Return gamepad internal name id
proc GetGamepadName*(gamepad: cint): cstring
##  Detect if a gamepad button has been pressed once
proc IsGamepadButtonPressed*(gamepad: cint; button: cint): bool
##  Detect if a gamepad button is being pressed
proc IsGamepadButtonDown*(gamepad: cint; button: cint): bool
##  Detect if a gamepad button has been released once
proc IsGamepadButtonReleased*(gamepad: cint; button: cint): bool
##  Detect if a gamepad button is NOT being pressed
proc IsGamepadButtonUp*(gamepad: cint; button: cint): bool
##  Get the last gamepad button pressed
proc GetGamepadButtonPressed*(): cint
##  Return gamepad axis count for a gamepad
proc GetGamepadAxisCount*(gamepad: cint): cint
##  Return axis movement value for a gamepad axis
proc GetGamepadAxisMovement*(gamepad: cint; axis: cint): cfloat

####  Input-related functions: mouse

##  Detect if a mouse button has been pressed once
proc IsMouseButtonPressed*(button: cint): bool
##  Detect if a mouse button is being pressed
proc IsMouseButtonDown*(button: cint): bool
##  Detect if a mouse button has been released once
proc IsMouseButtonReleased*(button: cint): bool
##  Detect if a mouse button is NOT being pressed
proc IsMouseButtonUp*(button: cint): bool
##  Returns mouse position X
proc GetMouseX*(): cint
##  Returns mouse position Y
proc GetMouseY*(): cint
##  Returns mouse position XY
proc GetMousePosition*(): Vector2
##  Set mouse position XY
proc SetMousePosition*(x: cint; y: cint)
##  Set mouse offset
proc SetMouseOffset*(offsetX: cint; offsetY: cint)
##  Set mouse scaling
proc SetMouseScale*(scaleX: cfloat; scaleY: cfloat)
##  Returns mouse wheel movement Y
proc GetMouseWheelMove*(): cint

####  Input-related functions: touch

##  Returns touch position X for touch point 0 (relative to screen size)
proc GetTouchX*(): cint
##  Returns touch position Y for touch point 0 (relative to screen size)
proc GetTouchY*(): cint
##  Returns touch position XY for a touch point index (relative to screen size)
proc GetTouchPosition*(index: cint): Vector2

##------------------------------------------------------------------------------------
##  Gestures and Touch Handling Functions
##------------------------------------------------------------------------------------

##  Enable a set of gestures using flags
proc SetGesturesEnabled*(gestureFlags: cuint)
##  Check if a gesture have been detected
proc IsGestureDetected*(gesture: cint): bool
##  Get latest detected gesture
proc GetGestureDetected*(): cint
##  Get touch points count
proc GetTouchPointsCount*(): cint
##  Get gesture hold time in milliseconds
proc GetGestureHoldDuration*(): cfloat
##  Get gesture drag vector
proc GetGestureDragVector*(): Vector2
##  Get gesture drag angle
proc GetGestureDragAngle*(): cfloat
##  Get gesture pinch delta
proc GetGesturePinchVector*(): Vector2
##  Get gesture pinch angle
proc GetGesturePinchAngle*(): cfloat

##------------------------------------------------------------------------------------
##  Camera System Functions
##------------------------------------------------------------------------------------

##  Set camera mode (multiple camera modes available)
proc SetCameraMode*(camera: Camera; mode: cint)
##  Update camera position for selected mode
proc UpdateCamera*(camera: ptr Camera)
##  Set camera pan key to combine with mouse movement (free camera)
proc SetCameraPanControl*(panKey: cint)
##  Set camera alt key to combine with mouse movement (free camera)
proc SetCameraAltControl*(altKey: cint)
##  Set camera smooth zoom key to combine with mouse (free camera)
proc SetCameraSmoothZoomControl*(szKey: cint)
##  Set camera move controls (1st person and 3rd person cameras)
proc SetCameraMoveControls*(frontKey: cint, backKey: cint, rightKey: cint,
                           leftKey: cint, upKey: cint, downKey: cint)

##------------------------------------------------------------------------------------
##  Basic shapes drawing functions
##------------------------------------------------------------------------------------

##  Draw a pixel
proc DrawPixel*(posX: cint; posY: cint; color: Color)
##  Draw a pixel (Vector version)
proc DrawPixelV*(position: Vector2; color: Color)
##  Draw a line
proc DrawLine*(startPosX: cint; startPosY: cint; endPosX: cint; endPosY: cint;
              color: Color)
##  Draw a line (Vector version)
proc DrawLineV*(startPos: Vector2; endPos: Vector2; color: Color)
##  Draw a line defining thickness
proc DrawLineEx*(startPos: Vector2; endPos: Vector2; thick: cfloat; color: Color)
##  Draw a line using cubic-bezier curves in-out
proc DrawLineBezier*(startPos: Vector2; endPos: Vector2; thick: cfloat; color: Color)
##  Draw lines sequence
proc DrawLineStrip*(points: ptr Vector2; numPoints: cint; color: Color)
##  Draw a color-filled circle
proc DrawCircle*(centerX: cint; centerY: cint; radius: cfloat; color: Color)
##  Draw a piece of a circle
proc DrawCircleSector*(center: Vector2; radius: cfloat; startAngle: cint;
                      endAngle: cint; segments: cint; color: Color)
##  Draw circle sector outline
proc DrawCircleSectorLines*(center: Vector2; radius: cfloat; startAngle: cint;
                           endAngle: cint; segments: cint; color: Color)
##  Draw a gradient-filled circle
proc DrawCircleGradient*(centerX: cint; centerY: cint; radius: cfloat; color1: Color;
                        color2: Color)
##  Draw a color-filled circle (Vector version)
proc DrawCircleV*(center: Vector2; radius: cfloat; color: Color)
##  Draw circle outline
proc DrawCircleLines*(centerX: cint; centerY: cint; radius: cfloat; color: Color)
##  Draw ellipse
proc DrawEllipse*(centerX: cint; centerY: cint; radiusH: cfloat; radiusV: cfloat;
                 color: Color)
##  Draw ellipse outline
proc DrawEllipseLines*(centerX: cint; centerY: cint; radiusH: cfloat; radiusV: cfloat;
                      color: Color)
##  Draw ring
proc DrawRing*(center: Vector2; innerRadius: cfloat; outerRadius: cfloat;
              startAngle: cint; endAngle: cint; segments: cint; color: Color)
##  Draw ring outline
proc DrawRingLines*(center: Vector2; innerRadius: cfloat; outerRadius: cfloat;
                   startAngle: cint; endAngle: cint; segments: cint; color: Color)
##  Draw a color-filled rectangle
proc DrawRectangle*(posX: cint; posY: cint; width: cint; height: cint; color: Color)
##  Draw a color-filled rectangle (Vector version)
proc DrawRectangleV*(position: Vector2; size: Vector2; color: Color)
##  Draw a color-filled rectangle
proc DrawRectangleRec*(rec: Rectangle; color: Color)
##  Draw a color-filled rectangle with pro parameters
proc DrawRectanglePro*(rec: Rectangle; origin: Vector2; rotation: cfloat; color: Color)
##  Draw a vertical-gradient-filled rectangle
proc DrawRectangleGradientV*(posX: cint; posY: cint; width: cint; height: cint;
                            color1: Color; color2: Color)
##  Draw a horizontal-gradient-filled rectangle
proc DrawRectangleGradientH*(posX: cint; posY: cint; width: cint; height: cint;
                            color1: Color; color2: Color)
##  Draw a gradient-filled rectangle with custom vertex colors
proc DrawRectangleGradientEx*(rec: Rectangle; col1: Color; col2: Color; col3: Color;
                             col4: Color)
##  Draw rectangle outline
proc DrawRectangleLines*(posX: cint; posY: cint; width: cint; height: cint; color: Color)
##  Draw rectangle outline with extended parameters
proc DrawRectangleLinesEx*(rec: Rectangle; lineThick: cint; color: Color)
##  Draw rectangle with rounded edges
proc DrawRectangleRounded*(rec: Rectangle; roundness: cfloat; segments: cint;
                          color: Color)
##  Draw rectangle with rounded edges outline
proc DrawRectangleRoundedLines*(rec: Rectangle; roundness: cfloat; segments: cint;
                               lineThick: cint; color: Color)
##  Draw a color-filled triangle (vertex in counter-clockwise order!)
proc DrawTriangle*(v1: Vector2; v2: Vector2; v3: Vector2; color: Color)
##  Draw triangle outline (vertex in counter-clockwise order!)
proc DrawTriangleLines*(v1: Vector2; v2: Vector2; v3: Vector2; color: Color)
##  Draw a triangle fan defined by points (first vertex is the center)
proc DrawTriangleFan*(points: ptr Vector2; numPoints: cint; color: Color)
##  Draw a triangle strip defined by points
proc DrawTriangleStrip*(points: ptr Vector2; pointsCount: cint; color: Color)
##  Draw a regular polygon (Vector version)
proc DrawPoly*(center: Vector2; sides: cint; radius: cfloat; rotation: cfloat;
              color: Color)
##  Draw a polygon outline of n sides
proc DrawPolyLines*(center: Vector2; sides: cint; radius: cfloat; rotation: cfloat;
                   color: Color)

####  Basic shapes collision detection functions

##  Check collision between two rectangles
proc CheckCollisionRecs*(rec1: Rectangle; rec2: Rectangle): bool
##  Check collision between two circles
proc CheckCollisionCircles*(center1: Vector2; radius1: cfloat; center2: Vector2;
                           radius2: cfloat): bool
##  Check collision between circle and rectangle
proc CheckCollisionCircleRec*(center: Vector2; radius: cfloat; rec: Rectangle): bool
##  Get collision rectangle for two rectangles collision
proc GetCollisionRec*(rec1: Rectangle; rec2: Rectangle): Rectangle
##  Check if point is inside rectangle
proc CheckCollisionPointRec*(point: Vector2; rec: Rectangle): bool
##  Check if point is inside circle
proc CheckCollisionPointCircle*(point: Vector2; center: Vector2; radius: cfloat): bool
##  Check if point is inside a triangle
proc CheckCollisionPointTriangle*(point: Vector2; p1: Vector2; p2: Vector2; p3: Vector2): bool

####  Image loading functions
####  NOTE: This functions do not require GPU access

##  Load image from file into CPU memory (RAM)
proc LoadImage*(fileName: cstring): Image
##  Load image from Color array data (RGBA - 32bit)
proc LoadImageEx*(pixels: ptr Color; width: cint; height: cint): Image
##  Load image from raw data with parameters
proc LoadImagePro*(data: pointer; width: cint; height: cint; format: cint): Image
##  Load image from RAW file data
proc LoadImageRaw*(fileName: cstring; width: cint; height: cint; format: cint;
                  headerSize: cint): Image
##  Unload image from CPU memory (RAM)
proc UnloadImage*(image: Image)
##  Export image data to file
proc ExportImage*(image: Image; fileName: cstring)
##  Export image as code file defining an array of bytes
proc ExportImageAsCode*(image: Image; fileName: cstring)
##  Get pixel data from image as a Color struct array
proc GetImageData*(image: Image): ptr Color
##  Get pixel data from image as Vector4 array (float normalized)
proc GetImageDataNormalized*(image: Image): ptr Vector4

####  Image generation functions

##  Generate image: plain color
proc GenImageColor*(width: cint; height: cint; color: Color): Image
##  Generate image: vertical gradient
proc GenImageGradientV*(width: cint; height: cint; top: Color; bottom: Color): Image
##  Generate image: horizontal gradient
proc GenImageGradientH*(width: cint; height: cint; left: Color; right: Color): Image
##  Generate image: radial gradient
proc GenImageGradientRadial*(width: cint; height: cint; density: cfloat; inner: Color;
                            outer: Color): Image
##  Generate image: checked
proc GenImageChecked*(width: cint; height: cint; checksX: cint; checksY: cint;
                     col1: Color; col2: Color): Image
##  Generate image: white noise
proc GenImageWhiteNoise*(width: cint; height: cint; factor: cfloat): Image
##  Generate image: perlin noise
proc GenImagePerlinNoise*(width: cint; height: cint; offsetX: cint; offsetY: cint;
                         scale: cfloat): Image
##  Generate image: cellular algorithm. Bigger tileSize means bigger cells
proc GenImageCellular*(width: cint; height: cint; tileSize: cint): Image

####  Image manipulation functions

##  Create an image duplicate (useful for transformations)
proc ImageCopy*(image: Image): Image
##  Create an image from another image piece
proc ImageFromImage*(image: Image; rec: Rectangle): Image
##  Create an image from text (default font)
proc ImageText*(text: cstring; fontSize: cint; color: Color): Image
##  Create an image from text (custom sprite font)
proc ImageTextEx*(font: Font; text: cstring; fontSize: cfloat; spacing: cfloat;
                 tint: Color): Image
##  Convert image to POT (power-of-two)
proc ImageToPOT*(image: ptr Image; fillColor: Color)
##  Convert image data to desired format
proc ImageFormat*(image: ptr Image; newFormat: cint)
##  Apply alpha mask to image
proc ImageAlphaMask*(image: ptr Image; alphaMask: Image)
##  Clear alpha channel to desired color
proc ImageAlphaClear*(image: ptr Image; color: Color; threshold: cfloat)
##  Crop image depending on alpha value
proc ImageAlphaCrop*(image: ptr Image; threshold: cfloat)
##  Premultiply alpha channel
proc ImageAlphaPremultiply*(image: ptr Image)
##  Crop an image to a defined rectangle
proc ImageCrop*(image: ptr Image; crop: Rectangle)
##  Resize image (Bicubic scaling algorithm)
proc ImageResize*(image: ptr Image; newWidth: cint; newHeight: cint)
##  Resize image (Nearest-Neighbor scaling algorithm)
proc ImageResizeNN*(image: ptr Image; newWidth: cint; newHeight: cint)
##  Resize canvas and fill with color
proc ImageResizeCanvas*(image: ptr Image; newWidth: cint; newHeight: cint;
                       offsetX: cint; offsetY: cint; color: Color)
##  Generate all mipmap levels for a provided image
proc ImageMipmaps*(image: ptr Image)
##  Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
proc ImageDither*(image: ptr Image; rBpp: cint; gBpp: cint; bBpp: cint; aBpp: cint)
##  Flip image vertically
proc ImageFlipVertical*(image: ptr Image)
##  Flip image horizontally
proc ImageFlipHorizontal*(image: ptr Image)
##  Rotate image clockwise 90deg
proc ImageRotateCW*(image: ptr Image)
##  Rotate image counter-clockwise 90deg
proc ImageRotateCCW*(image: ptr Image)
##  Modify image color: tint
proc ImageColorTint*(image: ptr Image; color: Color)
##  Modify image color: invert
proc ImageColorInvert*(image: ptr Image)
##  Modify image color: grayscale
proc ImageColorGrayscale*(image: ptr Image)
##  Modify image color: contrast (-100 to 100)
proc ImageColorContrast*(image: ptr Image; contrast: cfloat)
##  Modify image color: brightness (-255 to 255)
proc ImageColorBrightness*(image: ptr Image; brightness: cint)
##  Modify image color: replace color
proc ImageColorReplace*(image: ptr Image; color: Color; replace: Color)
##  Extract color palette from image to maximum size (memory should be freed)
proc ImageExtractPalette*(image: Image; maxPaletteSize: cint; extractCount: ptr cint): ptr Color
##  Get image alpha border rectangle
proc GetImageAlphaBorder*(image: Image; threshold: cfloat): Rectangle

####  Image drawing functions
####  NOTE: Image software-rendering functions (CPU)

##  Clear image background with given color
proc ImageClearBackground*(dst: ptr Image; color: Color)
##  Draw pixel within an image
proc ImageDrawPixel*(dst: ptr Image; posX: cint; posY: cint; color: Color)
##  Draw pixel within an image (Vector version)
proc ImageDrawPixelV*(dst: ptr Image; position: Vector2; color: Color)
##  Draw line within an image
proc ImageDrawLine*(dst: ptr Image; startPosX: cint; startPosY: cint; endPosX: cint;
                   endPosY: cint; color: Color)
##  Draw line within an image (Vector version)
proc ImageDrawLineV*(dst: ptr Image; start: Vector2; `end`: Vector2; color: Color)
##  Draw circle within an image
proc ImageDrawCircle*(dst: ptr Image; centerX: cint; centerY: cint; radius: cint;
                     color: Color)
##  Draw circle within an image (Vector version)
proc ImageDrawCircleV*(dst: ptr Image; center: Vector2; radius: cint; color: Color)
##  Draw rectangle within an image
proc ImageDrawRectangle*(dst: ptr Image; posX: cint; posY: cint; width: cint;
                        height: cint; color: Color)
##  Draw rectangle within an image (Vector version)
proc ImageDrawRectangleV*(dst: ptr Image; position: Vector2; size: Vector2; color: Color)
##  Draw rectangle within an image
proc ImageDrawRectangleRec*(dst: ptr Image; rec: Rectangle; color: Color)
##  Draw rectangle lines within an image
proc ImageDrawRectangleLines*(dst: ptr Image; rec: Rectangle; thick: cint; color: Color)
##  Draw a source image within a destination image (tint applied to source)
proc ImageDraw*(dst: ptr Image; src: Image; srcRec: Rectangle; dstRec: Rectangle;
               tint: Color)
##  Draw text (default font) within an image (destination)
proc ImageDrawText*(dst: ptr Image; position: Vector2; text: cstring; fontSize: cint;
                   color: Color)
##  Draw text (custom sprite font) within an image (destination)
proc ImageDrawTextEx*(dst: ptr Image; position: Vector2; font: Font; text: cstring;
                     fontSize: cfloat; spacing: cfloat; color: Color)

##------------------------------------------------------------------------------------
## Texture loading functions
##------------------------------------------------------------------------------------

#### Image loading functions
#### NOTE: These functions require GPU access

##  Load texture from file into GPU memory (VRAM)
proc LoadTexture*(fileName: cstring): Texture2D
##  Load texture from image data
proc LoadTextureFromImage*(image: Image): Texture2D
##  Load cubemap from image, multiple image cubemap layouts supported
proc LoadTextureCubemap*(image: Image; layoutType: cint): TextureCubemap
##  Load texture for rendering (framebuffer)
proc LoadRenderTexture*(width: cint; height: cint): RenderTexture2D
##  Unload texture from GPU memory (VRAM)
proc UnloadTexture*(texture: Texture2D)
##  Unload render texture from GPU memory (VRAM)
proc UnloadRenderTexture*(target: RenderTexture2D)
##  Update GPU texture with new data
proc UpdateTexture*(texture: Texture2D; pixels: pointer)
##  Get pixel data from GPU texture and return an Image
proc GetTextureData*(texture: Texture2D): Image
##  Get pixel data from screen buffer and return an Image (screenshot)
proc GetScreenData*(): Image

####  Texture configuration functions

##  Generate GPU mipmaps for a texture
proc GenTextureMipmaps*(texture: ptr Texture2D)
##  Set texture scaling filter mode
proc SetTextureFilter*(texture: Texture2D; filterMode: cint)
##  Set texture wrapping mode
proc SetTextureWrap*(texture: Texture2D; wrapMode: cint)

####  Texture drawing functions

##  Draw a Texture2D
proc DrawTexture*(texture: Texture2D; posX: cint; posY: cint; tint: Color)
##  Draw a Texture2D with position defined as Vector2
proc DrawTextureV*(texture: Texture2D; position: Vector2; tint: Color)
##  Draw a Texture2D with extended parameters
proc DrawTextureEx*(texture: Texture2D; position: Vector2; rotation: cfloat;
                   scale: cfloat; tint: Color)
##  Draw a part of a texture defined by a rectangle
proc DrawTextureRec*(texture: Texture2D; sourceRec: Rectangle; position: Vector2;
                    tint: Color)
##  Draw texture quad with tiling and offset parameters
proc DrawTextureQuad*(texture: Texture2D; tiling: Vector2; offset: Vector2;
                     quad: Rectangle; tint: Color)
## Draw a part of a texture defined by a rectangle with 'pro' parameters
proc DrawTexturePro*(texture: Texture2D; sourceRec: Rectangle; destRec: Rectangle;
                    origin: Vector2; rotation: cfloat; tint: Color)
##  Draws a texture (or part of it) that stretches or shrinks nicely
proc DrawTextureNPatch*(texture: Texture2D; nPatchInfo: NPatchInfo;
                       destRec: Rectangle; origin: Vector2; rotation: cfloat;
                       tint: Color)

####  Image/Texture misc functions

##  Get pixel data size in bytes (image or texture)
proc GetPixelDataSize*(width: cint; height: cint; format: cint): cint

##------------------------------------------------------------------------------------
## Font Loading and Text Drawing Functions
##------------------------------------------------------------------------------------

####  Font loading/unloading functions

##  Get the default Font
proc GetFontDefault*(): Font
##  Load font from file into GPU memory (VRAM)
proc LoadFont*(fileName: cstring): Font
##  Load font from file with extended parameters
proc LoadFontEx*(fileName: cstring; fontSize: cint; fontChars: ptr cint;
                charsCount: cint): Font
##  Load font from Image (XNA style)
proc LoadFontFromImage*(image: Image; key: Color; firstChar: cint): Font
##  Load font data for further use
proc LoadFontData*(fileName: cstring; fontSize: cint; fontChars: ptr cint;
                  charsCount: cint; `type`: cint): ptr CharInfo
##  Generate image font atlas using chars info
proc GenImageFontAtlas*(chars: ptr CharInfo; recs: ptr ptr Rectangle; charsCount: cint;
                       fontSize: cint; padding: cint; packMethod: cint): Image
## Unload Font from GPU memory (VRAM)
proc UnloadFont*(font: Font)

####  Text drawing functions

##  Shows current FPS
proc DrawFPS*(posX: cint; posY: cint)
##  Draw text (using default font)
proc DrawText*(text: cstring; posX: cint; posY: cint; fontSize: cint; color: Color)
##  Draw text using font and additional parameters
proc DrawTextEx*(font: Font; text: cstring; position: Vector2; fontSize: cfloat;
                spacing: cfloat; tint: Color)
##  Draw text using font inside rectangle limits
proc DrawTextRec*(font: Font; text: cstring; rec: Rectangle; fontSize: cfloat;
                 spacing: cfloat; wordWrap: bool; tint: Color)

##  Draw text using font inside rectangle limits with support for text selection
proc DrawTextRecEx*(font: Font; text: cstring; rec: Rectangle; fontSize: cfloat;
                   spacing: cfloat; wordWrap: bool; tint: Color; selectStart: cint;
                   selectLength: cint; selectTint: Color; selectBackTint: Color)

##  Draw one character (codepoint)
proc DrawTextCodepoint*(font: Font; codepoint: cint; position: Vector2; scale: cfloat;
                       tint: Color)

####  Text misc. functions

##  Measure string width for default font
proc MeasureText*(text: cstring; fontSize: cint): cint
##  Measure string size for Font
proc MeasureTextEx*(font: Font; text: cstring; fontSize: cfloat; spacing: cfloat): Vector2

##  Get index position for a unicode character on font
proc GetGlyphIndex*(font: Font; codepoint: cint): cint

####  Text strings management functions (no utf8 strings, only byte chars)
####  NOTE: Some strings allocate memory internally for returned strings, just be careful!

##  Copy one string to another, returns bytes copied
proc TextCopy*(dst: cstring; src: cstring): cint
##  Check if two text string are equal
proc TextIsEqual*(text1: cstring; text2: cstring): bool
##  Get text length, checks for '\0' ending
proc TextLength*(text: cstring): cuint
##  Text formatting with variables (sprintf style)
proc TextFormat*(text: cstring): cstring {.varargs.}
##  Get a piece of a text string
proc TextSubtext*(text: cstring; position: cint; length: cint): cstring
##  Replace text string (memory must be freed!)
proc TextReplace*(text: cstring; replace: cstring; by: cstring): cstring
##  Insert text in a position (memory must be freed!)
proc TextInsert*(text: cstring; insert: cstring; position: cint): cstring
##  Join text strings with delimiter
proc TextJoin*(textList: cstringArray; count: cint; delimiter: cstring): cstring
##  Split text into multiple strings
proc TextSplit*(text: cstring; delimiter: char; count: ptr cint): cstringArray
##  Append text at specific position and move cursor!
proc TextAppend*(text: cstring; append: cstring; position: ptr cint)
##  Find first text occurrence within a string
proc TextFindIndex*(text: cstring; find: cstring): cint
##  Get upper case version of provided string
proc TextToUpper*(text: cstring): cstring
##  Get lower case version of provided string
proc TextToLower*(text: cstring): cstring
##  Get Pascal case notation version of provided string
proc TextToPascal*(text: cstring): cstring
##  Get integer value from text (negative values not supported)
proc TextToInteger*(text: cstring): cint
##  Encode text codepoint into utf8 text (memory must be freed!)
proc TextToUtf8*(codepoints: ptr cint; length: cint): cstring

####  UTF8 text strings management functions

##  Get all codepoints in a string, codepoints count returned by parameters
proc GetCodepoints*(text: cstring; count: ptr cint): ptr cint
##  Get total number of characters (codepoints) in a UTF8 encoded string
proc GetCodepointsCount*(text: cstring): cint
##  Returns next codepoint in a UTF8 encoded string; 0x3f('?') is returned on failure
proc GetNextCodepoint*(text: cstring; bytesProcessed: ptr cint): cint
##  Encode codepoint into utf8 text (char array length returned as parameter)
proc CodepointToUtf8*(codepoint: cint; byteLength: ptr cint): cstring

##------------------------------------------------------------------------------------
## Basic 3d Shapes Drawing Functions
##------------------------------------------------------------------------------------

####  Basic geometric 3D shapes drawing functions

##  Draw a line in 3D world space
proc DrawLine3D*(startPos: Vector3; endPos: Vector3; color: Color)
##  Draw a point in 3D space, actually a small line
proc DrawPoint3D*(position: Vector3; color: Color)
##  Draw a circle in 3D world space
proc DrawCircle3D*(center: Vector3; radius: cfloat; rotationAxis: Vector3;
                  rotationAngle: cfloat; color: Color)
##  Draw cube
proc DrawCube*(position: Vector3; width: cfloat; height: cfloat; length: cfloat;
              color: Color)
##  Draw cube (Vector version)
proc DrawCubeV*(position: Vector3; size: Vector3; color: Color)
##  Draw cube wires
proc DrawCubeWires*(position: Vector3; width: cfloat; height: cfloat; length: cfloat;
                   color: Color)
##  Draw cube wires (Vector version)
proc DrawCubeWiresV*(position: Vector3; size: Vector3; color: Color)
##  Draw cube textured
proc DrawCubeTexture*(texture: Texture2D; position: Vector3; width: cfloat;
                     height: cfloat; length: cfloat; color: Color)
##  Draw sphere
proc DrawSphere*(centerPos: Vector3; radius: cfloat; color: Color)
##  Draw sphere with extended parameters
proc DrawSphereEx*(centerPos: Vector3; radius: cfloat; rings: cint; slices: cint;
                  color: Color)
##  Draw sphere wires
proc DrawSphereWires*(centerPos: Vector3; radius: cfloat; rings: cint; slices: cint;
                     color: Color)
##  Draw a cylinder/cone
proc DrawCylinder*(position: Vector3; radiusTop: cfloat; radiusBottom: cfloat;
                  height: cfloat; slices: cint; color: Color)
##  Draw a cylinder/cone wires
proc DrawCylinderWires*(position: Vector3; radiusTop: cfloat; radiusBottom: cfloat;
                       height: cfloat; slices: cint; color: Color)
##  Draw a plane XZ
proc DrawPlane*(centerPos: Vector3; size: Vector2; color: Color)
##  Draw a ray line
proc DrawRay*(ray: Ray; color: Color)
##  Draw a grid (centered at (0, 0, 0))
proc DrawGrid*(slices: cint; spacing: cfloat)
##  Draw simple gizmo
proc DrawGizmo*(position: Vector3)

##------------------------------------------------------------------------------------
## Model 3d Loading and Drawing Functions
##------------------------------------------------------------------------------------

####  Model loading/unloading functions

##  Load model from files (meshes and materials)
proc LoadModel*(fileName: cstring): Model
##  Load model from generated mesh (default material)
proc LoadModelFromMesh*(mesh: Mesh): Model
##  Unload model from memory (RAM and/or VRAM)
proc UnloadModel*(model: Model)

####  Mesh loading/unloading functions

##  Load meshes from model file
proc LoadMeshes*(fileName: cstring; meshCount: ptr cint): ptr Mesh
##  Export mesh data to file
proc ExportMesh*(mesh: Mesh; fileName: cstring)
##  Unload mesh from memory (RAM and/or VRAM)
proc UnloadMesh*(mesh: Mesh)

####  Material loading/unloading functions

##  Load materials from model file
proc LoadMaterials*(fileName: cstring; materialCount: ptr cint): ptr Material
##  Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
proc LoadMaterialDefault*(): Material
##  Unload material from GPU memory (VRAM)
proc UnloadMaterial*(material: Material)
##  Set texture for a material map type (MAP_DIFFUSE, MAP_SPECULAR...)
proc SetMaterialTexture*(material: ptr Material; mapType: cint; texture: Texture2D)
##  Set material for a mesh
proc SetModelMeshMaterial*(model: ptr Model; meshId: cint; materialId: cint)

####  Model animations loading/unloading functions

##  Load model animations from file
proc LoadModelAnimations*(fileName: cstring; animsCount: ptr cint): ptr ModelAnimation
##  Update model animation pose
proc UpdateModelAnimation*(model: Model; anim: ModelAnimation; frame: cint)
##  Unload animation data
proc UnloadModelAnimation*(anim: ModelAnimation)
##  Check model animation skeleton match
proc IsModelAnimationValid*(model: Model; anim: ModelAnimation): bool

####  Mesh generation functions

##  Generate polygonal mesh
proc GenMeshPoly*(sides: cint; radius: cfloat): Mesh
##  Generate plane mesh (with subdivisions)
proc GenMeshPlane*(width: cfloat; length: cfloat; resX: cint; resZ: cint): Mesh
##  Generate cuboid mesh
proc GenMeshCube*(width: cfloat; height: cfloat; length: cfloat): Mesh
##  Generate sphere mesh (standard sphere)
proc GenMeshSphere*(radius: cfloat; rings: cint; slices: cint): Mesh
##  Generate half-sphere mesh (no bottom cap)
proc GenMeshHemiSphere*(radius: cfloat; rings: cint; slices: cint): Mesh
##  Generate cylinder mesh
proc GenMeshCylinder*(radius: cfloat; height: cfloat; slices: cint): Mesh
##  Generate torus mesh
proc GenMeshTorus*(radius: cfloat; size: cfloat; radSeg: cint; sides: cint): Mesh
##  Generate trefoil knot mesh
proc GenMeshKnot*(radius: cfloat; size: cfloat; radSeg: cint; sides: cint): Mesh
##  Generate heightmap mesh from image data
proc GenMeshHeightmap*(heightmap: Image; size: Vector3): Mesh
##  Generate cubes-based map mesh from image data
proc GenMeshCubicmap*(cubicmap: Image; cubeSize: Vector3): Mesh

####  Mesh manipulation functions

##  Compute mesh bounding box limits
proc MeshBoundingBox*(mesh: Mesh): BoundingBox
##  Compute mesh tangents
proc MeshTangents*(mesh: ptr Mesh)
##  Compute mesh binormals
proc MeshBinormals*(mesh: ptr Mesh)

####  Model drawing functions

##  Draw a model (with texture if set)
proc DrawModel*(model: Model; position: Vector3; scale: cfloat; tint: Color)
##  Draw a model with extended parameters
proc DrawModelEx*(model: Model; position: Vector3; rotationAxis: Vector3;
                 rotationAngle: cfloat; scale: Vector3; tint: Color)
##  Draw a model wires (with texture if set)
proc DrawModelWires*(model: Model; position: Vector3; scale: cfloat; tint: Color)
##  Draw a model wires (with texture if set) with extended parameters
proc DrawModelWiresEx*(model: Model; position: Vector3; rotationAxis: Vector3;
                      rotationAngle: cfloat; scale: Vector3; tint: Color)
##  Draw bounding box (wires)
proc DrawBoundingBox*(box: BoundingBox; color: Color)
##  Draw a billboard texture
proc DrawBillboard*(camera: Camera; texture: Texture2D; center: Vector3; size: cfloat;
                   tint: Color)
##  Draw a billboard texture defined by sourceRec
proc DrawBillboardRec*(camera: Camera; texture: Texture2D; sourceRec: Rectangle;
                      center: Vector3; size: cfloat; tint: Color)

####  Collision detection functions

##  Detect collision between two spheres
proc CheckCollisionSpheres*(centerA: Vector3; radiusA: cfloat; centerB: Vector3;
                           radiusB: cfloat): bool
##  Detect collision between two bounding boxes
proc CheckCollisionBoxes*(box1: BoundingBox; box2: BoundingBox): bool
##  Detect collision between box and sphere
proc CheckCollisionBoxSphere*(box: BoundingBox; center: Vector3; radius: cfloat): bool
##  Detect collision between ray and sphere
proc CheckCollisionRaySphere*(ray: Ray; center: Vector3; radius: cfloat): bool
##  Detect collision between ray and sphere, returns collision point
proc CheckCollisionRaySphereEx*(ray: Ray; center: Vector3; radius: cfloat;
                               collisionPoint: ptr Vector3): bool
##  Detect collision between ray and box
proc CheckCollisionRayBox*(ray: Ray; box: BoundingBox): bool
##  Get collision info between ray and model
proc GetCollisionRayModel*(ray: Ray; model: Model): RayHitInfo
##  Get collision info between ray and triangle
proc GetCollisionRayTriangle*(ray: Ray; p1: Vector3; p2: Vector3; p3: Vector3): RayHitInfo ##  Get collision info between ray and ground plane (Y-normal plane)
proc GetCollisionRayGround*(ray: Ray; groundHeight: cfloat): RayHitInfo

##------------------------------------------------------------------------------------
## Shaders System Functions (Module: rlgl)
## NOTE: This functions are useless when using OpenGL 1.1
##------------------------------------------------------------------------------------

####  Shader loading/unloading functions

##  Load shader from files and bind default locations
proc LoadShader*(vsFileName: cstring; fsFileName: cstring): Shader
##  Load shader from code strings and bind default locations
proc LoadShaderCode*(vsCode: cstring; fsCode: cstring): Shader
##  Unload shader from GPU memory (VRAM)
proc UnloadShader*(shader: Shader)
##  Get default shader
proc GetShaderDefault*(): Shader
##  Get default texture
proc GetTextureDefault*(): Texture2D
##  Get texture to draw shapes
proc GetShapesTexture*(): Texture2D
##  Get texture rectangle to draw shapes
proc GetShapesTextureRec*(): Rectangle
##  Define default texture used to draw shapes
proc SetShapesTexture*(texture: Texture2D; source: Rectangle)

####  Shader configuration functions

##  Get shader uniform location
proc GetShaderLocation*(shader: Shader; uniformName: cstring): cint
##  Set shader uniform value
proc SetShaderValue*(shader: Shader; uniformLoc: cint; value: pointer;
                    uniformType: cint)
##  Set shader uniform value vector
proc SetShaderValueV*(shader: Shader; uniformLoc: cint; value: pointer;
                     uniformType: cint; count: cint)
##  Set shader uniform value (matrix 4x4)
proc SetShaderValueMatrix*(shader: Shader; uniformLoc: cint; mat: Matrix)
##  Set shader uniform value for texture
proc SetShaderValueTexture*(shader: Shader; uniformLoc: cint; texture: Texture2D)
##  Set a custom projection matrix (replaces internal projection matrix)
proc SetMatrixProjection*(proj: Matrix)
##  Set a custom modelview matrix (replaces internal modelview matrix)
proc SetMatrixModelview*(view: Matrix)
##  Get internal modelview matrix
proc GetMatrixModelview*(): Matrix
##  Get internal projection matrix
proc GetMatrixProjection*(): Matrix

#### Texture maps generation (PBR)
#### NOTE: Required shaders should be provided

##  Generate cubemap texture from 2D texture
proc GenTextureCubemap*(shader: Shader; map: Texture2D; size: cint): Texture2D
##  Generate irradiance texture using cubemap data
proc GenTextureIrradiance*(shader: Shader; cubemap: Texture2D; size: cint): Texture2D
##  Generate prefilter texture using cubemap data
proc GenTexturePrefilter*(shader: Shader; cubemap: Texture2D; size: cint): Texture2D
##  Generate BRDF texture
proc GenTextureBRDF*(shader: Shader; size: cint): Texture2D

#### Shading begin/end functions

##  Begin custom shader drawing
proc BeginShaderMode*(shader: Shader)
##  End custom shader drawing (use default shader)
proc EndShaderMode*()
##  Begin blending mode (alpha, additive, multiplied)
proc BeginBlendMode*(mode: cint)
##  End blending mode (reset to default: alpha blending)
proc EndBlendMode*()

#### VR control functions

##  Init VR simulator for selected device parameters
proc InitVrSimulator*()
##  Close VR simulator for current device
proc CloseVrSimulator*()
##  Update VR tracking (position and orientation) and camera
proc UpdateVrTracking*(camera: ptr Camera)
##  Set stereo rendering configuration parameters
proc SetVrConfiguration*(info: VrDeviceInfo; distortion: Shader)
##  Detect if VR simulator is ready
proc IsVrSimulatorReady*(): bool
##  Enable/Disable VR experience
proc ToggleVrMode*()
##  Begin VR simulator stereo rendering
proc BeginVrDrawing*()
##  End VR simulator stereo rendering
proc EndVrDrawing*()

##------------------------------------------------------------------------------------
## Audio Loading and Playing Functions
##------------------------------------------------------------------------------------

####  Audio device management functions

##  Initialize audio device and context
proc InitAudioDevice*()
##  Close the audio device and context (and music stream)
proc CloseAudioDevice*()
##  Check if audio device is ready
proc IsAudioDeviceReady*(): bool
##  Set master volume (listener)
proc SetMasterVolume*(volume: cfloat)

####  Wave/Sound loading/unloading functions

##  Load wave data from file
proc LoadWave*(fileName: cstring): Wave
##  Load sound from file
proc LoadSound*(fileName: cstring): Sound
##  Load sound from wave data
proc LoadSoundFromWave*(wave: Wave): Sound
##  Update sound buffer with new data
proc UpdateSound*(sound: Sound; data: pointer; samplesCount: cint)
##  Unload wave data
proc UnloadWave*(wave: Wave)
##  Unload sound
proc UnloadSound*(sound: Sound)
##  Export wave data to file
proc ExportWave*(wave: Wave; fileName: cstring)
##  Export wave sample data to code (.h)
proc ExportWaveAsCode*(wave: Wave; fileName: cstring)

####  Wave/Sound management functions

##  Play a sound
proc PlaySound*(sound: Sound)
##  Stop playing a sound
proc StopSound*(sound: Sound)
##  Pause a sound
proc PauseSound*(sound: Sound)
##  Resume a paused sound
proc ResumeSound*(sound: Sound)
##  Play a sound (using multichannel buffer pool)
proc PlaySoundMulti*(sound: Sound)
##  Stop any sound playing (using multichannel buffer pool)
proc StopSoundMulti*()
##  Get number of sounds playing in the multichannel
proc GetSoundsPlaying*(): cint
##  Check if a sound is currently playing
proc IsSoundPlaying*(sound: Sound): bool
##  Set volume for a sound (1.0 is max level)
proc SetSoundVolume*(sound: Sound; volume: cfloat)
##  Set pitch for a sound (1.0 is base level)
proc SetSoundPitch*(sound: Sound; pitch: cfloat)
##  Convert wave data to desired format
proc WaveFormat*(wave: ptr Wave; sampleRate: cint; sampleSize: cint; channels: cint)
##  Copy a wave to a new wave
proc WaveCopy*(wave: Wave): Wave
##  Crop a wave to defined samples range
proc WaveCrop*(wave: ptr Wave; initSample: cint; finalSample: cint)
##  Get samples data from wave as a floats array
proc GetWaveData*(wave: Wave): ptr cfloat

####  Music management functions

##  Load music stream from file
proc LoadMusicStream*(fileName: cstring): Music
##  Unload music stream
proc UnloadMusicStream*(music: Music)
##  Start music playing
proc PlayMusicStream*(music: Music)
##  Updates buffers for music streaming
proc UpdateMusicStream*(music: Music)
##  Stop music playing
proc StopMusicStream*(music: Music)
##  Pause music playing
proc PauseMusicStream*(music: Music)
##  Resume playing paused music
proc ResumeMusicStream*(music: Music)
##  Check if music is playing
proc IsMusicPlaying*(music: Music): bool
##  Set volume for music (1.0 is max level)
proc SetMusicVolume*(music: Music; volume: cfloat)
##  Set pitch for a music (1.0 is base level)
proc SetMusicPitch*(music: Music; pitch: cfloat)
##  Set music loop count (loop repeats)
proc SetMusicLoopCount*(music: Music; count: cint)
##  Get music time length (in seconds)
proc GetMusicTimeLength*(music: Music): cfloat
##  Get current music time played (in seconds)
proc GetMusicTimePlayed*(music: Music): cfloat

####  AudioStream management functions

##  Init audio stream (to stream raw audio pcm data)
proc InitAudioStream*(sampleRate: cuint; sampleSize: cuint; channels: cuint): AudioStream
##  Update audio stream buffers with data
proc UpdateAudioStream*(stream: AudioStream; data: pointer; samplesCount: cint)
##  Close audio stream and free memory
proc CloseAudioStream*(stream: AudioStream)
##  Check if any audio stream buffers requires refill
proc IsAudioStreamProcessed*(stream: AudioStream): bool
##  Play audio stream
proc PlayAudioStream*(stream: AudioStream)
##  Pause audio stream
proc PauseAudioStream*(stream: AudioStream)
##  Resume audio stream
proc ResumeAudioStream*(stream: AudioStream)
##  Check if audio stream is playing
proc IsAudioStreamPlaying*(stream: AudioStream): bool
##  Stop audio stream
proc StopAudioStream*(stream: AudioStream)
##  Set volume for audio stream (1.0 is max level)
proc SetAudioStreamVolume*(stream: AudioStream; volume: cfloat)
##  Set pitch for audio stream (1.0 is base level)
proc SetAudioStreamPitch*(stream: AudioStream; pitch: cfloat)
##  Default size for new audio streams
proc SetAudioStreamBufferSizeDefault*(size: cint)

{.pop.}

template FormatText*(text: cstring, args: varargs[untyped]): cstring  =
  TextFormat(text, args)
template SubText*(text: cstring, position: cint, length: cint ): cstring  =
  TextSubtext(text, position, length)
template ShowWindow*() =
  UnhideWindow()
template LoadText*(fileName: cstring): cstring  =
  LoadFileText(fileName)
