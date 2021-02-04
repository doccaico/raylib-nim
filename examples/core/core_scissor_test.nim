import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  scissorArea = Rectangle(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
  scissorMode = true

InitWindow(screenWidth, screenHeight, "raylib [core] example - scissor test")
SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_S):
    scissorMode = not scissorMode
  scissorArea.x = GetMouseX().float32 - scissorArea.width / 2
  scissorArea.y = GetMouseY().float32 - scissorArea.height / 2

  BeginDrawing()
  ClearBackground(RAYWHITE)
  if scissorMode:
    BeginScissorMode(scissorArea.x.cint, scissorArea.y.cint, scissorArea.width.cint,
        scissorArea.height.cint)
  DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), RED)
  DrawText("Move the mouse around to reveal this text!", 190, 200, 20, LIGHTGRAY)
  if scissorMode:
    EndScissorMode()
  DrawRectangleLinesEx(scissorArea, 1, BLACK)
  DrawText("Press S to toggle scissor test", 10, 10, 20, BLACK)
  EndDrawing()
CloseWindow()
