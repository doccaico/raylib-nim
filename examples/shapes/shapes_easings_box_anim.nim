import raylib
import raylib/easings

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - easings box anim")

var
  rec = Rectangle(x: GetScreenWidth()/2, y: -100, width: 100, height: 100)
  rotation = 0.0.cfloat
  alpha = 1.0.cfloat
  state = 0.cint
  framesCounter = 0.cint

SetTargetFPS(60)

while not WindowShouldClose():
  case state:
    of 0:
      inc framesCounter
      rec.y = EaseElasticOut(framesCounter.cfloat, -100, GetScreenHeight()/2 + 100, 120)
      if framesCounter >= 120:
        framesCounter = 0
        state = 1
    of 1:
      inc framesCounter
      rec.height = EaseBounceOut(framesCounter.cfloat, 100, -90, 120)
      rec.width = EaseBounceOut(framesCounter.cfloat, 100, GetScreenWidth().cfloat, 120)
      if framesCounter >= 120:
        framesCounter = 0
        state = 2
    of 2:
      inc framesCounter
      rotation = EaseQuadOut(framesCounter.cfloat, 0.0, 270.0, 240)
      if framesCounter >= 240:
        framesCounter = 0
        state = 3
    of 3:
      inc framesCounter
      rec.height = EaseCircOut(framesCounter.cfloat, 10, GetScreenWidth().cfloat, 120)
      if framesCounter >= 120:
        framesCounter = 0
        state = 4
    of 4:
      inc framesCounter
      alpha = EaseSineOut(framesCounter.cfloat, 1.0, -1.0, 160)
      if framesCounter >= 160:
        framesCounter = 0
        state = 5
    else: discard

  if IsKeyPressed(KEY_SPACE):
    rec = Rectangle(x: GetScreenWidth()/2, y: -100, width: 100, height: 100)
    rotation = 0.0
    alpha = 1.0
    state = 0
    framesCounter = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawRectanglePro(rec, Vector2(x: rec.width/2, y: rec.height/2),
      rotation, Fade(BLACK, alpha))

  DrawText("PRESS [SPACE] TO RESET BOX ANIMATION!",
      10, GetScreenHeight() - 25, 20, LIGHTGRAY)

  EndDrawing()

CloseWindow()
