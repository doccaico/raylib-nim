import raylib

const
  MAX_COLORS_COUNT = 21
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - colors palette")

var
  colors = [
      DARKGRAY, MAROON, ORANGE, DARKGREEN, DARKBLUE, DARKPURPLE, DARKBROWN,
      GRAY, RED, GOLD, LIME, BLUE, VIOLET, BROWN, LIGHTGRAY, PINK, YELLOW,
      GREEN, SKYBLUE, PURPLE, BEIGE]
  colorNames = [
      "DARKGRAY", "MAROON", "ORANGE", "DARKGREEN", "DARKBLUE", "DARKPURPLE",
      "DARKBROWN", "GRAY", "RED", "GOLD", "LIME", "BLUE", "VIOLET", "BROWN",
      "LIGHTGRAY", "PINK", "YELLOW", "GREEN", "SKYBLUE", "PURPLE", "BEIGE"]
  colorsRecs: array[MAX_COLORS_COUNT, Rectangle ]
  colorState: array[MAX_COLORS_COUNT, bool]
  mousePoint: Vector2

for i in 0..<MAX_COLORS_COUNT:
  colorsRecs[i].x = (20 + 100*(i mod 7) + 10*(i mod 7)).cfloat
  colorsRecs[i].y = (80 + 100*(i/7).cint + 10*(i/7).cint).cfloat
  colorsRecs[i].width = 100.0
  colorsRecs[i].height = 100.0

SetTargetFPS(60)

while not WindowShouldClose():
  mousePoint = GetMousePosition()

  for i in 0..<MAX_COLORS_COUNT:
    if CheckCollisionPointRec(mousePoint, colorsRecs[i]):
      colorState[i] = true
    else:
      colorState[i] = false

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawText("raylib colors palette", 28, 42, 20, BLACK)
  DrawText("press SPACE to see all colors",
      GetScreenWidth() - 180, GetScreenHeight() - 40, 10, GRAY)

  for i in 0..<MAX_COLORS_COUNT:
    DrawRectangleRec(colorsRecs[i], Fade(colors[i], if colorState[i]: 0.6 else: 1.0))

    if IsKeyDown(KEY_SPACE) or colorState[i]:
      DrawRectangle(
          colorsRecs[i].x.cint, (colorsRecs[i].y + colorsRecs[i].height - 26).cint,
          colorsRecs[i].width.cint, 20, BLACK)
      DrawRectangleLinesEx(colorsRecs[i], 6, Fade(BLACK, 0.3))
      DrawText(colorNames[i],
          cint(colorsRecs[i].x + colorsRecs[i].width -
              MeasureText(colorNames[i], 10).cfloat - 12.0),
          cint(colorsRecs[i].y + colorsRecs[i].height - 20.0),
          10,
          colors[i])

  EndDrawing()
CloseWindow()
