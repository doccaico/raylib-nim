import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

type
  PostproShader = enum
    FX_GRAYSCALE
    FX_POSTERIZATION
    FX_DREAM_VISION
    FX_PIXELIZER
    FX_CROSS_HATCHING
    FX_CROSS_STITCHING
    FX_PREDATOR_VIEW
    FX_SCANLINES
    FX_FISHEYE
    FX_SOBEL
    FX_BLOOM
    FX_BLUR

var postproShaderText = [
    "GRAYSCALE".cstring,
    "POSTERIZATION",
    "DREAM_VISION",
    "PIXELIZER",
    "CROSS_HATCHING",
    "CROSS_STITCHING",
    "PREDATOR_VIEW",
    "SCANLINES",
    "FISHEYE",
    "SOBEL",
    "BLOOM",
    "BLUR",]

const
  MAX_POSTPRO_SHADERS = 12
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight,
    "raylib [shaders] example - postprocessing shader")

var
  camera = Camera(
      position: Vector3(x: 2.0, y: 3.0, z: 2.0),
      target: Vector3(x: 0.0, y: 1.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: 0.cint)
  model = LoadModel("resources/models/church.obj")
  texture = LoadTexture("resources/models/church_diffuse.png")
  position = Vector3(x: 0.0, y: 0.0, z: 0.0)
  shaders: array[MAX_POSTPRO_SHADERS, Shader]
  currentShader = FX_GRAYSCALE.cint
  target = LoadRenderTexture(screenWidth, screenHeight)

# model.materials[0].maps[MAP_DIFFUSE].texture = texture
cast[ptr MaterialMap](
    cast[ByteAddress](model.materials.maps) +%
    MAP_DIFFUSE * sizeof(model.materials.maps[])).texture = texture

shaders[FX_GRAYSCALE.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/grayscale.fs", GLSL_VERSION))
shaders[FX_POSTERIZATION.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/posterization.fs", GLSL_VERSION))
shaders[FX_DREAM_VISION.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/dream_vision.fs", GLSL_VERSION))
shaders[FX_PIXELIZER.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/pixelizer.fs", GLSL_VERSION))
shaders[FX_CROSS_HATCHING.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/cross_hatching.fs", GLSL_VERSION))
shaders[FX_CROSS_STITCHING.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/cross_stitching.fs", GLSL_VERSION))
shaders[FX_PREDATOR_VIEW.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/predator.fs", GLSL_VERSION))
shaders[FX_SCANLINES.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/scanlines.fs", GLSL_VERSION))
shaders[FX_FISHEYE.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/fisheye.fs", GLSL_VERSION))
shaders[FX_SOBEL.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/sobel.fs", GLSL_VERSION))
shaders[FX_BLOOM.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/bloom.fs", GLSL_VERSION))
shaders[FX_BLUR.ord] = LoadShader(nil,
    FormatText("resources/shaders/glsl%i/blur.fs", GLSL_VERSION))

SetCameraMode(camera, CAMERA_ORBITAL)
SetTargetFPS(60)

while not WindowShouldClose():

  UpdateCamera(camera.addr)

  if IsKeyPressed(KEY_RIGHT): inc currentShader
  elif IsKeyPressed(KEY_LEFT): dec currentShader

  if currentShader >= MAX_POSTPRO_SHADERS: currentShader = 0
  elif currentShader < 0: currentShader = MAX_POSTPRO_SHADERS - 1

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginTextureMode(target)
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, position, 0.1, WHITE)
  DrawGrid(10, 1.0)
  EndMode3D()

  EndTextureMode()

  BeginShaderMode(shaders[currentShader])
  DrawTextureRec(target.texture,
      Rectangle(x: 0.0, y: 0.0,
          width: target.texture.width.cfloat, height: -target.texture.height.cfloat),
      Vector2(x: 0.0, y: 0.0), WHITE)
  EndShaderMode()

  DrawRectangle(0, 9, 580, 30, Fade(LIGHTGRAY, 0.7))
  DrawText("(c) Church 3D model by Alberto Cano", screenWidth - 200,
      screenHeight - 20, 10, GRAY)

  DrawText("CURRENT POSTPRO SHADER:", 10, 15, 20, BLACK)
  DrawText(postproShaderText[currentShader], 330, 15, 20, RED)
  DrawText("< >", 540, 10, 30, DARKBLUE)

  DrawFPS(700, 15)
  EndDrawing()

for i in 0..<MAX_POSTPRO_SHADERS:
  UnloadShader(shaders[i])
UnloadTexture(texture)
UnloadModel(model)
UnloadRenderTexture(target)
CloseWindow()
