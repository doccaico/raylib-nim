import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [audio] example - sound loading and playing")

InitAudioDevice()

var fxWav = LoadSound("resources/sound.wav")
var fxOgg = LoadSound("resources/tanatana.ogg")

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_SPACE): PlaySound(fxWav)
  if IsKeyPressed(KEY_ENTER): PlaySound(fxOgg)

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("Press SPACE to PLAY the WAV sound!", 200, 180, 20, LIGHTGRAY)
  DrawText("Press ENTER to PLAY the OGG sound!", 200, 220, 20, LIGHTGRAY)
  EndDrawing()

UnloadSound(fxWav)
UnloadSound(fxOgg)
CloseAudioDevice()
CloseWindow()
