import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  boxPositionY = (screenHeight/2).cint - 40
  scrollSpeed = 4.cint

InitWindow(screenWidth, screenHeight, "raylib [core] example - input mouse wheel")
SetTargetFPS(60)

while not WindowShouldClose():
  boxPositionY = boxPositionY - (GetMouseWheelMove() * scrollSpeed)
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawRectangle((screenWidth/2).cint - 40, boxPositionY, 80, 80, MAROON)
  DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, GRAY)
  DrawText(TextFormat("Box position Y: %03i", boxPositionY), 10, 40, 20, LIGHTGRAY)
  EndDrawing()
CloseWindow()
