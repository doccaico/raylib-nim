import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  camera = Camera3D(
      position: Vector3(x: 0.0, y: 10.0, z: 10.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  cubePosition = Vector3(x: 0.0, y: 0.0, z: 0.0)

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera mode")
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)
  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawCube(cubePosition, 2.0, 2.0, 2.0, RED)
  DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("Welcome to the third dimension!", 10, 40, 20, DARKGRAY)
  DrawFPS(10, 10)
  EndDrawing()
CloseWindow()
