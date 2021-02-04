import raylib
import raylib/easings

const
  RECS_WIDTH = 50
  RECS_HEIGHT = 50
  MAX_RECS_X = 800 div RECS_WIDTH
  MAX_RECS_Y = 450 div RECS_HEIGHT
  PLAY_TIME_IN_FRAMES = 240
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - easings rectangle array")

var
  recs: array[MAX_RECS_X*MAX_RECS_Y, Rectangle]
  rotation = 0.0.cfloat
  framesCounter = 0.cint
  state = 0.cint

for y in 0..<MAX_RECS_Y:
  for x in 0..<MAX_RECS_X:
    recs[y*MAX_RECS_X + x].x = (RECS_WIDTH div 2 + RECS_WIDTH*x).cfloat
    recs[y*MAX_RECS_X + x].y = (RECS_HEIGHT div 2 + RECS_HEIGHT*y).cfloat
    recs[y*MAX_RECS_X + x].width = RECS_WIDTH
    recs[y*MAX_RECS_X + x].height = RECS_HEIGHT

SetTargetFPS(60)

while not WindowShouldClose():

  if state == 0:
    inc framesCounter
    for i in 0..<MAX_RECS_X*MAX_RECS_Y:
      recs[i].height = EaseCircOut(
          framesCounter.cfloat, RECS_HEIGHT, -RECS_HEIGHT, PLAY_TIME_IN_FRAMES)
      recs[i].width = EaseCircOut(
          framesCounter.cfloat, RECS_WIDTH, -RECS_WIDTH, PLAY_TIME_IN_FRAMES)
      if recs[i].height < 0: recs[i].height = 0
      if recs[i].width < 0: recs[i].width = 0
      if recs[i].height == 0 and recs[i].width == 0: state = 1
      rotation = EaseLinearIn(framesCounter.cfloat, 0.0, 360.0, PLAY_TIME_IN_FRAMES)
  elif state == 1 and IsKeyPressed(KEY_SPACE):
    framesCounter = 0
    for i in 0..<MAX_RECS_X*MAX_RECS_Y:
      recs[i].height = RECS_HEIGHT
      recs[i].width = RECS_WIDTH
    state = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  if state == 0:
    for i in 0..<MAX_RECS_X*MAX_RECS_Y:
      DrawRectanglePro(recs[i], Vector2(x: recs[i].width/2, y: recs[i].height/2),
          rotation, RED)
  elif state == 1: DrawText("PRESS [SPACE] TO PLAY AGAIN!", 240, 200, 20, GRAY)

  EndDrawing()

CloseWindow()
