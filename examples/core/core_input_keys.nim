import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  ballPosition = Vector2(x: screenWidth / 2, y: screenHeight / 2)

InitWindow(screenWidth, screenHeight, "raylib [core] example - keyboard input")
SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyDown(KEY_RIGHT):
    ballPosition.x += 2.0
  if IsKeyDown(KEY_LEFT):
    ballPosition.x -= 2.0
  if IsKeyDown(KEY_UP):
    ballPosition.y -= 2.0
  if IsKeyDown(KEY_DOWN):
    ballPosition.y += 2.0
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("move the ball with arrow keys", 10, 10, 20, DARKGRAY)
  DrawCircleV(ballPosition, 50, MAROON)
  EndDrawing()
CloseWindow()
