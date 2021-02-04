import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [textures] examples - texture source and destination rectangles")

var
  scarfy = LoadTexture("resources/scarfy.png")
  frameWidth = (scarfy.width/6).cint
  frameHeight = scarfy.height
  sourceRec = Rectangle(x: 0.0, y: 0.0,
      width: frameWidth.cfloat, height: frameHeight.cfloat)
  destRec = Rectangle(x: screenWidth/2, y: screenHeight/2,
      width: (frameWidth*2).cfloat, height: (frameHeight*2).cfloat)
  origin = Vector2(x: frameWidth.cfloat, y: frameHeight.cfloat)
  rotation = 0.cint

SetTargetFPS(60)

while not WindowShouldClose():

  inc rotation

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawTexturePro(scarfy, sourceRec, destRec, origin, rotation.cfloat, WHITE)
  DrawLine(destRec.x.cint, 0, destRec.x.cint, screenHeight, GRAY)
  DrawLine(0, destRec.y.cint, screenWidth, destRec.y.cint, GRAY)
  DrawText("(c) Scarfy sprite by Eiden Marsal",
      screenWidth - 200, screenHeight - 20, 10, GRAY)
  EndDrawing()
CloseWindow()
