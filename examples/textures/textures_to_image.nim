import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - texture to image")

var image = LoadImage("resources/raylib_logo.png")
var  texture = LoadTextureFromImage(image)
UnloadImage(image)
image = GetTextureData(texture)
UnloadTexture(texture)
texture = LoadTextureFromImage(image)
UnloadImage(image)

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTexture(texture, (screenWidth/2 - texture.width/2).cint,
      (screenHeight/2 - texture.height/2).cint, WHITE)
  DrawText("this IS a texture loaded from an image!", 300, 370, 10, GRAY)
  EndDrawing()

UnloadTexture(texture)
CloseWindow()
