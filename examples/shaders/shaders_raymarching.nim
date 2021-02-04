import raylib

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

var
  screenWidth = 800.cint
  screenHeight = 450.cint

SetConfigFlags(FLAG_WINDOW_RESIZABLE)

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - raymarching shapes")

var
  camera = Camera(
      position: Vector3(x: 2.5, y: 2.5, z: 3.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.7),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 65.0,
      type: 0.cint)
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/raymarching.fs",
      GLSL_VERSION))
  viewEyeLoc = GetShaderLocation(shader, "viewEye")
  viewCenterLoc = GetShaderLocation(shader, "viewCenter")
  runTimeLoc = GetShaderLocation(shader, "runTime")
  resolutionLoc = GetShaderLocation(shader, "resolution")
  resolution = [screenWidth.cfloat, screenHeight.cfloat]
  runTime = 0.0.cfloat

SetShaderValue(shader, resolutionLoc, cast[pointer](resolution.addr), UNIFORM_VEC2)

SetCameraMode(camera, CAMERA_FREE)
SetTargetFPS(60)

while not WindowShouldClose():

  if IsWindowResized():
    screenWidth = GetScreenWidth()
    screenHeight = GetScreenHeight()
    var resolution = [screenWidth.cfloat, screenHeight.cfloat]
    SetShaderValue(shader, resolutionLoc, cast[pointer](resolution.addr), UNIFORM_VEC2)

  UpdateCamera(camera.addr)

  var cameraPos = [camera.position.x, camera.position.y, camera.position.z]
  var cameraTarget = [camera.target.x, camera.target.y, camera.target.z]
  var deltaTime = GetFrameTime()
  runTime += deltaTime

  SetShaderValue(shader, viewEyeLoc,
      cast[pointer](cameraPos.addr), UNIFORM_VEC3)
  SetShaderValue(shader, viewCenterLoc,
      cast[pointer](cameraTarget.addr), UNIFORM_VEC3)
  SetShaderValue(shader, runTimeLoc,
      runTime.addr, UNIFORM_FLOAT)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginShaderMode(shader)
  DrawRectangle(0, 0, screenWidth, screenHeight, WHITE)
  EndShaderMode()

  DrawText("(c) Raymarching shader by Iñigo Quilez. MIT License.",
      screenWidth - 280, screenHeight - 20, 10, BLACK)
  EndDrawing()

UnloadShader(shader)
CloseWindow()
