
import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - image drawing")

var
  cat = LoadImage("resources/cat.png")
  parrots = LoadImage("resources/parrots.png")
  font = LoadFont("resources/custom_jupiter_crash.png")

ImageCrop(cat.addr, Rectangle(x: 100, y: 10, width: 280, height: 380))
ImageFlipHorizontal(cat.addr)
ImageResize(cat.addr, 150, 200)

ImageDraw(parrots.addr, cat,
    Rectangle(x: 0, y: 0, width: cat.width.cfloat, height: cat.height.cfloat),
    Rectangle(x: 30, y: 40, width: cat.width.cfloat*1.5, height: cat.height.cfloat*1.5),
    WHITE)
ImageCrop(parrots.addr,
    Rectangle(x: 0, y: 50, width: parrots.width.cfloat, height: parrots.height.cfloat - 100.0))

ImageDrawPixel(parrots.addr, 10, 10, RAYWHITE)
ImageDrawCircle(parrots.addr, 10, 10, 5, RAYWHITE)
ImageDrawRectangle(parrots.addr, 5, 20, 10, 10, RAYWHITE)

UnloadImage(cat)

ImageDrawTextEx(parrots.addr, Vector2(x: 300, y: 230), font, "PARROTS & CAT",
    font.baseSize.cfloat, -2, WHITE)
UnloadFont(font)

var texture = LoadTextureFromImage(parrots)
UnloadImage(parrots)

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTexture(texture, (screenWidth/2).cint - (texture.width/2).cint,
      (screenHeight/2).cint - (texture.height/2).cint - 40, WHITE)
  DrawRectangleLines((screenWidth/2).cint - (texture.width/2).cint,
      (screenHeight/2).cint - (texture.height/2).cint - 40,
      texture.width, texture.height, DARKGRAY)

  DrawText("We are drawing only one texture from various images composed!",
      240, 350, 10, DARKGRAY)
  DrawText("Source images have been cropped, scaled, flipped and copied one over the other.",
      190, 370, 10, DARKGRAY)
  EndDrawing()
CloseWindow()
