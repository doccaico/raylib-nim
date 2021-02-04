import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [shaders] example - shapes and texture shaders")

var
  fudesumi = LoadTexture("resources/fudesumi.png")
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/grayscale.fs",
      GLSL_VERSION))

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawText("USING DEFAULT SHADER", 20, 40, 10, RED)
  DrawCircle(80, 120, 35, DARKBLUE)
  DrawCircleGradient(80, 220, 60, GREEN, SKYBLUE)
  DrawCircleLines(80, 340, 80, DARKBLUE)

  BeginShaderMode(shader)
  DrawText("USING CUSTOM SHADER", 190, 40, 10, RED)
  DrawRectangle(250 - 60, 90, 120, 60, RED)
  DrawRectangleGradientH(250 - 90, 170, 180, 130, MAROON, GOLD)
  DrawRectangleLines(250 - 40, 320, 80, 60, ORANGE)
  EndShaderMode()

  DrawText("USING DEFAULT SHADER", 370, 40, 10, RED)

  DrawTriangle(
      Vector2(x: 430, y: 80),
      Vector2(x: 430 - 60, y: 150),
      Vector2(x: 430 + 60, y: 150), VIOLET)

  DrawTriangleLines(
      Vector2(x: 430, y: 160),
      Vector2(x: 430 - 20, y: 230),
      Vector2(x: 430 + 20, y: 230), DARKBLUE)

  DrawPoly(Vector2(x: 430, y: 320), 6, 80, 0, BROWN)

  BeginShaderMode(shader)
  DrawTexture(fudesumi, 500, -30, WHITE)
  EndShaderMode()

  DrawText("(c) Fudesumi sprite by Eiden Marsal", 380, screenHeight - 20, 10, GRAY)

  EndDrawing()
CloseWindow()
