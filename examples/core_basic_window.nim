import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window")
SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY)
  EndDrawing()
CloseWindow()
