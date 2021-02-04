import raylib

const
  screenWidth = 800
  screenHeight = 450
  msg1 = "THIS IS A custom SPRITE FONT..."
  msg2 = "...and this is ANOTHER CUSTOM font..."
  msg3 = "...and a THIRD one! GREAT! :D"

InitWindow(screenWidth, screenHeight, "raylib [text] example - sprite font loading")

var
  font1 = LoadFont("resources/custom_mecha.png")
  font2 = LoadFont("resources/custom_alagard.png")
  font3 = LoadFont("resources/custom_jupiter_crash.png")
  fontPosition1 =
      Vector2(
          x: screenWidth/2 - MeasureTextEx(font1, msg1, font1.baseSize.cfloat, -3).x/2,
          y: screenHeight/2 - font1.baseSize/2 - 80)
  fontPosition2 =
      Vector2(
          x: screenWidth/2 - MeasureTextEx(font2, msg2, font2.baseSize.cfloat, -2).x/2,
          y: screenHeight/2 - font2.baseSize/2 - 10)
  fontPosition3 =
      Vector2(
          x: screenWidth/2 - MeasureTextEx(font3, msg3, font3.baseSize.cfloat, 2).x/2,
          y: screenHeight/2 - font3.baseSize/2 + 50)

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTextEx(font1, msg1, fontPosition1, font1.baseSize.cfloat, -3, WHITE)
  DrawTextEx(font2, msg2, fontPosition2, font2.baseSize.cfloat, -2, WHITE)
  DrawTextEx(font3, msg3, fontPosition3, font3.baseSize.cfloat, 2, WHITE)
  EndDrawing()
UnloadFont(font1)
UnloadFont(font2)
UnloadFont(font3)
CloseWindow()
