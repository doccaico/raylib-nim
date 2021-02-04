import raylib
import raylib/raymath

{.passL: "-lm".}

proc fabs(x: cdouble): cdouble {.
  importc, header: "<math.h>".}
proc cos(x: cdouble): cdouble {.
  importc, header: "<math.h>".}
proc sin(x: cdouble): cdouble {.
  importc, header: "<math.h>".}

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

type
  Spot = object
    pos: Vector2
    vel: Vector2
    inner: cfloat
    radius: cfloat
    posLoc: cuint
    innerLoc: cuint
    radiusLoc: cuint
  Star = object
    pos: Vector2
    vel: Vector2

proc UpdateStar(s: ptr Star)
proc ResetStar(s: ptr Star)

const
  MAXSPOT = 3
  numStars = 400
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib - shader spotlight")

HideCursor()

var texRay = LoadTexture("resources/raysan.png")
var stars: array[numStars, Star]

for n in 0..<numStars:
  ResetStar(cast[ptr Star](stars[n].addr))

for m in 0..<(screenWidth/2).int:
  for n in 0..<numStars:
    UpdateStar(cast[ptr Star](stars[n].addr))

var
  frameCounter = 0.cint
  spotShader = LoadShader(nil, FormatText("resources/shaders/glsl%i/spotlight.fs",
      GLSL_VERSION))
  spots: array[MAXSPOT, Spot]

for i in 0..<MAXSPOT:
  let
    posName = "spots[" & $i & "].pos\0"
    innerName = "spots[" & $i & "].inner\0"
    radiusName = "spots[" & $i & "].radius\0"
  spots[i].posLoc = GetShaderLocation(spotShader, posName).cuint
  spots[i].innerLoc = GetShaderLocation(spotShader, innerName).cuint
  spots[i].radiusLoc = GetShaderLocation(spotShader, radiusName).cuint

var wLoc = GetShaderLocation(spotShader, "screenWidth")
var sw = GetScreenWidth().cfloat
SetShaderValue(spotShader, wLoc, sw.addr, UNIFORM_FLOAT);

for i in 0..<MAXSPOT:
  spots[i].pos.x = GetRandomValue(64, screenWidth - 64).cfloat
  spots[i].pos.y = GetRandomValue(64, screenHeight - 64).cfloat
  spots[i].vel = Vector2(x: 0, y: 0)

  while (fabs(spots[i].vel.x) + fabs(spots[i].vel.y)) < 2:
    spots[i].vel.x = GetRandomValue(-40, 40)/10
    spots[i].vel.y = GetRandomValue(-40, 40)/10

  spots[i].inner = 28 * (i + 1).cfloat
  spots[i].radius = 48 * (i + 1).cfloat

  SetShaderValue(spotShader, spots[i].posLoc.cint,
      spots[i].pos.x.addr, UNIFORM_VEC2)
  SetShaderValue(spotShader, spots[i].innerLoc.cint,
      spots[i].inner.addr, UNIFORM_FLOAT)
  SetShaderValue(spotShader, spots[i].radiusLoc.cint,
      spots[i].radius.addr, UNIFORM_FLOAT)

SetTargetFPS(60)

while not WindowShouldClose():
  inc frameCounter

  for n in 0..<numStars:
    UpdateStar(stars[n].addr)

  for i in 0..<MAXSPOT:
    if i == 0:
      var mp = GetMousePosition()
      spots[i].pos.x = mp.x
      spots[i].pos.y = screenHeight - mp.y
    else:
      spots[i].pos.x += spots[i].vel.x
      spots[i].pos.y += spots[i].vel.y
      if spots[i].pos.x < 64: spots[i].vel.x = -spots[i].vel.x
      if spots[i].pos.x > screenWidth - 64: spots[i].vel.x = -spots[i].vel.x
      if spots[i].pos.y < 64: spots[i].vel.y = -spots[i].vel.y
      if spots[i].pos.y > screenHeight - 64: spots[i].vel.y = -spots[i].vel.y
    SetShaderValue(spotShader, spots[i].posLoc.cint,
        spots[i].pos.x.addr, UNIFORM_VEC2)

  BeginDrawing()
  ClearBackground(DARKBLUE)

  for n in 0..<numStars:
    DrawRectangle(stars[n].pos.x.cint, stars[n].pos.y.cint, 2, 2, WHITE)

  for i in 0..<16:
    let x = ((screenWidth/2) +
        cos((frameCounter + i*8).cfloat/51.45)*(screenWidth.cfloat/2.2) - 32).cint
    let y = ((screenHeight/2) +
        sin((frameCounter + i*8).cfloat/17.87)*(screenHeight.cfloat/4.2)).cint
    DrawTexture(texRay, x, y, WHITE)

  BeginShaderMode(spotShader)
  DrawRectangle(0, 0, screenWidth,screenHeight,WHITE)
  EndShaderMode()

  DrawFPS(10, 10)

  DrawText("Move the mouse!", 10, 30, 20, GREEN)
  DrawText("Pitch Black", (screenWidth * 0.2).cint, (screenHeight / 2).cint, 20, GREEN)
  DrawText("Dark", (screenWidth * 0.66).cint, (screenHeight / 2).cint, 20, GREEN)
  EndDrawing()

UnloadTexture(texRay)
CloseWindow()

proc UpdateStar(s: ptr Star) =
  s.pos = Vector2Add(s.pos, s.vel)
  if s.pos.x < 0.0 or s.pos.x > GetScreenWidth().cfloat or s.pos.y < 0.0 or
        s.pos.y > GetScreenHeight().cfloat:
    ResetStar(s)

proc ResetStar(s: ptr Star) =
  s.pos = Vector2(x: GetScreenWidth()/2, y: GetScreenHeight()/2)
  while true:
    s.vel.x = GetRandomValue(-1000, 1000)/100
    s.vel.y = GetRandomValue(-1000, 1000)/100
    if not ((fabs(s.vel.x) + fabs(s.vel.y)) > 1):
      break
  s.pos = Vector2Add(s.pos, Vector2MultiplyV(s.vel, Vector2(x: 8.0, y: 8.0)))
