import raylib

{.passL: "-lm".}

const
  MAX_BUILDINGS = 100
  screenWidth = 800
  screenHeight = 450

var
  player = Rectangle(x: 400.0, y: 280.0, width: 40.0, height: 40.0)
  buildings: array[MAX_BUILDINGS, Rectangle]
  buildColors: array[MAX_BUILDINGS, Color]
  spacing = 0.cint

for i in 0..<MAX_BUILDINGS:
  buildings[i].width = GetRandomValue(50, 200).cfloat
  buildings[i].height = GetRandomValue(100, 800).cfloat
  buildings[i].y = (screenHeight - 130 - buildings[i].height).cfloat
  buildings[i].x = (-6000 + spacing).cfloat
  spacing += buildings[i].width.cint
  buildColors[i] = Color(
      r: GetRandomValue(200, 240).cuchar,
      g: GetRandomValue(200, 240).cuchar,
      b: GetRandomValue(200, 250).cuchar,
      a: 255.cuchar)

var camera = Camera2D(
      offset: Vector2(x: player.x + 20, y: player.y + 20),
      target: Vector2(x: screenWidth/2, y: screenHeight/2),
      rotation: 0.0,
      zoom: 1.0)

InitWindow(screenWidth, screenHeight, "raylib [core] example - 2d camera")
SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyDown(KEY_RIGHT):
    player.x += 2
  elif IsKeyDown(KEY_LEFT):
    player.x -= 2

  camera.target = Vector2(x: player.x + 20, y: player.y + 20)

  if IsKeyDown(KEY_A):
    camera.rotation -= 1.0
  elif IsKeyDown(KEY_S):
    camera.rotation += 1.0

  if camera.rotation > 40:
    camera.rotation = 40
  elif camera.rotation < -40:
    camera.rotation = -40

  camera.zoom += (GetMouseWheelMove().cfloat * 0.05)

  if camera.zoom > 3.0:
    camera.zoom = 3.0
  elif camera.zoom < -0.1:
    camera.zoom = -0.1

  if IsKeyPressed(KEY_R):
    camera.zoom = 1.0
    camera.rotation = 0.0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode2D(camera)
  DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY)
  for i in 0..<MAX_BUILDINGS:
    DrawRectangleRec(buildings[i], buildColors[i])

  DrawRectangleRec(player, RED)
  DrawLine(camera.target.x.cint, -screenHeight * 10,
      camera.target.x.cint, screenHeight * 10, GREEN)
  DrawLine(-screenWidth * 10, camera.target.y.cint,
      screenWidth * 10, camera.target.y.cint, GREEN)
  EndMode2D()

  DrawText("SCREEN AREA", 640, 10, 20, RED)

  DrawRectangle(0, 0, screenWidth, 5, RED)
  DrawRectangle(0, 5, 5, screenHeight - 10, RED)
  DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED)
  DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED)

  DrawRectangle(10, 10, 250, 113, Fade(SKYBLUE, 0.5))
  DrawRectangleLines(10, 10, 250, 113, BLUE)

  DrawText("Free 2d camera controls:", 20, 20, 10, BLACK)
  DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY)
  DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
  DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY)
  DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)

  EndDrawing()
CloseWindow()
