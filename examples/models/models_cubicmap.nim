import raylib

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [models] example - cubesmap loading and drawing")

var
  camera = Camera(
      position: Vector3(x: 16.0, y: 14.0, z: 16.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: 0)
  image = LoadImage("resources/cubicmap.png")
  cubicmap = LoadTextureFromImage(image)
  mesh = GenMeshCubicmap(image, Vector3(x: 1.0, y: 1.0, z: 1.0))
  model = LoadModelFromMesh(mesh)
  texture = LoadTexture("resources/cubicmap_atlas.png")
  mapPosition = Vector3(x: -16.0, y: 0.0, z: -8.0)

model.materials[0].maps[MAP_DIFFUSE].texture = texture

UnloadImage(image)

SetCameraMode(camera, CAMERA_ORBITAL)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, mapPosition, 1.0, WHITE)
  EndMode3D()

  DrawTextureEx(cubicmap,
      Vector2(x: (screenWidth - cubicmap.width*4 - 20).cfloat, y: 20), 0.0, 4.0, WHITE)
  DrawRectangleLines(screenWidth - cubicmap.width*4 - 20, 20, cubicmap.width*4,
      cubicmap.height*4, GREEN)

  DrawText("cubicmap image used to", 658, 90, 10, GRAY)
  DrawText("generate map 3d model", 658, 104, 10, GRAY)

  DrawFPS(10, 10)
  EndDrawing()

UnloadTexture(cubicmap)
UnloadTexture(texture)
UnloadModel(model)
CloseWindow()
