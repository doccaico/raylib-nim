import raylib

const
  NUM_FRAMES = 8
  NUM_LINES = 6
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - sprite explosion")

InitAudioDevice()

var
  fxBoom = LoadSound("resources/boom.wav")
  explosion = LoadTexture("resources/explosion.png")
  frameWidth = (explosion.width/NUM_FRAMES).cint
  frameHeight = (explosion.height/NUM_LINES).cint
  currentFrame = 0.cint
  currentLine = 0.cint
  frameRec = Rectangle(x: 0.0, y: 0.0,
      width: frameWidth.cfloat, height: frameHeight.cfloat)
  position = Vector2(x: 0.0, y: 0.0)
  active = false
  framesCounter = 0

SetTargetFPS(120)

while not WindowShouldClose():

  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON) and not active:
    position = GetMousePosition()
    active = true
    position.x -= frameWidth/2
    position.y -= frameHeight/2
    PlaySound(fxBoom)

  if active:
    inc framesCounter
    if framesCounter > 2:
      inc currentFrame
      if currentFrame >= NUM_FRAMES:
        currentFrame = 0
        inc currentLine
        if currentLine >= NUM_LINES:
          currentLine = 0
          active = false
      framesCounter = 0
  frameRec.x = (frameWidth*currentFrame).cfloat
  frameRec.y = (frameHeight*currentLine).cfloat

  BeginDrawing()
  ClearBackground(RAYWHITE)
  if active:
    DrawTextureRec(explosion, frameRec, position, WHITE)
  EndDrawing()

UnloadTexture(explosion)
UnloadSound(fxBoom)
CloseAudioDevice()
CloseWindow()
