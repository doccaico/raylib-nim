import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450
  msg = "Signed Distance Fields"

InitWindow(screenWidth, screenHeight, "raylib [text] example - SDF fonts")

var fontDefault: Font
fontDefault.baseSize = 16
fontDefault.charsCount = 95
fontDefault.chars = LoadFontData("resources/AnonymousPro-Bold.ttf", 16, nil, 95, FONT_DEFAULT)
var atlas = GenImageFontAtlas(fontDefault.chars, fontDefault.recs.addr, 95, 16, 4, 0)
fontDefault.texture = LoadTextureFromImage(atlas)
UnloadImage(atlas)

var fontSDF: Font
fontSDF.baseSize = 16
fontSDF.charsCount = 95
fontSDF.chars = LoadFontData("resources/AnonymousPro-Bold.ttf", 16, nil, 0, FONT_SDF);
atlas = GenImageFontAtlas(fontSDF.chars, fontSDF.recs.addr, 95, 16, 0, 1)
fontSDF.texture = LoadTextureFromImage(atlas)
UnloadImage(atlas)

var
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/sdf.fs", GLSL_VERSION))
  fontPosition = Vector2(x: 40, y: screenHeight/2 - 50)
  textSize = Vector2(x: 0.0, y: 0.0)
  fontSize = 16.0.cfloat
  currentFont = 0.cint

SetTextureFilter(fontSDF.texture, FILTER_BILINEAR)
SetTargetFPS(60)

while not WindowShouldClose():

  fontSize += GetMouseWheelMove().cfloat * 8.0

  if fontSize < 6:
    fontSize = 6

  if IsKeyDown(KEY_SPACE):
    currentFont = 1
  else:
    currentFont = 0

  if currentFont == 0:
    textSize = MeasureTextEx(fontDefault, msg, fontSize, 0)
  else:
    textSize = MeasureTextEx(fontSDF, msg, fontSize, 0)

  fontPosition.x = GetScreenWidth()/2 - textSize.x/2
  fontPosition.y = GetScreenHeight()/2 - textSize.y/2 + 80

  BeginDrawing()
  ClearBackground(RAYWHITE)

  if currentFont == 1:
    BeginShaderMode(shader)
    DrawTextEx(fontSDF, msg, fontPosition, fontSize, 0, BLACK)
    EndShaderMode()
    DrawTexture(fontSDF.texture, 10, 10, BLACK);
  else:
    DrawTextEx(fontDefault, msg, fontPosition, fontSize, 0, BLACK)
    DrawTexture(fontDefault.texture, 10, 10, BLACK)

  if currentFont == 1:
    DrawText("SDF!", 320, 20, 80, RED)
  else:
    DrawText("default font", 315, 40, 30, GRAY)

  DrawText("FONT SIZE: 16.0", GetScreenWidth() - 240, 20, 20, DARKGRAY)
  DrawText(FormatText("RENDER SIZE: %02.02f", fontSize), GetScreenWidth() - 240, 50, 20, DARKGRAY)
  DrawText("Use MOUSE WHEEL to SCALE TEXT!", GetScreenWidth() - 240, 90, 10, DARKGRAY)
  DrawText("HOLD SPACE to USE SDF FONT VERSION!", 340, GetScreenHeight() - 30, 20, MAROON)

  EndDrawing()

UnloadFont(fontDefault)
UnloadFont(fontSDF)
UnloadShader(shader)
CloseWindow()
