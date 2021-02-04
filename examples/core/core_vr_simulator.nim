import raylib

# run it in examples/core

when defined(PLATFORM_DESKTOP):
  const GLSL_VERSION = 330
else:
  const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)
InitWindow(screenWidth, screenHeight, "raylib [core] example - vr simulator")
InitVrSimulator()

var
  hmd = VrDeviceInfo(
    hResolution: 2160,
    vResolution: 1200,
    hScreenSize: 0.133793,
    vScreenSize: 0.0669,
    vScreenCenter: 0.04678,
    eyeToScreenDistance: 0.041,
    lensSeparationDistance: 0.07,
    interpupillaryDistance: 0.07,
    lensDistortionValues: [1.0.cfloat, 0.22, 0.24, 0.0],
    chromaAbCorrection: [0.996.cfloat, -0.004, 1.014, 0.0]
  )
  distortion = LoadShader(nil, FormatText("resources/distortion%i.fs", GLSL_VERSION))

SetVrConfiguration(hmd, distortion)

var
  camera = Camera(
    position: Vector3(x: 5.0, y: 2.0, z: 5.0),
    target: Vector3(x: 0.0, y: 2.0, z: 0.0),
    up: Vector3(x: 0.0, y: 1.0, z: 0.0),
    fovy: 60.0,
    type: CAMERA_PERSPECTIVE
  )
  cubePosition = Vector3(x: 0.0, y: 0.0, z: 0.0)

SetCameraMode(camera, CAMERA_FIRST_PERSON)
SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)
  if IsKeyPressed(KEY_SPACE):
    ToggleVrMode()
  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginVrDrawing()
  BeginMode3D(camera)
  DrawCube(cubePosition, 2.0, 2.0, 2.0, RED)
  DrawCubeWires(cubePosition, 2.0, 2.0, 2.0, MAROON)
  DrawGrid(40, 1.0)
  EndMode3D()
  EndVrDrawing()
  DrawFPS(10, 10)

  EndDrawing()

UnloadShader(distortion)
CloseVrSimulator()
CloseWindow()
