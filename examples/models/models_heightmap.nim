import raylib

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [models] example - heightmap loading and drawing")

var
  camera = Camera(
    position: Vector3(x: 18.0, y: 18.0, z: 18.0),
    target: Vector3(x: 0.0, y: 0.0, z: 0.0),
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),
    fovy: 45.0,
    type: 0)
  image = LoadImage("resources/heightmap.png")
  texture = LoadTextureFromImage(image)
  mesh = GenMeshHeightmap(image, Vector3(x: 16.0, y: 8.0, z: 16.0))
  model = LoadModelFromMesh(mesh)
  mapPosition = Vector3(x: -8.0, y: 0.0, z: -8.0)

model.materials[0].maps[MAP_DIFFUSE].texture = texture

UnloadImage(image)

SetCameraMode(camera, CAMERA_ORBITAL)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, mapPosition, 1.0, RED)
  DrawGrid(20, 1.0)
  EndMode3D()

  DrawTexture(texture, screenWidth - texture.width - 20, 20, WHITE)
  DrawRectangleLines(screenWidth - texture.width - 20, 20, texture.width,
      texture.height, GREEN)
  DrawFPS(10, 10)

  EndDrawing()

UnloadTexture(texture)
UnloadModel(model)
CloseWindow()
