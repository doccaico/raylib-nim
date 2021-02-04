import raylib

const
  screenWidth = 800
  screenHeight = 450
  msg = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHI\n" &
        "JKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmn\n" &
        "opqrstuvwxyz{|}~¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓ\n" &
        "ÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷\n" &
        "øùúûüýþÿ"

InitWindow(screenWidth, screenHeight, "raylib [text] example - font loading")

var
  fontBm = LoadFont("resources/pixantiqua.fnt")
  fontTtf = LoadFontEx("resources/pixantiqua.ttf", 32, nil, 250)
  useTtf = false

SetTargetFPS(60)

while not WindowShouldClose():

  if IsKeyDown(KEY_SPACE):
    useTtf = true
  else:
    useTtf = false

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("Hold SPACE to use TTF generated font", 20, 20, 20, LIGHTGRAY)

  if not useTtf:
    DrawTextEx(fontBm, msg, Vector2(x: 20.0, y: 100.0), fontBm.baseSize.cfloat, 2, MAROON)
    DrawText("Using BMFont (Angelcode) imported", 20, GetScreenHeight() - 30, 20, GRAY)
  else:
    DrawTextEx(fontTtf, msg, Vector2(x: 20.0, y: 100.0), fontTtf.baseSize.cfloat, 2, LIME)
    DrawText("Using TTF font generated", 20, GetScreenHeight() - 30, 20, GRAY)

  EndDrawing()
CloseWindow()
