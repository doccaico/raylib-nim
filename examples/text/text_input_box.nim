import raylib

# Check if any key is pressed
# NOTE: We limit keys check to keys between 32 (KEY_SPACE) and 126
proc IsAnyKeyPressed(): bool =
  let key = GetKeyPressed()
  if (key >= 32) and (key <= 126):
    result = true

const
  MAX_INPUT_CHARS = 9
  screenWidth = 800
  screenHeight = 450

var
  name: array[MAX_INPUT_CHARS + 1, cchar]
  letterCount = 0.cint
  textBox = Rectangle(x: screenWidth/2 - 100, y: 180, width: 225, height: 50)
  mouseOnText = false
  framesCounter = 0.cint

InitWindow(screenWidth, screenHeight, "raylib [text] example - input box")
SetTargetFPS(60)

while not WindowShouldClose():

  if CheckCollisionPointRec(GetMousePosition(), textBox):
    mouseOnText = true
  else:
    mouseOnText = false

  if mouseOnText:
    var key = GetKeyPressed()
    while key > 0:
      if key >= 32 and key <= 125 and letterCount < MAX_INPUT_CHARS:
        name[letterCount] = key.cchar
        inc letterCount
      key = GetKeyPressed()
    if IsKeyPressed(KEY_BACKSPACE):
      dec letterCount
      name[letterCount] = '\0'
      if letterCount < 0:
        letterCount = 0
  if mouseOnText:
    inc framesCounter
  else:
    framesCounter = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawText("PLACE MOUSE OVER INPUT BOX!", 240, 140, 20, GRAY)
  DrawRectangleRec(textBox, LIGHTGRAY)
  if mouseOnText:
    DrawRectangleLines(textBox.x.cint, textBox.y.cint, textBox.width.cint, textBox.height.cint, RED)
  else:
    DrawRectangleLines(textBox.x.cint, textBox.y.cint, textBox.width.cint, textBox.height.cint, DARKGRAY)
  DrawText(name.addr, (textBox.x + 5).cint, (textBox.y + 8).cint, 40, MAROON)
  DrawText(FormatText("INPUT CHARS: %i/%i", letterCount, MAX_INPUT_CHARS), 315, 250, 20, DARKGRAY)

  EndDrawing()
CloseWindow()
