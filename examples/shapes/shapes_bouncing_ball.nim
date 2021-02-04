import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - bouncing ball")

var
  ballPosition = Vector2(x: GetScreenWidth()/2, y: GetScreenHeight()/2)
  ballSpeed = Vector2(x: 5.0, y: 4.0)
  ballRadius = 20.cint
  pause = false
  framesCounter = 0.cint

SetTargetFPS(60)

while not WindowShouldClose():

  if IsKeyPressed(KEY_SPACE):
    pause = not pause

  if not pause:
    ballPosition.x += ballSpeed.x
    ballPosition.y += ballSpeed.y

    if ballPosition.x >= (GetScreenWidth() - ballRadius).cfloat or
        ballPosition.x <= ballRadius.cfloat:
      ballSpeed.x *= -1.0
    if ballPosition.y >= (GetScreenHeight() - ballRadius).cfloat or
        ballPosition.y <= ballRadius.cfloat:
      ballSpeed.y *= -1.0
  else:
    inc framesCounter

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawCircleV(ballPosition, ballRadius.cfloat, MAROON)
  DrawText("PRESS SPACE to PAUSE BALL MOVEMENT",
      10, GetScreenHeight() - 25, 20, LIGHTGRAY)

  if pause and (framesCounter/30).cint mod 2 != 0:
    DrawText("PAUSED", 350, 200, 30, GRAY)
  DrawFPS(10, 10)

  EndDrawing()
CloseWindow()
