import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - basic shapes drawing")
SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("some basic shapes available on raylib", 20, 20, 20, DARKGRAY)

  DrawCircle((screenWidth/4).cint, 120, 35, DARKBLUE)

  DrawRectangle((screenWidth/4).cint*2 - 60, 100, 120, 60, RED)
  DrawRectangleLines((screenWidth/4).cint*2 - 40, 320, 80, 60, ORANGE)
  DrawRectangleGradientH((screenWidth/4).cint*2 - 90, 170, 180, 130, MAROON, GOLD)

  DrawTriangle(
      Vector2(x: screenWidth/4*3, y: 80),
      Vector2(x: screenWidth/4*3 - 60, y: 150),
      Vector2(x: screenWidth/4*3 + 60, y: 150),
      VIOLET)

  DrawPoly(Vector2(x: screenWidth/4*3, y: 320), 6, 80, 0, BROWN)

  DrawCircleGradient((screenWidth/4).cint, 220, 60, GREEN, SKYBLUE)

  DrawLine(18, 42, screenWidth - 18, 42, BLACK)
  DrawCircleLines((screenWidth/4).cint, 340, 80, DARKBLUE)
  DrawTriangleLines(
      Vector2(x: screenWidth/4*3, y: 160),
      Vector2(x: screenWidth/4*3 - 20, y: 230),
      Vector2(x: screenWidth/4*3 + 20, y: 230),
      DARKBLUE)
  EndDrawing()
CloseWindow()
