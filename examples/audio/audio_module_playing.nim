import raylib

type
  CircleWave = object
    position: Vector2
    radius: cfloat
    alpha: cfloat
    speed: cfloat
    color: Color

const
  MAX_CIRCLES = 64
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight,
    "raylib [audio] example - module playing (streaming)")

InitAudioDevice()

var
  colors = [ORANGE, RED, GOLD, LIME, BLUE, VIOLET, BROWN, LIGHTGRAY, PINK,
     YELLOW, GREEN, SKYBLUE, PURPLE, BEIGE]
  circles: array[MAX_CIRCLES, CircleWave]
  music = LoadMusicStream("resources/mini1111.xm")
  timePlayed = 0.0.cfloat
  pause = false

var i = MAX_CIRCLES - 1
while i >= 0:
  circles[i].alpha = 0.0
  circles[i].radius = GetRandomValue(10, 40).cfloat
  circles[i].position.x = GetRandomValue(
      circles[i].radius.cint, (screenWidth - circles[i].radius).cint).cfloat
  circles[i].position.y = GetRandomValue(
      circles[i].radius.cint, (screenHeight - circles[i].radius).cint).cfloat
  circles[i].speed = GetRandomValue(1, 100)/2000
  circles[i].color = colors[GetRandomValue(0, 13)]
  dec i

PlayMusicStream(music)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateMusicStream(music)

  if IsKeyPressed(KEY_SPACE):
    StopMusicStream(music)
    PlayMusicStream(music)
  if IsKeyPressed(KEY_P):
    pause = not pause
    if pause: PauseMusicStream(music)
    else: ResumeMusicStream(music)

  timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music)*(screenWidth - 40)

  i = MAX_CIRCLES - 1
  while i >= 0 and not pause:
    circles[i].alpha += circles[i].speed
    circles[i].radius += circles[i].speed*10.0
    if circles[i].alpha > 1.0:
      circles[i].speed *= -1
    if circles[i].alpha <= 0.0:
      circles[i].alpha = 0.0
      circles[i].radius = GetRandomValue(10, 40).cfloat
      circles[i].position.x = GetRandomValue(
          circles[i].radius.cint, (screenWidth - circles[i].radius).cint).cfloat
      circles[i].position.y = GetRandomValue(
          circles[i].radius.cint, (screenHeight - circles[i].radius).cint).cfloat
      circles[i].color = colors[GetRandomValue(0, 13)]
      circles[i].speed = GetRandomValue(1, 100)/2000
    dec i

  BeginDrawing()
  ClearBackground(RAYWHITE)

  i = MAX_CIRCLES - 1
  while i >= 0:
    DrawCircleV(circles[i].position, circles[i].radius,
        Fade(circles[i].color, circles[i].alpha))
    dec i

  DrawRectangle(20, screenHeight - 20 - 12, screenWidth - 40, 12, LIGHTGRAY)
  DrawRectangle(20, screenHeight - 20 - 12, timePlayed.cint, 12, MAROON)
  DrawRectangleLines(20, screenHeight - 20 - 12, screenWidth - 40, 12, GRAY)

  EndDrawing()

UnloadMusicStream(music)
CloseAudioDevice()
CloseWindow()
