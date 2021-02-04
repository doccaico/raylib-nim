import raylib

const
  NUM_TEXTURES = 7
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - procedural images generation")

var
  verticalGradient = GenImageGradientV(screenWidth, screenHeight, RED, BLUE)
  horizontalGradient = GenImageGradientH(screenWidth, screenHeight, RED, BLUE)
  radialGradient = GenImageGradientRadial(screenWidth, screenHeight, 0.0, WHITE, BLACK)
  checked = GenImageChecked(screenWidth, screenHeight, 32, 32, RED, BLUE)
  whiteNoise = GenImageWhiteNoise(screenWidth, screenHeight, 0.5)
  perlinNoise = GenImagePerlinNoise(screenWidth, screenHeight, 50, 50, 4.0)
  cellular = GenImageCellular(screenWidth, screenHeight, 32)
  textures = [
      LoadTextureFromImage(verticalGradient),
      LoadTextureFromImage(horizontalGradient),
      LoadTextureFromImage(radialGradient),
      LoadTextureFromImage(checked),
      LoadTextureFromImage(whiteNoise),
      LoadTextureFromImage(perlinNoise),
      LoadTextureFromImage(cellular)]
  currentTexture = 0.cint

UnloadImage(verticalGradient)
UnloadImage(horizontalGradient)
UnloadImage(radialGradient)
UnloadImage(checked)
UnloadImage(whiteNoise)
UnloadImage(perlinNoise)
UnloadImage(cellular)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON) or IsKeyPressed(KEY_RIGHT):
    currentTexture = (currentTexture + 1) mod NUM_TEXTURES

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTexture(textures[currentTexture], 0, 0, WHITE)
  DrawRectangle(30, 400, 325, 30, Fade(SKYBLUE, 0.5))
  DrawRectangleLines(30, 400, 325, 30, Fade(WHITE, 0.5))
  DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL TEXTURES", 40, 410, 10, WHITE)
  case currentTexture:
    of 0: DrawText("VERTICAL GRADIENT", 560, 10, 20, RAYWHITE)
    of 1: DrawText("HORIZONTAL GRADIENT", 540, 10, 20, RAYWHITE)
    of 2: DrawText("RADIAL GRADIENT", 580, 10, 20, LIGHTGRAY)
    of 3: DrawText("CHECKED", 680, 10, 20, RAYWHITE)
    of 4: DrawText("WHITE NOISE", 640, 10, 20, RED)
    of 5: DrawText("PERLIN NOISE", 630, 10, 20, RAYWHITE)
    of 6: DrawText("CELLULAR", 670, 10, 20, RAYWHITE)
    else: discard
  EndDrawing()

for i in 0..<NUM_TEXTURES:
  UnloadTexture(textures[i])
CloseWindow()
