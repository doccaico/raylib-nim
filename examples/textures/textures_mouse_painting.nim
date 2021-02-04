import raylib

const
  MAX_COLORS_COUNT = 23
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - mouse painting")
var
  colors = [RAYWHITE, YELLOW, GOLD, ORANGE, PINK, RED, MAROON, GREEN, LIME, DARKGREEN,
      SKYBLUE, BLUE, DARKBLUE, PURPLE, VIOLET, DARKPURPLE, BEIGE, BROWN, DARKBROWN,
      LIGHTGRAY, GRAY, DARKGRAY, BLACK]
  colorsRecs: array[MAX_COLORS_COUNT, Rectangle]

for i in 0..<MAX_COLORS_COUNT:
  colorsRecs[i].x = (10 + 30*i + 2*i).cfloat
  colorsRecs[i].y = 10.0
  colorsRecs[i].width = 30.0
  colorsRecs[i].height = 30.0

var
  colorSelected = 0
  colorSelectedPrev = colorSelected
  colorMouseHover = 0
  brushSize = 20
  btnSaveRec = Rectangle(x: 750, y: 10, width: 40, height: 30)
  btnSaveMouseHover = false
  showSaveMessage = false
  saveMessageCounter = 0
  target = LoadRenderTexture(screenWidth, screenHeight)

BeginTextureMode(target)
ClearBackground(colors[0])
EndTextureMode()

SetTargetFPS(120)

while not WindowShouldClose():
  var mousePos = GetMousePosition()
  
  if IsKeyPressed(KEY_RIGHT):
    inc colorSelected
  elif IsKeyPressed(KEY_LEFT):
    dec colorSelected
  
  if colorSelected >= MAX_COLORS_COUNT:
    colorSelected = MAX_COLORS_COUNT - 1
  elif colorSelected < 0:
    colorSelected = 0

  for i in 0..<MAX_COLORS_COUNT:
    if CheckCollisionPointRec(mousePos, colorsRecs[i]):
      colorMouseHover = i
      break
    else:
      colorMouseHover = -1

  if colorMouseHover >= 0 and IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    colorSelected = colorMouseHover
    colorSelectedPrev = colorSelected

  brushSize += GetMouseWheelMove()*5
  if brushSize < 2:
    brushSize = 2
  if brushSize > 50:
    brushSize = 50

  if IsKeyPressed(KEY_C):
    BeginTextureMode(target)
    ClearBackground(colors[0])
    EndTextureMode()

  if IsMouseButtonDown(MOUSE_LEFT_BUTTON) or GetGestureDetected() == GESTURE_DRAG:
    BeginTextureMode(target)
    if mousePos.y > 50:
      DrawCircle(mousePos.x.cint, mousePos.y.cint, brushSize.cfloat, colors[colorSelected])
    EndTextureMode()

  if IsMouseButtonDown(MOUSE_RIGHT_BUTTON):
    colorSelected = 0
    BeginTextureMode(target)
    if mousePos.y > 50:
      DrawCircle(mousePos.x.cint, mousePos.y.cint, brushSize.cfloat, colors[0])
    EndTextureMode()
  else:
    colorSelected = colorSelectedPrev

  if CheckCollisionPointRec(mousePos, btnSaveRec):
    btnSaveMouseHover = true
  else:
    btnSaveMouseHover = false

  if btnSaveMouseHover and IsMouseButtonReleased(MOUSE_LEFT_BUTTON) or
      IsKeyPressed(KEY_S):
    var image = GetTextureData(target.texture)
    ImageFlipVertical(image.addr)
    ExportImage(image, "my_amazing_texture_painting.png")
    UnloadImage(image)
    showSaveMessage = true

  if showSaveMessage:
    inc saveMessageCounter
    if saveMessageCounter > 240:
      showSaveMessage = false
      saveMessageCounter = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawTextureRec(target.texture,
      Rectangle(x: 0.0, y: 0.0,
          width: target.texture.width.cfloat, height: -target.texture.height.cfloat),
      Vector2(x: 0, y: 0), WHITE)

  if mousePos.y > 50:
    if IsMouseButtonDown(MOUSE_RIGHT_BUTTON):
      DrawCircleLines(mousePos.x.cint, mousePos.y.cint, brushSize.cfloat, GRAY)
    else:
      DrawCircle(GetMouseX(), GetMouseY(), brushSize.cfloat, colors[colorSelected])

  DrawRectangle(0, 0, GetScreenWidth(), 50, RAYWHITE)
  DrawLine(0, 50, GetScreenWidth(), 50, LIGHTGRAY)
  for i in 0..<MAX_COLORS_COUNT:
    DrawRectangleRec(colorsRecs[i], colors[i])
  DrawRectangleLines(10, 10, 30, 30, LIGHTGRAY)

  if colorMouseHover >= 0:
    DrawRectangleRec(colorsRecs[colorMouseHover], Fade(WHITE, 0.6))

  DrawRectangleLinesEx(Rectangle(x: colorsRecs[colorSelected].x - 2,
      y: colorsRecs[colorSelected].y - 2, width: colorsRecs[colorSelected].width + 4,
      height: colorsRecs[colorSelected].height + 4), 2, BLACK)

  DrawRectangleLinesEx(btnSaveRec, 2, if btnSaveMouseHover: RED else: BLACK)
  DrawText("SAVE!", 755, 20, 10, if btnSaveMouseHover: RED else: BLACK)

  if showSaveMessage:
    DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Fade(RAYWHITE, 0.8))
    DrawRectangle(0, 150, GetScreenWidth(), 80, BLACK)
    DrawText("IMAGE SAVED:  my_amazing_texture_painting.png", 150, 180, 20, RAYWHITE)

  EndDrawing()
UnloadRenderTexture(target)
CloseWindow()
