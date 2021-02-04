import raylib

const
  screenWidth = 800
  screenHeight = 450
  msg = "Loaded Font"

InitWindow(screenWidth, screenHeight, "raylib [text] example - font filters")

var font = LoadFontEx("resources/KAISG.ttf", 96, nil, 0)

GenTextureMipmaps(font.texture.addr)

var
  fontSize = font.baseSize
  fontPosition = Vector2(x: 40.0, y: screenHeight/2 - 80)
  textSize = Vector2(x: 0.0, y: 0.0)
  currentFontFilter = 0.cint

SetTextureFilter(font.texture, FILTER_POINT)
SetTargetFPS(60)

while not WindowShouldClose():
  fontSize += GetMouseWheelMove() * 4

  if IsKeyPressed(KEY_ONE):
    SetTextureFilter(font.texture, FILTER_POINT)
    currentFontFilter = 0
  elif IsKeyPressed(KEY_TWO):
    SetTextureFilter(font.texture, FILTER_BILINEAR)
    currentFontFilter = 1
  elif IsKeyPressed(KEY_THREE):
    SetTextureFilter(font.texture, FILTER_TRILINEAR)
    currentFontFilter = 2

  textSize = MeasureTextEx(font, msg, fontSize.cfloat, 0)

  if IsKeyDown(KEY_LEFT):
    fontPosition.x -= 10
  elif IsKeyDown(KEY_RIGHT):
    fontPosition.x += 10

  if IsFileDropped():
    var count = 0.cint
    var droppedFiles = GetDroppedFiles(count.addr)
    if IsFileExtension(droppedFiles[0], ".ttf"):
      UnloadFont(font)
      font = LoadFontEx(droppedFiles[0], fontSize, nil, 0)
      ClearDroppedFiles()

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawText("Use mouse wheel to change font size", 20, 20, 10, GRAY)
  DrawText("Use KEY_RIGHT and KEY_LEFT to move text", 20, 40, 10, GRAY)
  DrawText("Use 1, 2, 3 to change texture filter", 20, 60, 10, GRAY)
  DrawText("Drop a new TTF font for dynamic loading", 20, 80, 10, DARKGRAY)

  DrawTextEx(font, msg, fontPosition, fontSize.cfloat, 0, BLACK)

  DrawRectangle(0, screenHeight - 80, screenWidth, 80, LIGHTGRAY)
  DrawText(FormatText("Font size: %02.02f", fontSize), 20, screenHeight - 50,
      10, DARKGRAY)
  DrawText(FormatText("Text size: [%02.02f, %02.02f]", textSize.x, textSize.y),
      20, screenHeight - 30, 10, DARKGRAY)
  DrawText("CURRENT TEXTURE FILTER:", 250, 400, 20, GRAY)

  if currentFontFilter == 0:
    DrawText("POINT", 570, 400, 20, BLACK)
  elif currentFontFilter == 1:
    DrawText("BILINEAR", 570, 400, 20, BLACK)
  elif currentFontFilter == 2:
    DrawText("TRILINEAR", 570, 400, 20, BLACK)

  EndDrawing()
UnloadFont(font)
CloseWindow()
