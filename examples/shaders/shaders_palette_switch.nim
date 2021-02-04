import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  MAX_PALETTES = 3 
  COLORS_PER_PALETTE = 8
  VALUES_PER_COLOR = 3
  screenWidth = 800
  screenHeight = 450

var palettes = [
    # 3-BIT RGB
    [0.cint, 0, 0,
     255, 0, 0,
     0, 255, 0,
     0, 0, 255,
     0, 255, 255,
     255, 0, 255,
     255, 255, 0,
     255, 255, 255,],
    # AMMO-8 (GameBoy-like)
    [4.cint, 12, 6,
     17, 35, 24,
     30, 58, 41,
     48, 93, 66,
     77, 128, 97,
     137, 162, 87,
     190, 220, 127,
     238, 255, 204,],
    # RKBV (2-strip film)
    [21.cint, 25, 26,
     138, 76, 88,
     217, 98, 117,
     230, 184, 193,
     69, 107, 115,
     75, 151, 166,
     165, 189, 194,
     255, 245, 247,]]

const paletteText = [
    "3-BIT RGB".cstring,
    "AMMO-8 (GameBoy-like)",
    "RKBV (2-strip film)",]

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - color palette switch")

var
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/palette_switch.fs",
      GLSL_VERSION))
  paletteLoc = GetShaderLocation(shader, "palette")
  currentPalette = 0.cint
  lineHeight = (screenHeight/COLORS_PER_PALETTE).cint

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_RIGHT): inc currentPalette
  elif IsKeyPressed(KEY_LEFT): dec currentPalette

  if currentPalette >= MAX_PALETTES: currentPalette = 0
  elif currentPalette < 0: currentPalette = MAX_PALETTES - 1

  SetShaderValueV(shader, paletteLoc, cast[pointer](palettes[currentPalette].addr),
      UNIFORM_IVEC3, COLORS_PER_PALETTE)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginShaderMode(shader)
  for i in 0..<COLORS_PER_PALETTE:
    DrawRectangle(0, (lineHeight*i).cint, GetScreenWidth(), lineHeight,
        Color(r: i.cuchar, g: i.cuchar, b: i.cuchar, a: 255.cuchar))
  EndShaderMode()

  DrawText("< >", 10, 10, 30, DARKBLUE)
  DrawText("CURRENT PALETTE:", 60, 15, 20, RAYWHITE)
  DrawText(paletteText[currentPalette], 300, 15, 20, RED)

  DrawFPS(700, 15)
  EndDrawing()

UnloadShader(shader)
CloseWindow()
