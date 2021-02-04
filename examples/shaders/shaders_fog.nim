import raylib
import raylib/raymath
import raylib/rlights

proc cosf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}
proc sinf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

template `[]=`[T](p: ptr T, off: int, val: T) =
  (p + off)[] = val

when defined(PLATFORM_DESKTOP):
    const GLSL_VERSION = 330
else:
    const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - fog")

var
  camera = Camera(
    position: Vector3(x: 2.0, y: 2.0, z: 6.0),
    target: Vector3(x: 0.0, y: 0.5, z: 0.0),
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),
    fovy: 45.0,
    type: CAMERA_PERSPECTIVE)
  modelA = LoadModelFromMesh(GenMeshTorus(0.4, 1.0, 16, 32))
  modelB = LoadModelFromMesh(GenMeshCube(1.0, 1.0, 1.0))
  modelC = LoadModelFromMesh(GenMeshSphere(0.5, 32, 32))
  texture = LoadTexture("resources/texel_checker.png")
  shader = LoadShader(
      FormatText("resources/shaders/glsl%i/base_lighting.vs", GLSL_VERSION), 
      FormatText("resources/shaders/glsl%i/fog.fs", GLSL_VERSION))
  ambientLoc = GetShaderLocation(shader, "ambient")
  val = [0.2.cfloat, 0.2, 0.2, 1.0]
  fogDensity = 0.15.cfloat
  fogDensityLoc = GetShaderLocation(shader, "fogDensity")

modelA.materials[0].maps[MAP_DIFFUSE].texture = texture
modelB.materials[0].maps[MAP_DIFFUSE].texture = texture
modelC.materials[0].maps[MAP_DIFFUSE].texture = texture

shader.locs[LOC_MATRIX_MODEL] = GetShaderLocation(shader, "matModel")
shader.locs[LOC_VECTOR_VIEW] = GetShaderLocation(shader, "viewPos")

SetShaderValue(shader, ambientLoc, val[0].addr , UNIFORM_VEC4)

modelA.materials[0].shader = shader
modelB.materials[0].shader = shader
modelC.materials[0].shader = shader

SetShaderValue(shader, fogDensityLoc, fogDensity.addr, UNIFORM_FLOAT)

discard CreateLight(LIGHT_POINT,
    Vector3(x: 0.0, y:2.0, z: 0.6), Vector3Zero(), WHITE, shader)

SetCameraMode(camera, CAMERA_ORBITAL)

SetTargetFPS(60)

while not WindowShouldClose():

  UpdateCamera(camera.addr)

  if IsKeyDown(KEY_UP):
    fogDensity += 0.001
    if fogDensity > 1.0: fogDensity = 1.0
  if IsKeyDown(KEY_DOWN):
    fogDensity -= 0.001
    if fogDensity < 0.0: fogDensity = 0.0

  SetShaderValue(shader, fogDensityLoc, fogDensity.addr, UNIFORM_FLOAT)

  modelA.transform = MatrixMultiply(modelA.transform, MatrixRotateX(-0.025))
  modelA.transform = MatrixMultiply(modelA.transform, MatrixRotateZ(0.012))

  SetShaderValue(shader, shader.locs[LOC_VECTOR_VIEW],
      camera.position.x.addr, UNIFORM_VEC3)

  BeginDrawing()
  ClearBackground(GRAY)

  BeginMode3D(camera)

  DrawModel(modelA, Vector3Zero(), 1.0, WHITE)
  DrawModel(modelB, Vector3(x: -2.6, y: 0.0, z: 0.0), 1.0, WHITE)
  DrawModel(modelC, Vector3(x: 2.6, y: 0.0, z: 0.0), 1.0, WHITE)

  var i = -20
  while i < 20:
    DrawModel(modelA, Vector3(x: i.cfloat, y: 0.0, z: 2.0), 1.0, WHITE)
    i += 2

  EndMode3D()

  DrawText(TextFormat("Use KEY_UP/KEY_DOWN to change fog density [%.2f]",
      fogDensity), 10, 10, 20, RAYWHITE)

  EndDrawing()

UnloadModel(modelA)
UnloadModel(modelB)
UnloadModel(modelC)
UnloadTexture(texture)
UnloadShader(shader)
CloseWindow()
