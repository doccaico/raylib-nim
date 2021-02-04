import raylib

# I can compile it, but I haven't tested it. I don't have the device yet.

const
  MAX_TOUCH_POINTS = 10
  screenWidth = 800
  screenHeight = 450

var
  ballPosition = Vector2(x: -100.0, y: -100.0)
  ballColor = BEIGE
  touchCounter = 0
  touchPosition: Vector2

InitWindow(screenWidth, screenHeight, "raylib [core] example - input multitouch")
SetTargetFPS(60)

while not WindowShouldClose():
  ballPosition = GetMousePosition()
  ballColor = BEIGE

  if IsMouseButtonDown(MOUSE_LEFT_BUTTON):
    ballColor = MAROON
  if IsMouseButtonDown(MOUSE_MIDDLE_BUTTON):
    ballColor = LIME
  if IsMouseButtonDown(MOUSE_RIGHT_BUTTON):
    ballColor = DARKBLUE

  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    touchCounter = 10
  if IsMouseButtonPressed(MOUSE_MIDDLE_BUTTON):
    touchCounter = 10
  if IsMouseButtonPressed(MOUSE_RIGHT_BUTTON):
    touchCounter = 10

  if touchCounter > 0:
    dec touchCounter

  BeginDrawing()
  ClearBackground(RAYWHITE)

  for i in 0..<MAX_TOUCH_POINTS:
    touchPosition = GetTouchPosition(i.cint)
    if touchPosition.x >= 0 and touchPosition.y >= 0:
      DrawCircleV(touchPosition, 34, ORANGE)
      DrawText(TextFormat("%d", i), (touchPosition.x - 10.0).cint, (
          touchPosition.y - 70.0).cint, 40, BLACK)

  DrawCircleV(ballPosition, (30 + touchCounter*3).cfloat, ballColor)
  DrawText("move ball with mouse and click mouse button to change color", 10,
      10, 20, DARKGRAY)
  DrawText("touch the screen at multiple locations to get multiple balls", 10,
      30, 20, DARKGRAY)
  EndDrawing()
CloseWindow()
