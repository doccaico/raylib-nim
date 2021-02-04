import raylib

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  NUM_MODELS = 8
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - mesh generation")

var
  checked = GenImageChecked(2, 2, 1, 1, RED, GREEN)
  texture = LoadTextureFromImage(checked)
  models: array[NUM_MODELS, Model]
  camera = Camera(
    position: Vector3(x: 5.0, y: 5.0, z: 5.0),
    target: Vector3(x: 0.0, y: 0.0, z: 0.0),
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),
    fovy: 45.0,
    type: 0)
  position = Vector3(x: 0.0, y: 0.0, z: 0.0)
  currentModel = 0.cint

models[0] = LoadModelFromMesh(GenMeshPlane(2, 2, 5, 5))
models[1] = LoadModelFromMesh(GenMeshCube(2.0, 1.0, 2.0))
models[2] = LoadModelFromMesh(GenMeshSphere(2, 32, 32))
models[3] = LoadModelFromMesh(GenMeshHemiSphere(2, 16, 16))
models[4] = LoadModelFromMesh(GenMeshCylinder(1, 2, 16))
models[5] = LoadModelFromMesh(GenMeshTorus(0.25, 4.0, 16, 32))
models[6] = LoadModelFromMesh(GenMeshKnot(1.0, 2.0, 16, 128))
models[7] = LoadModelFromMesh(GenMeshPoly(5, 2.0))

for i in 0..<NUM_MODELS:
  models[i].materials[0].maps[MAP_DIFFUSE].texture = texture

UnloadImage(checked)

SetCameraMode(camera, CAMERA_ORBITAL)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    currentModel = (currentModel + 1) mod NUM_MODELS

  if IsKeyPressed(KEY_RIGHT):
    inc currentModel
    if currentModel >= NUM_MODELS:
      currentModel = 0
  elif IsKeyPressed(KEY_LEFT):
    dec currentModel
    if currentModel < 0:
      currentModel = NUM_MODELS - 1

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(models[currentModel], position, 1.0, WHITE)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawRectangle(30, 400, 310, 30, Fade(SKYBLUE, 0.5f))
  DrawRectangleLines(30, 400, 310, 30, Fade(DARKBLUE, 0.5f))
  DrawText("MOUSE LEFT BUTTON to CYCLE PROCEDURAL MODELS", 40, 410, 10, BLUE)

  case currentModel:
    of 0: DrawText("PLANE", 680, 10, 20, DARKBLUE)
    of 1: DrawText("CUBE", 680, 10, 20, DARKBLUE)
    of 2: DrawText("SPHERE", 680, 10, 20, DARKBLUE)
    of 3: DrawText("HEMISPHERE", 640, 10, 20, DARKBLUE)
    of 4: DrawText("CYLINDER", 680, 10, 20, DARKBLUE)
    of 5: DrawText("TORUS", 680, 10, 20, DARKBLUE)
    of 6: DrawText("KNOT", 680, 10, 20, DARKBLUE)
    of 7: DrawText("POLY", 680, 10, 20, DARKBLUE)
    else: discard

  EndDrawing()

UnloadTexture(texture)
for i in 0..<NUM_MODELS:
  UnloadModel(models[i])
CloseWindow()
