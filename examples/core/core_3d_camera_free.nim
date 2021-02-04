import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  camera = Camera(
      position: Vector3(x: 10.0, y: 10.0, z: 10.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  cubePosition = Vector3(x: 0.0, y: 0.0, z: 0.0)

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera free")
SetCameraMode(camera, CAMERA_FREE)
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)
  if IsKeyDown(KEY_Z):
    camera.target = Vector3(x: 0.0, y: 0.0, z: 0.0)
  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawCube(cubePosition, 2.0, 2.0, 2.0, RED)
  DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawRectangle( 10, 10, 320, 133, Fade(SKYBLUE, 0.5))
  DrawRectangleLines( 10, 10, 320, 133, BLUE)

  DrawText("Free camera default controls:", 20, 20, 10, BLACK)
  DrawText("- Mouse Wheel to Zoom in-out", 40, 40, 10, DARKGRAY)
  DrawText("- Mouse Wheel Pressed to Pan", 40, 60, 10, DARKGRAY)
  DrawText("- Alt + Mouse Wheel Pressed to Rotate", 40, 80, 10, DARKGRAY)
  DrawText("- Alt + Ctrl + Mouse Wheel Pressed for Smooth Zoom", 40, 100, 10, DARKGRAY)
  DrawText("- Z to zoom to (0, 0, 0)", 40, 120, 10, DARKGRAY)
  EndDrawing()
CloseWindow()
