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
  cubeScreenPosition = Vector2(x: 0.0, y: 0.0)

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera free")
SetCameraMode(camera, CAMERA_FREE)
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)
  var cubeScreenPosition = GetWorldToScreen(
      Vector3(x: cubePosition.x, y: cubePosition.y + 2.5, z: cubePosition.z),
      camera)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawCube(cubePosition, 2.0, 2.0, 2.0, RED)
  DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("Enemy: 100 / 100",
      (cubeScreenPosition.x - MeasureText("Enemy: 100/100", 20)/2).cint,
      cubeScreenPosition.y.cint,
      20,
      BLACK)
  DrawText("Text is always on top of the cube",
      ((screenWidth - MeasureText(
          "Text is always on top of the cube", 20))/2).cint,
      25.cint,
      20,
      GRAY)
  EndDrawing()
CloseWindow()
