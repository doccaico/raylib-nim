import raylib
import raylib/easings

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - easings ball anim")

var
  ballPositionX = -100.cint
  ballRadius = 20.cint
  ballAlpha = 0.0.cfloat
  state = 0.cint
  framesCounter = 0.cint

SetTargetFPS(60)

while not WindowShouldClose():
  if state == 0:
    inc framesCounter
    ballPositionX = EaseElasticOut(framesCounter.cfloat, -100,
        screenWidth/2 + 100, 120).cint
    if framesCounter >= 120:
      framesCounter = 0
      state = 1
  elif state == 1:
    inc framesCounter
    ballRadius = EaseElasticIn(framesCounter.cfloat, 20, 500, 200).cint
    if framesCounter >= 200:
      framesCounter = 0
      state = 2
  elif state == 2:
    inc framesCounter
    ballAlpha = EaseCubicOut(framesCounter.cfloat, 0.0, 1.0, 200)
    if framesCounter >= 200:
      framesCounter = 0
      state = 3
  elif state == 3:
    if IsKeyPressed(KEY_ENTER):
      ballPositionX = -100
      ballRadius = 20
      ballAlpha = 0.0
      state = 0

  if IsKeyPressed(KEY_R):
    framesCounter = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  if state >= 2:
    DrawRectangle(0, 0, screenWidth, screenHeight, GREEN)
  DrawCircle(ballPositionX, 200, ballRadius.cfloat, Fade(RED, 1.0 - ballAlpha))

  if state == 3:
    DrawText("PRESS [ENTER] TO PLAY AGAIN!", 240, 200, 20, BLACK)

  EndDrawing()

CloseWindow()
