import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - texture waves")

var
  texture = LoadTexture("resources/space.png")
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/wave.fs", GLSL_VERSION))
  secondsLoc = GetShaderLocation(shader, "secondes")
  freqXLoc = GetShaderLocation(shader, "freqX")
  freqYLoc = GetShaderLocation(shader, "freqY")
  ampXLoc = GetShaderLocation(shader, "ampX")
  ampYLoc = GetShaderLocation(shader, "ampY")
  speedXLoc = GetShaderLocation(shader, "speedX")
  speedYLoc = GetShaderLocation(shader, "speedY")
  freqX = 25.0.cfloat
  freqY = 25.0.cfloat
  ampX = 5.0.cfloat
  ampY = 5.0.cfloat
  speedX = 8.0.cfloat
  speedY = 8.0.cfloat
  screenSize = [GetScreenWidth().cfloat, GetScreenHeight().cfloat]
  seconds = 0.0.cfloat

SetShaderValue(shader, GetShaderLocation(shader, "size"),
    cast[ptr cfloat](screenSize.addr), UNIFORM_VEC2)
SetShaderValue(shader, freqXLoc, freqX.addr, UNIFORM_FLOAT)
SetShaderValue(shader, freqYLoc, freqY.addr, UNIFORM_FLOAT)
SetShaderValue(shader, ampXLoc, ampX.addr, UNIFORM_FLOAT)
SetShaderValue(shader, ampYLoc, ampY.addr, UNIFORM_FLOAT)
SetShaderValue(shader, speedXLoc, speedX.addr, UNIFORM_FLOAT)
SetShaderValue(shader, speedYLoc, speedY.addr, UNIFORM_FLOAT)

SetTargetFPS(60)

while not WindowShouldClose():
  seconds += GetFrameTime()
  SetShaderValue(shader, secondsLoc, seconds.addr, UNIFORM_FLOAT)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginShaderMode(shader)
  DrawTexture(texture, 0, 0, WHITE)
  DrawTexture(texture, texture.width, 0, WHITE)
  EndShaderMode()

  EndDrawing()

UnloadShader(shader)
UnloadTexture(texture)
CloseWindow()
