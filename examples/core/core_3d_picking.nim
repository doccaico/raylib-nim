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
  cubePosition = Vector3(x: 0.0, y: 1.0, z: 0.0)
  cubeSize = Vector3(x: 2.0, y: 2.0, z: 2.0)
  ray: Ray
  collision = false

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d picking")
SetCameraMode(camera, CAMERA_FREE)
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)
  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    if not collision:
      ray = GetMouseRay(GetMousePosition(), camera)
      collision = CheckCollisionRayBox(
          ray,
          BoundingBox(
              min: Vector3(
                  x: cubePosition.x - cubeSize.x/2,
                  y: cubePosition.y - cubeSize.y/2,
                  z: cubePosition.z - cubeSize.z/2),
              max: Vector3(
                  x: cubePosition.x + cubeSize.x/2,
                  y: cubePosition.y + cubeSize.y/2,
                  z: cubePosition.z + cubeSize.z/2)))
    else:
      collision = false

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  if collision:
    DrawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, RED)
    DrawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, MAROON)
    DrawCubeWires(cubePosition, cubeSize.x + 0.2, cubeSize.y + 0.2, cubeSize.z +
        0.2, GREEN)
  else:
    DrawCube(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, GRAY)
    DrawCubeWires(cubePosition, cubeSize.x, cubeSize.y, cubeSize.z, DARKGRAY)
  DrawRay(ray, MAROON)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("Try selecting the box with mouse!", 240, 10, 20, DARKGRAY)
  if collision:
    DrawText("BOX SELECTED",
        ((screenWidth - MeasureText("BOX SELECTED", 30)) / 2).cint,
        (screenHeight.cfloat * 0.1).cint, 30, GREEN)
  DrawFPS(10, 10)
  EndDrawing()
CloseWindow()
