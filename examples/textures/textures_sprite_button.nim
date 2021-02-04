import raylib

const
  NUM_FRAMES = 3
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - sprite button")

InitAudioDevice()

var
    fxButton = LoadSound("resources/buttonfx.wav")
    button = LoadTexture("resources/button.png")
    frameHeight = (button.height/NUM_FRAMES).cint
    sourceRec = Rectangle(x: 0.cfloat, y: 0.cfloat,
        width: button.width.cfloat, height: frameHeight.cfloat)
    btnBounds = Rectangle(x: (screenWidth/2 - button.width/2).cfloat,
        y: screenHeight/2 - button.height/NUM_FRAMES/2, width: button.width.cfloat,
        height: frameHeight.float)
    btnState = 0.cint
    btnAction = false
    mousePoint = Vector2(x: 0.0, y: 0.0)

SetTargetFPS(60)

while not WindowShouldClose():

  mousePoint = GetMousePosition()
  btnAction = false

  if CheckCollisionPointRec(mousePoint, btnBounds):
    if IsMouseButtonDown(MOUSE_LEFT_BUTTON):
      btnState = 2
    else:
      btnState = 1

    if IsMouseButtonReleased(MOUSE_LEFT_BUTTON):
      btnAction = true
    else:
      btnState = 0

  if btnAction:
    PlaySound(fxButton)

  sourceRec.y = (btnState*frameHeight).cfloat

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTextureRec(button, sourceRec, Vector2(x: btnBounds.x, y: btnBounds.y), WHITE)
  EndDrawing()

UnloadTexture(button)
UnloadSound(fxButton)
CloseAudioDevice()
CloseWindow()
