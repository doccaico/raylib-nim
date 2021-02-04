import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [audio] example - music playing (streaming)")

InitAudioDevice()

var
  music = LoadMusicStream("resources/guitar_noodling.ogg")
  timePlayed = 0.0.cfloat
  pause = false

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

  timePlayed = GetMusicTimePlayed(music)/GetMusicTimeLength(music)*400

  if timePlayed > 400: StopMusicStream(music)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY)

  DrawRectangle(200, 200, 400, 12, LIGHTGRAY)
  DrawRectangle(200, 200, timePlayed.cint, 12, MAROON)
  DrawRectangleLines(200, 200, 400, 12, GRAY)

  DrawText("PRESS SPACE TO RESTART MUSIC", 215, 250, 20, LIGHTGRAY)
  DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 280, 20, LIGHTGRAY)

  EndDrawing()

UnloadMusicStream(music)
CloseAudioDevice()
CloseWindow()
