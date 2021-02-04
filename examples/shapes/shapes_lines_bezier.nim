import raylib

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)
InitWindow(screenWidth, screenHeight, "raylib [shapes] example - cubic-bezier lines")

var
  sp: Vector2
  ep = Vector2(x: screenWidth, y: screenHeight)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsMouseButtonDown(MOUSE_LEFT_BUTTON):
    sp = GetMousePosition()
  elif IsMouseButtonDown(MOUSE_RIGHT_BUTTON):
    ep = GetMousePosition()

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("USE MOUSE LEFT-RIGHT CLICK to DEFINE LINE START and END POINTS",
      15, 20, 20, GRAY)
  DrawLineBezier(sp, ep, 2.0, RED)
  EndDrawing()
CloseWindow()
