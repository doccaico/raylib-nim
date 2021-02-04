import raylib
import raylib/raymath

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib - simple shader mask")

var
  camera = Camera(
      position: Vector3(x: 0.0, y: 1.0, z: 2.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  torus = GenMeshTorus(0.3, 1.0, 16, 32)
  model1 = LoadModelFromMesh(torus)
  cube = GenMeshCube(0.8, 0.8, 0.8)
  model2 = LoadModelFromMesh(cube)
  sphere = GenMeshSphere(1.0, 16, 16)
  model3 = LoadModelFromMesh(sphere)
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/mask.fs",
      GLSL_VERSION))
  framesCounter = 0.cint
  rotation: Vector3

var texDiffuse = LoadTexture("resources/plasma.png")
cast[ptr MaterialMap](
    cast[ByteAddress](model1.materials.maps) +%
    MAP_DIFFUSE * sizeof(model1.materials.maps[])).texture = texDiffuse
cast[ptr MaterialMap](
    cast[ByteAddress](model2.materials.maps) +%
    MAP_DIFFUSE * sizeof(model2.materials.maps[])).texture = texDiffuse

var texMask = LoadTexture("resources/mask.png")
cast[ptr MaterialMap](
    cast[ByteAddress](model1.materials.maps) +%
    MAP_EMISSION * sizeof(model1.materials.maps[])).texture = texMask
cast[ptr MaterialMap](
    cast[ByteAddress](model2.materials.maps) +%
    MAP_EMISSION * sizeof(model2.materials.maps[])).texture = texMask
cast[ptr cint](
    cast[ByteAddress](shader.locs) +%
    LOC_MAP_EMISSION * sizeof(shader.locs[]))[] = GetShaderLocation(shader, "mask")

var shaderFrame = GetShaderLocation(shader, "frame")

model1.materials.shader = shader
model2.materials.shader = shader

SetTargetFPS(60)

while not WindowShouldClose():
  inc framesCounter
  rotation.x += 0.01
  rotation.y += 0.005
  rotation.z -= 0.0025
  SetShaderValue(shader, shaderFrame, framesCounter.addr, UNIFORM_INT)
  model1.transform = MatrixRotateXYZ(rotation)
  UpdateCamera(camera.addr)

  BeginDrawing()
  ClearBackground(DARKBLUE)

  BeginMode3D(camera)
  DrawModel(model1, Vector3(x: 0.5, y: 0.0, z: 0.0), 1, WHITE)
  DrawModelEx(model2,
      Vector3(x: -0.5, y: 0.0, z: 0.0),
      Vector3(x: 1.0, y: 1.0, z: 0.0), 50,
      Vector3(x: 1.0, y: 1.0, z: 1.0), WHITE)
  DrawModel(model3, Vector3(x: 0.0 , y: 0.0, z: -1.5), 1, WHITE)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawRectangle(16, 698,
      MeasureText(FormatText("Frame: %i", framesCounter), 20) + 8, 42, BLUE)
  DrawText(FormatText("Frame: %i", framesCounter), 20, 700, 20, WHITE)
  DrawFPS(10, 10)

  EndDrawing()

UnloadModel(model1)
UnloadModel(model2)
UnloadModel(model3)
UnloadTexture(texDiffuse)
UnloadTexture(texMask)
UnloadShader(shader)
CloseWindow()
