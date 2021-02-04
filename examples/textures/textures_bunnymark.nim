import raylib

type
  Bunny = object
    position: Vector2
    speed: Vector2
    color: Color

const
  MAX_BUNNIES = 50000
  MAX_BATCH_ELEMENTS = 8192
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - bunnymark")

var
  texBunny = LoadTexture("resources/wabbit_alpha.png")
  bunnies = newSeq[Bunny](MAX_BUNNIES)
  bunniesCount = 0.cint

SetTargetFPS(60)

while not WindowShouldClose():

  if IsMouseButtonDown(MOUSE_LEFT_BUTTON):
    for i in 0..<100:
      if bunniesCount < MAX_BUNNIES:
        bunnies[bunniesCount].position = GetMousePosition()
        bunnies[bunniesCount].speed.x = cfloat(GetRandomValue(-250, 250)/60)
        bunnies[bunniesCount].speed.y = cfloat(GetRandomValue(-250, 250)/60)
        bunnies[bunniesCount].color = Color(
            r: GetRandomValue(50, 240).cuchar,
            g: GetRandomValue(80, 240).cuchar,
            b: GetRandomValue(100, 240).cuchar,
            a: 255.cuchar)
        inc bunniesCount

  for i in 0..<bunniesCount:
    bunnies[i].position.x += bunnies[i].speed.x
    bunnies[i].position.y += bunnies[i].speed.y

    if bunnies[i].position.x + texBunny.width/2 > GetScreenWidth().cfloat or
        bunnies[i].position.x + texBunny.width/2 < 0:
      bunnies[i].speed.x *= -1
    if bunnies[i].position.y + texBunny.height/2 > GetScreenHeight().cfloat or
        bunnies[i].position.y + texBunny.height/2 - 40 < 0:
      bunnies[i].speed.y *= -1

  BeginDrawing()
  ClearBackground(RAYWHITE)

  for i in 0..<bunniesCount:
    DrawTexture(texBunny, bunnies[i].position.x.cint,
        bunnies[i].position.y.cint, bunnies[i].color)

  DrawRectangle(0, 0, screenWidth, 40, BLACK)
  DrawText(FormatText("bunnies: %i", bunniesCount), 120, 10, 20, GREEN)
  DrawText(FormatText("batched draw calls: %i", 1 + (bunniesCount/MAX_BATCH_ELEMENTS).cint),
      320, 10, 20, MAROON)
  DrawFPS(10, 10)

  EndDrawing()
CloseWindow()
