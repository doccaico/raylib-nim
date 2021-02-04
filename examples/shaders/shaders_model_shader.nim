import raylib

when defined(PLATFORM_DESKTOP):
 const GLSL_VERSION = 330
else:
 const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - model shader")

var
  camera = Camera(
      position: Vector3(x: 4.0, y: 4.0, z: 4.0),
      target: Vector3(x: 0.0, y: 1.0, z: -1.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  model = LoadModel("resources/models/watermill.obj")
  texture = LoadTexture("resources/models/watermill_diffuse.png")
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/grayscale.fs",
      GLSL_VERSION))
  position = Vector3(x: 0.0, y: 0.0, z: 0.0)

model.materials.shader = shader
cast[ptr MaterialMap](
    cast[ByteAddress](model.materials.maps) +%
    MAP_DIFFUSE * sizeof(model.materials.maps[])).texture = texture

SetCameraMode(camera, CAMERA_FREE)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, position, 0.2, WHITE)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("(c) Watermill 3D model by Alberto Cano",
      screenWidth - 210, screenHeight - 20, 10, GRAY);
  DrawFPS(10, 10)
  EndDrawing()

UnloadShader(shader)
UnloadTexture(texture)
UnloadModel(model)
CloseWindow()
