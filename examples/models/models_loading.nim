import raylib

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - models loading")

var
  camera = Camera(
    position: Vector3(x: 50.0, y: 50.0, z: 50.0),
    target: Vector3(x: 0.0, y: 10.0, z: 0.0),
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),
    fovy: 45.0,
    type: CAMERA_PERSPECTIVE)
  model = LoadModel("resources/models/castle.obj")
  texture = LoadTexture("resources/models/castle_diffuse.png")
  position = Vector3(x: 0.0, y: 0.0, z: 0.0)
  selected = false

model.materials[0].maps[MAP_DIFFUSE].texture = texture

var bounds = MeshBoundingBox(model.meshes[0])

SetCameraMode(camera, CAMERA_FREE)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  if IsFileDropped():
    var count = 0.cint
    var droppedFiles = GetDroppedFiles(count.addr)

    if count == 1:
      if IsFileExtension(droppedFiles[0], ".obj") or
          IsFileExtension(droppedFiles[0], ".gltf") or
          IsFileExtension(droppedFiles[0], ".iqm"):
        UnloadModel(model)
        model = LoadModel(droppedFiles[0])
        model.materials[0].maps[MAP_DIFFUSE].texture = texture
        bounds = MeshBoundingBox(model.meshes[0])

      elif IsFileExtension(droppedFiles[0], ".png"):
        UnloadTexture(texture)
        texture = LoadTexture(droppedFiles[0])
        model.materials[0].maps[MAP_DIFFUSE].texture = texture
    ClearDroppedFiles()

  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    if CheckCollisionRayBox(GetMouseRay(GetMousePosition(), camera), bounds):
      selected = not selected
    else:
      selected = false

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, position, 1.0, WHITE)
  DrawGrid(20, 10.0)
  if selected:
    DrawBoundingBox(bounds, GREEN)
  EndMode3D()

  DrawText("Drag & drop model to load mesh/texture.", 10,
      GetScreenHeight() - 20, 10, DARKGRAY)
  if selected:
    DrawText("MODEL SELECTED", GetScreenWidth() - 110, 10, 10, GREEN)

  DrawText("(c) Castle 3D model by Alberto Cano", screenWidth - 200,
      screenHeight - 20, 10, GRAY)
  DrawFPS(10, 10)

  EndDrawing()

UnloadTexture(texture)
UnloadModel(model)
CloseWindow()
