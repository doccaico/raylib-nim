import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - raylib logo using shapes")

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawRectangle((screenWidth/2 - 128).cint, (screenHeight/2 - 128).cint,
      256, 256, BLACK)
  DrawRectangle((screenWidth/2 - 112).cint, (screenHeight/2 - 112).cint,
      224, 224, RAYWHITE)
  DrawText("raylib", (screenWidth/2 - 44).cint, (screenHeight/2 + 48).cint,
      50, BLACK)
  DrawText("this is NOT a texture!", 350, 370, 10, GRAY)
  EndDrawing()
CloseWindow()
