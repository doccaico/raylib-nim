import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - collision area")

var
  boxA = Rectangle(x: 10, y: GetScreenHeight()/2 - 50, width: 200, height: 100)
  boxASpeedX = 4.cint
  boxB = Rectangle(x: GetScreenWidth()/2 - 30, y: GetScreenHeight()/2 - 30,
      width: 60, height: 60)
  boxCollision: Rectangle
  screenUpperLimit = 40.cint
  pause = false
  collision = false

SetTargetFPS(60)

while not WindowShouldClose():

  if not pause:
    boxA.x += boxASpeedX.cfloat

  if (boxA.x + boxA.width) >= GetScreenWidth().cfloat or boxA.x <= 0.cfloat:
    boxASpeedX *= -1

  boxB.x = GetMouseX().cfloat - boxB.width/2
  boxB.y = GetMouseY().cfloat - boxB.height/2

  if (boxB.x + boxB.width) >= GetScreenWidth().cfloat:
    boxB.x = GetScreenWidth().cfloat - boxB.width
  elif boxB.x <= 0:
    boxB.x = 0

  if (boxB.y + boxB.height) >= GetScreenHeight().cfloat:
    boxB.y = GetScreenHeight().cfloat - boxB.height
  elif boxB.y <= screenUpperLimit.cfloat:
    boxB.y = screenUpperLimit.cfloat

  collision = CheckCollisionRecs(boxA, boxB)

  if collision:
    boxCollision = GetCollisionRec(boxA, boxB)

  if IsKeyPressed(KEY_SPACE):
    pause = not pause

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawRectangle(0, 0, screenWidth, screenUpperLimit, if collision: RED else: BLACK)

  DrawRectangleRec(boxA, GOLD)
  DrawRectangleRec(boxB, BLUE)

  if collision:
    DrawRectangleRec(boxCollision, LIME)
    DrawText(
        "COLLISION!",
        (GetScreenWidth()/2 - MeasureText("COLLISION!", 20)/2).cint,
        (screenUpperLimit/2).cint - 10, 20,
        BLACK)
    DrawText(
        FormatText("Collision Area: %i", boxCollision.width.cint*boxCollision.height.cint),
        (GetScreenWidth()/2).cint - 100,
        screenUpperLimit + 10, 20,
        BLACK)

  DrawFPS(10, 10)
  EndDrawing()
CloseWindow()
