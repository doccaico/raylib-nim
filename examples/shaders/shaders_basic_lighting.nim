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

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - basic lighting")

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
      FormatText("resources/shaders/glsl%i/lighting.fs", GLSL_VERSION))
  ambientLoc = GetShaderLocation(shader, "ambient")
  val = [0.2.cfloat, 0.2, 0.2, 1.0]
  angle = 6.282.cfloat
  lights: array[MAX_LIGHTS, Light]

modelA.materials[0].maps[MAP_DIFFUSE].texture = texture
modelB.materials[0].maps[MAP_DIFFUSE].texture = texture
modelC.materials[0].maps[MAP_DIFFUSE].texture = texture

shader.locs[LOC_MATRIX_MODEL] = GetShaderLocation(shader, "matModel")
shader.locs[LOC_VECTOR_VIEW] = GetShaderLocation(shader, "viewPos")

SetShaderValue(shader, ambientLoc, val[0].addr , UNIFORM_VEC4)

modelA.materials[0].shader = shader
modelB.materials[0].shader = shader
modelC.materials[0].shader = shader

lights[0] = CreateLight(LIGHT_POINT, Vector3(x: 4.0, y: 2.0, z: 4.0),
    Vector3Zero(), WHITE, shader)
lights[1] = CreateLight(LIGHT_POINT, Vector3(x: 4.0, y: 2.0, z: 4.0),
    Vector3Zero(), RED, shader)
lights[2] = CreateLight(LIGHT_POINT, Vector3(x: 0.0, y: 4.0, z: 2.0),
    Vector3Zero(), GREEN, shader)
lights[3] = CreateLight(LIGHT_POINT, Vector3(x: 0.0, y: 4.0, z: 2.0),
    Vector3Zero(), BLUE, shader)

SetCameraMode(camera, CAMERA_ORBITAL)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_W): lights[0].enabled = not lights[0].enabled
  if IsKeyPressed(KEY_R): lights[1].enabled = not lights[1].enabled
  if IsKeyPressed(KEY_G): lights[2].enabled = not lights[2].enabled
  if IsKeyPressed(KEY_B): lights[3].enabled = not lights[3].enabled

  UpdateCamera(camera.addr)

  angle -= 0.02
  lights[0].position.x = cosf(angle)*4.0
  lights[0].position.z = sinf(angle)*4.0
  lights[1].position.x = cosf(-angle*0.6f)*4.0
  lights[1].position.z = sinf(-angle*0.6f)*4.0
  lights[2].position.y = cosf(angle*0.2f)*4.0
  lights[2].position.z = sinf(angle*0.2f)*4.0
  lights[3].position.y = cosf(-angle*0.35f)*4.0
  lights[3].position.z = sinf(-angle*0.35f)*4.0

  UpdateLightValues(shader, lights[0])
  UpdateLightValues(shader, lights[1])
  UpdateLightValues(shader, lights[2])
  UpdateLightValues(shader, lights[3])

  modelA.transform = MatrixMultiply(modelA.transform, MatrixRotateX(-0.025))
  modelA.transform = MatrixMultiply(modelA.transform, MatrixRotateZ(0.012))

  var cameraPos = [camera.position.x, camera.position.y, camera.position.z]
  SetShaderValue(shader, shader.locs[LOC_VECTOR_VIEW], cameraPos.addr, UNIFORM_VEC3)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(modelA, Vector3Zero(), 1.0, WHITE)
  DrawModel(modelB, Vector3(x: -1.6, y: 0.0, z: 0.0), 1.0, WHITE)
  DrawModel(modelC, Vector3(x:  1.6, y: 0.0, z: 0.0), 1.0, WHITE)

  if lights[0].enabled: DrawSphereEx(lights[0].position, 0.2, 8, 8, WHITE)
  if lights[1].enabled: DrawSphereEx(lights[1].position, 0.2, 8, 8, RED)
  if lights[2].enabled: DrawSphereEx(lights[2].position, 0.2, 8, 8, GREEN)
  if lights[3].enabled: DrawSphereEx(lights[3].position, 0.2, 8, 8, BLUE)

  DrawGrid(10, 1.0)
  EndMode3D()

  DrawFPS(10, 10)
  DrawText("Use keys RGBW to toggle lights", 10, 30, 20, DARKGRAY)

  EndDrawing()

UnloadModel(modelA)
UnloadModel(modelB)
UnloadModel(modelC)
UnloadTexture(texture)
UnloadShader(shader)
CloseWindow()
