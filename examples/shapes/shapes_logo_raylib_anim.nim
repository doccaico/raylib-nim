import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - raylib logo animation")

var
  logoPositionX = (screenWidth/2 - 128).cint
  logoPositionY = (screenHeight/2 - 128).cint
  framesCounter = 0.cint
  lettersCount = 0.cint
  topSideRecWidth = 16.cint
  leftSideRecHeight = 16.cint
  bottomSideRecWidth = 16.cint
  rightSideRecHeight = 16.cint
  state = 0.cint
  alpha = 1.0.cfloat

SetTargetFPS(60)

while not WindowShouldClose():

  if state == 0:
    inc framesCounter
    if framesCounter == 120:
      state = 1
      framesCounter = 0
  elif state == 1:
    topSideRecWidth += 4
    leftSideRecHeight += 4
    if topSideRecWidth == 256:
      state = 2
  elif state == 2:
    bottomSideRecWidth += 4
    rightSideRecHeight += 4
    if bottomSideRecWidth == 256:
      state = 3
  elif state == 3:
    inc framesCounter
    if (framesCounter/12).cint != 0:
      inc lettersCount
      framesCounter = 0
    if lettersCount >= 10:
      alpha -= 0.02
      if alpha <= 0.0:
        alpha = 0.0
        state = 4
  elif state == 4:
    if IsKeyPressed(KEY_R):
      framesCounter = 0
      lettersCount = 0
      topSideRecWidth = 16
      leftSideRecHeight = 16
      bottomSideRecWidth = 16
      rightSideRecHeight = 16
      alpha = 1.0
      state = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  if state == 0:
    if (framesCounter/15).cint mod 2 != 0:
      DrawRectangle(logoPositionX, logoPositionY, 16, 16, BLACK)
  elif state == 1:
    DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
    DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)
  elif state == 2:
    DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, BLACK)
    DrawRectangle(logoPositionX, logoPositionY, 16, leftSideRecHeight, BLACK)
    DrawRectangle(logoPositionX + 240, logoPositionY, 16, rightSideRecHeight, BLACK)
    DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16, BLACK)
  elif state == 3:
    DrawRectangle(logoPositionX, logoPositionY, topSideRecWidth, 16, Fade(BLACK, alpha))
    DrawRectangle(logoPositionX, logoPositionY + 16, 16, leftSideRecHeight - 32,
        Fade(BLACK, alpha))
    DrawRectangle(logoPositionX + 240, logoPositionY + 16, 16, rightSideRecHeight - 32,
        Fade(BLACK, alpha))
    DrawRectangle(logoPositionX, logoPositionY + 240, bottomSideRecWidth, 16,
        Fade(BLACK, alpha))
    DrawRectangle((screenWidth/2 - 112).cint, (screenHeight/2 - 112).cint, 224, 224,
        Fade(RAYWHITE, alpha))
    DrawText(TextSubtext("raylib", 0, lettersCount), (screenWidth/2 - 44).cint,
        (screenHeight/2 + 48).cint, 50, Fade(BLACK, alpha))
  elif state == 4:
    DrawText("[R] REPLAY", 340, 200, 20, GRAY)

  EndDrawing()
CloseWindow()
