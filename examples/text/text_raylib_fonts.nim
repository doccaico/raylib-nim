import raylib

const
  MAX_FONTS = 8
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [text] example - raylib fonts")

var
  fonts = [
      LoadFont("resources/fonts/alagard.png"),
      LoadFont("resources/fonts/pixelplay.png"),
      LoadFont("resources/fonts/mecha.png"),
      LoadFont("resources/fonts/setback.png"),
      LoadFont("resources/fonts/romulus.png"),
      LoadFont("resources/fonts/pixantiqua.png"),
      LoadFont("resources/fonts/alpha_beta.png"),
      LoadFont("resources/fonts/jupiter_crash.png")]
  messages = [
      "ALAGARD FONT designed by Hewett Tsoi",
      "PIXELPLAY FONT designed by Aleksander Shevchuk",
      "MECHA FONT designed by Captain Falcon",
      "SETBACK FONT designed by Brian Kent (AEnigma)",
      "ROMULUS FONT designed by Hewett Tsoi",
      "PIXANTIQUA FONT designed by Gerhard Grossmann",
      "ALPHA_BETA FONT designed by Brian Kent (AEnigma)",
      "JUPITER_CRASH FONT designed by Brian Kent (AEnigma)"]
  spacings = [2.cfloat, 4, 8, 4, 3, 4, 4, 1]
  positions: array[MAX_FONTS, Vector2]
  colors = [MAROON, ORANGE, DARKGREEN, DARKBLUE, DARKPURPLE, LIME, GOLD, RED]

for i in 0..<MAX_FONTS:
  positions[i].x = screenWidth/2 - MeasureTextEx(fonts[i], messages[i],
      (fonts[i].baseSize*2).cfloat, spacings[i]).x/2
  positions[i].y = 60.0 + fonts[i].baseSize.cfloat + 45.0*i.cfloat
positions[3].y += 8
positions[4].y += 2
positions[7].y -= 8

SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("free fonts included with raylib", 250, 20, 20, DARKGRAY)
  DrawLine(220, 50, 590, 50, DARKGRAY)
  for i in 0..<MAX_FONTS:
    DrawTextEx(fonts[i], messages[i], positions[i], (fonts[
        i].baseSize*2).cfloat, spacings[i], colors[i])
  EndDrawing()

for i in 0..<MAX_FONTS:
  UnloadFont(fonts[i])
CloseWindow()
