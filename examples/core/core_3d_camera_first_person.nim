import raylib

const
  MAX_COLUMNS = 20
  screenWidth = 800
  screenHeight = 450

var
  camera = Camera(
      position: Vector3(x: 4.0, y: 2.0, z: 4.0),
      target: Vector3(x: 0.0, y: 1.8, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 60.0,
      type: CAMERA_PERSPECTIVE)
  heights: array[MAX_COLUMNS, cfloat]
  positions: array[MAX_COLUMNS, Vector3]
  colors: array[MAX_COLUMNS, Color]

for i in 0..<MAX_COLUMNS:
  heights[i] = GetRandomValue(1, 12).cfloat
  positions[i] = Vector3(x: GetRandomValue(-15, 15).cfloat, y: heights[i]/2,
      z: GetRandomValue(-15, 15).cfloat)
  colors[i] = Color(r: GetRandomValue(20, 255).cuchar, g: GetRandomValue(10, 55).cuchar,
      b: 30.cuchar, a: 255.cuchar)

InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera first person")
SetCameraMode(camera, CAMERA_FIRST_PERSON)
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)
  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawPlane(Vector3(x: 0.0, y: 0.0, z: 0.0), Vector2(x: 32.0, y: 32.0), LIGHTGRAY)
  DrawCube(Vector3(x: -16.0, y: 2.5, z: 0.0), 1.0, 5.0, 32.0, BLUE)
  DrawCube(Vector3(x: 16.0, y: 2.5, z: 0.0), 1.0, 5.0, 32.0, LIME)
  DrawCube(Vector3(x: 0.0, y: 2.5, z: 16.0), 32.0, 5.0, 1.0, GOLD)
  for i in 0..<MAX_COLUMNS:
    DrawCube(positions[i], 2.0, heights[i], 2.0, colors[i])
    DrawCubeWires(positions[i], 2.0, heights[i], 2.0, MAROON)
  EndMode3D()

  DrawRectangle(10, 10, 220, 70, Fade(SKYBLUE, 0.5))
  DrawRectangleLines(10, 10, 220, 70, BLUE)

  DrawText("First person camera default controls:", 20, 20, 10, BLACK)
  DrawText("- Move with keys: W, A, S, D", 40, 40, 10, DARKGRAY)
  DrawText("- Mouse move to look around", 40, 60, 10, DARKGRAY)
  EndDrawing()
CloseWindow()
