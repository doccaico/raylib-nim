import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [texture] example - image text drawing")

var parrots = LoadImage("resources/parrots.png")
var font = LoadFontEx("resources/KAISG.ttf", 64, nil, 0)
ImageDrawTextEx(parrots.addr, Vector2(x: 20.0, y: 20.0), font,
    "[Parrots font drawing]", font.baseSize.cfloat, 0.0, RED)
var texture = LoadTextureFromImage(parrots)
UnloadImage(parrots)
var
  position = Vector2(
      x: screenWidth/2 - texture.width/2,
      y: screenHeight/2 - texture.height/2 - 20.0)
  showFont = false

SetTargetFPS(60)

while not WindowShouldClose():
  showFont = if IsKeyDown(KEY_SPACE): true else: false

  BeginDrawing()
  ClearBackground(RAYWHITE)
  if not showFont:
    DrawTextureV(texture, position, WHITE)
    DrawTextEx(font, "[Parrots font drawing]",
        Vector2(x: position.x + 20, y: position.y + 20 + 280),
        font.baseSize.cfloat, 0.0, WHITE)
  else:
    DrawTexture(font.texture,
        (screenWidth/2 - font.texture.width/2).cint, 50, BLACK)
  DrawText("PRESS SPACE to SEE USED SPRITEFONT ", 290, 420, 10, DARKGRAY)
  EndDrawing()

UnloadTexture(texture)
UnloadFont(font)
CloseWindow()
