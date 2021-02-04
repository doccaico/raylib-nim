import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - texture loading and drawing")

var texture = LoadTexture("resources/raylib_logo.png")

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTexture(texture,
      (screenWidth/2 - texture.width/2).cint,
      (screenHeight/2 - texture.height/2).cint,
      WHITE)
  DrawText("this IS a texture!", 360, 370, 10, GRAY)
  EndDrawing()
UnloadTexture(texture)
CloseWindow()
