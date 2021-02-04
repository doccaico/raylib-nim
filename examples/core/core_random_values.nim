import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  framesCounter = 0
  randValue = GetRandomValue(-8, 5)

InitWindow(screenWidth, screenHeight, "raylib [core] example - generate random values")
SetTargetFPS(60)

while not WindowShouldClose():
  inc framesCounter
  if (framesCounter/120).int mod 2 == 1:
    randValue = GetRandomValue(-8, 5)
    framesCounter = 0
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("Every 2 seconds a new random value is generated:", 130, 100, 20, MAROON)
  DrawText(FormatText("%i", randValue), 360, 180, 80, LIGHTGRAY)
  EndDrawing()
CloseWindow()
