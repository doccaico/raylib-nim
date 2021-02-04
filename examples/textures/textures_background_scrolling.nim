import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - background scrolling")

var
  background = LoadTexture("resources/cyberpunk_street_background.png")
  midground = LoadTexture("resources/cyberpunk_street_midground.png")
  foreground = LoadTexture("resources/cyberpunk_street_foreground.png")
  scrollingBack = 0.0.cfloat
  scrollingMid = 0.0.cfloat
  scrollingFore = 0.0.cfloat

SetTargetFPS(60)

while not WindowShouldClose():
  scrollingBack -= 0.1
  scrollingMid -= 0.5
  scrollingFore -= 1.0

  if scrollingBack <= (-background.width*2).cfloat:
    scrollingBack = 0
  if scrollingMid <= (-midground.width*2).cfloat:
    scrollingMid = 0
  if scrollingFore <= (-foreground.width*2).cfloat:
    scrollingFore = 0

  BeginDrawing()
  ClearBackground(GetColor(0x052c46ff))

  DrawTextureEx(background, Vector2(x: scrollingBack, y: 20), 0.0, 2.0, WHITE)
  DrawTextureEx(background, Vector2(x: background.width.cfloat*2 + scrollingBack, y: 20),
      0.0, 2.0, WHITE)

  DrawTextureEx(midground, Vector2(x: scrollingMid, y: 20), 0.0, 2.0, WHITE)
  DrawTextureEx(midground, Vector2(x: midground.width.cfloat*2 + scrollingMid, y: 20),
      0.0, 2.0, WHITE)

  DrawTextureEx(foreground, Vector2(x: scrollingFore, y: 70), 0.0, 2.0, WHITE)
  DrawTextureEx(foreground, Vector2(x: foreground.width.cfloat*2 + scrollingFore, y: 70),
      0.0, 2.0, WHITE)

  DrawText("BACKGROUND SCROLLING & PARALLAX", 10, 10, 20, RED)
  DrawText("(c) Cyberpunk Street Environment by Luis Zuno (@ansimuz)",
      screenWidth - 330, screenHeight - 20, 10, RAYWHITE)
  EndDrawing()
CloseWindow()
