import raylib

const
  screenWidth = 800
  screenHeight = 450

let message = "This sample illustrates a text writing\nanimation effect! Check it out! ;)"
var framesCounter = 0.cint

InitWindow(screenWidth, screenHeight, "raylib [text] example - text writing anim")
SetTargetFPS(60)

while not WindowShouldClose():

  if IsKeyDown(KEY_SPACE):
    framesCounter += 8
  else:
    inc framesCounter

  if IsKeyPressed(KEY_ENTER):
    framesCounter = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText(TextSubtext(message, 0, (framesCounter/10).cint), 210, 160, 20, MAROON)
  DrawText("PRESS [ENTER] to RESTART!", 240, 260, 20, LIGHTGRAY)
  DrawText("PRESS [SPACE] to SPEED UP!", 239, 300, 20, LIGHTGRAY)
  EndDrawing()
CloseWindow()
