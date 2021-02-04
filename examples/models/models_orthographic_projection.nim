import raylib

const
  FOVY_PERSPECTIVE = 45.0
  WIDTH_ORTHOGRAPHIC = 10.0
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - geometric shapes")

var
  camera = Camera(
      position: Vector3(x: 0.0, y: 10.0, z: 10.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: FOVY_PERSPECTIVE,
      type: CAMERA_PERSPECTIVE)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_SPACE):
    if camera.type == CAMERA_PERSPECTIVE:
      camera.fovy = WIDTH_ORTHOGRAPHIC
      camera.type = CAMERA_ORTHOGRAPHIC
    else:
      camera.fovy = FOVY_PERSPECTIVE
      camera.type = CAMERA_PERSPECTIVE

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)

  DrawCube(Vector3(x: -4.0, y: 0.0, z: 2.0), 2.0, 5.0, 2.0, RED)
  DrawCubeWires(Vector3(x: -4.0, y: 0.0, z: 2.0), 2.0, 5.0, 2.0, GOLD)
  DrawCubeWires(Vector3(x: -4.0, y: 0.0, z: -2.0), 3.0, 6.0, 2.0, MAROON)
  DrawSphere(Vector3(x: -1.0, y: 0.0, z: -2.0), 1.0, GREEN)
  DrawSphereWires(Vector3(x: 1.0, y: 0.0, z: 2.0), 2.0, 16, 16, LIME)
  DrawCylinder(Vector3(x: 4.0, y: 0.0, z: -2.0), 1.0, 2.0, 3.0, 4, SKYBLUE)
  DrawCylinderWires(Vector3(x: 4.0, y: 0.0, z: -2.0), 1.0, 2.0, 3.0, 4, DARKBLUE)
  DrawCylinderWires(Vector3(x: 4.5f, y: -1.0, z: 2.0), 1.0, 1.0, 2.0, 6, BROWN)
  DrawCylinder(Vector3(x: 1.0, y: 0.0, z: -4.0), 0.0, 1.5, 3.0, 8, GOLD)
  DrawCylinderWires(Vector3(x: 1.0, y: 0.0, z: -4.0), 0.0, 1.5, 3.0, 8, PINK)

  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("Press Spacebar to switch camera type", 10,
      GetScreenHeight() - 30, 20, DARKGRAY)

  if camera.type == CAMERA_ORTHOGRAPHIC:
    DrawText("ORTHOGRAPHIC", 10, 40, 20, BLACK)
  elif camera.type == CAMERA_PERSPECTIVE:
    DrawText("PERSPECTIVE", 10, 40, 20, BLACK)
  DrawFPS(10, 10)

  EndDrawing()

CloseWindow()
