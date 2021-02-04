import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - drawing billboards")

var
  camera = Camera(
      position: Vector3(x: 5.0, y: 4.0, z: 5.0),
      target: Vector3(x: 0.0, y: 2.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  bill = LoadTexture("resources/billboard.png")
  billPosition = Vector3(x: 0.0, y: 2.0, z: 0.0)

SetCameraMode(camera, CAMERA_ORBITAL)
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawGrid(10, 1.0)
  DrawBillboard(camera, bill, billPosition, 2.0, WHITE)
  EndMode3D()

  DrawFPS(10, 10)
  EndDrawing()

UnloadTexture(bill)
CloseWindow()
