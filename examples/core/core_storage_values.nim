import raylib

# I can compile it, but don't work save/load.
# It works on master branch

type
  StorageData = enum
    STORAGE_POSITION_SCORE = 0
    STORAGE_POSITION_HISCORE = 1

const
  screenWidth = 800
  screenHeight = 450

var
  score = 0.cint
  hiscore = 0.cint
  framesCounter = 0

InitWindow(screenWidth, screenHeight, "raylib [core] example - storage save/load values")
SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_R):
    score = GetRandomValue(1000, 2000)
    hiscore = GetRandomValue(2000, 4000)
  if IsKeyPressed(KEY_ENTER):
    SaveStorageValue(STORAGE_POSITION_SCORE.cuint, score)
    SaveStorageValue(STORAGE_POSITION_HISCORE.cuint, hiscore)
  elif IsKeyPressed(KEY_SPACE):
    score = LoadStorageValue(STORAGE_POSITION_SCORE.cuint)
    hiscore = LoadStorageValue(STORAGE_POSITION_HISCORE.cuint)
  inc framesCounter

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText(FormatText("SCORE: %i", score), 280, 130, 40, MAROON)
  DrawText(FormatText("HI-SCORE: %i", hiscore), 210, 200, 50, BLACK)
  DrawText(FormatText("frames: %i", framesCounter), 10, 10, 20, LIME)
  DrawText("Press R to generate random numbers", 220, 40, 20, LIGHTGRAY)
  DrawText("Press ENTER to SAVE values", 250, 310, 20, LIGHTGRAY)
  DrawText("Press SPACE to LOAD values", 252, 350, 20, LIGHTGRAY)
  EndDrawing()
CloseWindow()
