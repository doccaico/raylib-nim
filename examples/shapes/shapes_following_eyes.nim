import raylib

proc atan2f(x: cfloat, y: cfloat): cfloat {.
  importc, header: "<math.h>".}
proc cosf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}
proc sinf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [shapes] example - following eyes")

var
  scleraLeftPosition = Vector2(x: GetScreenWidth()/2 - 100, y: GetScreenHeight()/2)
  scleraRightPosition =Vector2(x: GetScreenWidth()/2 + 100, y: GetScreenHeight()/2)
  scleraRadius = 80.cfloat
  irisLeftPosition = Vector2(x: GetScreenWidth()/2 - 100, y: GetScreenHeight()/2)
  irisRightPosition = Vector2(x: GetScreenWidth()/2 + 100, y: GetScreenHeight()/2)
  irisRadius = 24.cfloat
  angle = 0.0.cfloat
  dx = 0.0.cfloat
  dy = 0.0.cfloat
  dxx = 0.0.cfloat
  dyy = 0.0.cfloat

SetTargetFPS(60)

while not WindowShouldClose():

  irisLeftPosition = GetMousePosition()
  irisRightPosition = GetMousePosition()

  if not CheckCollisionPointCircle(irisLeftPosition, scleraLeftPosition, scleraRadius - 20):
    dx = irisLeftPosition.x - scleraLeftPosition.x
    dy = irisLeftPosition.y - scleraLeftPosition.y
    angle = atan2f(dy, dx)
    dxx = (scleraRadius - irisRadius)*cosf(angle)
    dyy = (scleraRadius - irisRadius)*sinf(angle)
    irisLeftPosition.x = scleraLeftPosition.x + dxx
    irisLeftPosition.y = scleraLeftPosition.y + dyy

  if not CheckCollisionPointCircle(irisRightPosition, scleraRightPosition, scleraRadius - 20):
    dx = irisRightPosition.x - scleraRightPosition.x
    dy = irisRightPosition.y - scleraRightPosition.y
    angle = atan2f(dy, dx)
    dxx = (scleraRadius - irisRadius)*cosf(angle)
    dyy = (scleraRadius - irisRadius)*sinf(angle)
    irisRightPosition.x = scleraRightPosition.x + dxx
    irisRightPosition.y = scleraRightPosition.y + dyy

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawCircleV(scleraLeftPosition, scleraRadius, LIGHTGRAY)
  DrawCircleV(irisLeftPosition, irisRadius, BROWN)
  DrawCircleV(irisLeftPosition, 10, BLACK)

  DrawCircleV(scleraRightPosition, scleraRadius, LIGHTGRAY)
  DrawCircleV(irisRightPosition, irisRadius, DARKGREEN)
  DrawCircleV(irisRightPosition, 10, BLACK)

  DrawFPS(10, 10)

  EndDrawing()
CloseWindow()
