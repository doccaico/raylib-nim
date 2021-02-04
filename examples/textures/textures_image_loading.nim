import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - image loading")

var
  image = LoadImage("resources/raylib_logo.png")
  texture = LoadTextureFromImage(image)

UnloadImage(image)

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTexture(texture, (screenWidth/2).cint - (texture.width/2).cint,
      (screenHeight/2).cint - (texture.height/2).cint, WHITE)
  DrawText("this IS a texture loaded from an image!", 300, 370, 10, GRAY)
  EndDrawing()
UnloadTexture(texture)
CloseWindow()
