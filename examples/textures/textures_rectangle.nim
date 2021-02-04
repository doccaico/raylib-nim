import raylib

const
  MAX_FRAME_SPEED = 15
  MIN_FRAME_SPEED = 1
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [texture] example - texture rectangle")

var
  scarfy = LoadTexture("resources/scarfy.png")
  position = Vector2(x: 350.0, y: 280.0)
  frameRec = Rectangle(x: 0.0, y: 0.0,
      width: (scarfy.width/6).cfloat, height: scarfy.height.cfloat)
  currentFrame = 0.cint
  framesCounter = 0.cint
  framesSpeed = 8.cint

SetTargetFPS(60)

while not WindowShouldClose():

  inc framesCounter

  if framesCounter >= (60/framesSpeed).cint:
    framesCounter = 0
    inc currentFrame
    if currentFrame > 5:
      currentFrame = 0
    frameRec.x = currentFrame.cfloat*(scarfy.width/6).cfloat

  if IsKeyPressed(KEY_RIGHT): inc framesSpeed
  elif IsKeyPressed(KEY_LEFT): dec framesSpeed

  if framesSpeed > MAX_FRAME_SPEED: framesSpeed = MAX_FRAME_SPEED
  elif framesSpeed < MIN_FRAME_SPEED: framesSpeed = MIN_FRAME_SPEED

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawTexture(scarfy, 15, 40, WHITE)
  DrawRectangleLines(15, 40, scarfy.width, scarfy.height, LIME)
  DrawRectangleLines((15 + frameRec.x).cint, (40 + frameRec.y).cint,
      frameRec.width.cint, frameRec.height.cint, RED)

  DrawText("FRAME SPEED: ", 165, 210, 10, DARKGRAY)
  DrawText(FormatText("%02i FPS", framesSpeed), 575, 210, 10, DARKGRAY)
  DrawText("PRESS RIGHT/LEFT KEYS to CHANGE SPEED!", 290, 240, 10, DARKGRAY)

  for i in 0.cint..<MAX_FRAME_SPEED:
    if i < framesSpeed:
      DrawRectangle(250 + 21*i, 205, 20, 20, RED)
    DrawRectangleLines(250 + 21*i, 205, 20, 20, MAROON)

  DrawTextureRec(scarfy, frameRec, position, WHITE)
  DrawText("(c) Scarfy sprite by Eiden Marsal",
      screenWidth - 200, screenHeight - 20, 10, GRAY)

  EndDrawing()

UnloadTexture(scarfy)
CloseWindow()
