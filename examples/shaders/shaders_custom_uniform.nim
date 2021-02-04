import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight,
    "raylib [shaders] example - custom uniform variable")

var
  camera = Camera(
    position: Vector3(x: 8.0, y: 8.0, z: 8.0),
    target: Vector3(x: 0.0, y: 1.5, z: 0.0),
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),
    fovy: 45.0,
    type: CAMERA_PERSPECTIVE)
  model = LoadModel("resources/models/barracks.obj")
  texture = LoadTexture("resources/models/barracks_diffuse.png")

# C version
# model.materials[0].maps[MAP_DIFFUSE].texture = texture;

# Nim version (it works, but I'm not sure if that is the right approach)
var pMaterial = cast[ptr Material](
    cast[ByteAddress](model.materials) +% 0 * sizeof(model.materials[]))
var pMaterialMap = cast[ptr MaterialMap](
    cast[ByteAddress](pMaterial.maps) +% MAP_DIFFUSE * sizeof(pMaterial.maps[]))
pMaterialMap.texture = texture

# echo "sizeof(model.materials): " & $model.materials.sizeof
# echo "sizeof(model.materials[]): " & $model.materials[].sizeof
# echo "sizeof(pMaterial.maps): " & $sizeof(pMaterial.maps)
# echo "sizeof(pMaterial.maps[]): " & $sizeof(pMaterial.maps[])

var
  position = Vector3(x: 0.0, y: 0.0, z: 0.0)
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/swirl.fs", GLSL_VERSION))
  swirlCenterLoc = GetShaderLocation(shader, "center")
  swirlCenter = [(screenWidth/2).cfloat, screenHeight/2]
  target = LoadRenderTexture(screenWidth, screenHeight)

SetCameraMode(camera, CAMERA_ORBITAL)

SetTargetFPS(60)

while not WindowShouldClose():
  var mousePosition = GetMousePosition()

  swirlCenter[0] = mousePosition.x
  swirlCenter[1] = screenHeight - mousePosition.y

  SetShaderValue(shader, swirlCenterLoc,
      cast[ptr cfloat](swirlCenter.addr), UNIFORM_VEC2)

  UpdateCamera(camera.addr)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginTextureMode(target)
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, position, 0.5, WHITE)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("TEXT DRAWN IN RENDER TEXTURE", 200, 10, 30, RED)
  EndTextureMode()

  BeginShaderMode(shader)
  DrawTextureRec(target.texture,
      Rectangle(x: 0, y: 0, width: target.texture.width.cfloat,
          height: -target.texture.height.cfloat),
      Vector2(x: 0, y: 0), WHITE)
  EndShaderMode()

  DrawText("(c) Barracks 3D model by Alberto Cano",
      screenWidth - 220, screenHeight - 20, 10, GRAY)
  DrawFPS(10, 10)

  EndDrawing()

UnloadShader(shader)
UnloadTexture(texture)
UnloadModel(model)
UnloadRenderTexture(target)
CloseWindow()
