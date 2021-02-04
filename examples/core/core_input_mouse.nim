import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  ballPosition = Vector2(x: -100.0, y: -100.0)
  ballColor = DARKBLUE;

InitWindow(screenWidth, screenHeight, "raylib [core] example - mouse input")
SetTargetFPS(60)

while not WindowShouldClose():
  ballPosition = GetMousePosition()
  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    ballColor = MAROON
  elif IsMouseButtonPressed(MOUSE_MIDDLE_BUTTON):
    ballColor = LIME
  elif IsMouseButtonPressed(MOUSE_RIGHT_BUTTON):
    ballColor = DARKBLUE
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawCircleV(ballPosition, 40, ballColor)
  DrawText("move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY)
  EndDrawing()
CloseWindow()
