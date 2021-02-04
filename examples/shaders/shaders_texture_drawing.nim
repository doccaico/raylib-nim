import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - texture drawing")

var
  imBlank = GenImageColor(1024, 1024, BLANK)
  texture = LoadTextureFromImage(imBlank)
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/cubes_panning.fs",
      GLSL_VERSION))
  time = 0.0.cfloat
  timeLoc = GetShaderLocation(shader, "uTime")

UnloadImage(imBlank)

SetShaderValue(shader, timeLoc, time.addr, UNIFORM_FLOAT)

SetTargetFPS(60)

while not WindowShouldClose():
  time = GetTime()
  SetShaderValue(shader, timeLoc, time.addr, UNIFORM_FLOAT)

  BeginDrawing()
  ClearBackground(RAYWHITE)
  BeginShaderMode(shader)
  DrawTexture(texture, 0, 0, WHITE)
  EndShaderMode()

  DrawText("BACKGROUND is PAINTED and ANIMATED on SHADER!", 10, 10, 20, MAROON);
  EndDrawing()

UnloadShader(shader)
CloseWindow()
