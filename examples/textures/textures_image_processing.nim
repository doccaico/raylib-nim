import raylib

proc free(p: pointer) {.
  importc, header: "<stdlib.h>".}

const
  NUM_PROCESSES = 8
  screenWidth = 800
  screenHeight = 450

type
  ImageProcess = enum
    NONE = 0,
    COLOR_GRAYSCALE,
    COLOR_TINT,
    COLOR_INVERT,
    COLOR_CONTRAST,
    COLOR_BRIGHTNESS,
    FLIP_VERTICAL,
    FLIP_HORIZONTAL

InitWindow(screenWidth, screenHeight, "raylib [textures] example - image processing")

var processText = [
    "NO PROCESSING".cstring,
    "COLOR GRAYSCALE",
    "COLOR TINT",
    "COLOR INVERT",
    "COLOR CONTRAST",
    "COLOR BRIGHTNESS",
    "FLIP VERTICAL",
    "FLIP HORIZONTAL"]
var image = LoadImage("resources/parrots.png")
ImageFormat(image.addr, UNCOMPRESSED_R8G8B8A8)
var
  texture = LoadTextureFromImage(image)
  currentProcess = NONE
  textureReload = false
  selectRecs: array[NUM_PROCESSES, Rectangle]

for i in 0..<NUM_PROCESSES:
  selectRecs[i] = Rectangle(x: 40.0, y: (50 + 32*i).cfloat, width: 150.0, height: 30.0)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_DOWN):
    if currentProcess == FLIP_HORIZONTAL:
      currentProcess = NONE
    else:
      inc currentProcess
    textureReload = true
  elif IsKeyPressed(KEY_UP):
    if currentProcess == NONE:
      currentProcess = FLIP_HORIZONTAL
    else:
      dec currentProcess
    textureReload = true

  if textureReload:
    UnloadImage(image)
    image = LoadImage("resources/parrots.png")
    case currentProcess:
      of COLOR_GRAYSCALE: ImageColorGrayscale(image.addr)
      of COLOR_TINT: ImageColorTint(image.addr, GREEN)
      of COLOR_INVERT: ImageColorInvert(image.addr)
      of COLOR_CONTRAST: ImageColorContrast(image.addr, -40)
      of COLOR_BRIGHTNESS: ImageColorBrightness(image.addr, -80)
      of FLIP_VERTICAL: ImageFlipVertical(image.addr)
      of FLIP_HORIZONTAL: ImageFlipHorizontal(image.addr)
      else: discard

    var pixels = GetImageData(image)
    UpdateTexture(texture, pixels)
    free(pixels)
    textureReload = false

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("IMAGE PROCESSING:", 40, 30, 10, DARKGRAY)
  for i in 0..<NUM_PROCESSES:
    DrawRectangleRec(selectRecs[i], if i == currentProcess.ord: SKYBLUE else: LIGHTGRAY)
    DrawRectangleLines(selectRecs[i].x.cint, selectRecs[i].y.cint,
        selectRecs[i].width.cint, selectRecs[i].height.cint,
        if i == currentProcess.ord: BLUE else: GRAY)
    DrawText(processText[i],
        (selectRecs[i].x + selectRecs[i].width/2 - MeasureText(processText[i], 10)/2).cint,
        (selectRecs[i].y + 11).cint,
        10,
        if i == currentProcess.ord: DARKBLUE else: DARKGRAY)
  DrawTexture(texture, screenWidth - texture.width - 60,
      (screenHeight/2 - texture.height/2).cint, WHITE)
  DrawRectangleLines(screenWidth - texture.width - 60,
      (screenHeight/2 - texture.height/2).cint, texture.width, texture.height, BLACK)
  EndDrawing()

UnloadTexture(texture)
UnloadImage(image)
CloseWindow()
