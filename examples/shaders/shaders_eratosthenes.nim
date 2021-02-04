import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - Sieve of Eratosthenes")

var target = LoadRenderTexture(screenWidth, screenHeight)
var shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/eratosthenes.fs",
    GLSL_VERSION))

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  BeginTextureMode(target)
  ClearBackground(BLACK)

  DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), BLACK)
  EndTextureMode()

  BeginShaderMode(shader)
  DrawTextureRec(target.texture,
      Rectangle(x: 0, y: 0,
          width: target.texture.width.cfloat,
          height: -target.texture.height.cfloat),
      Vector2(x: 0.0, y: 0.0), WHITE)
  EndShaderMode()
  EndDrawing()

UnloadShader(shader)
UnloadRenderTexture(target)
CloseWindow()
