import raylib

{.passL: "-lm".}

proc cos(x: cdouble): cdouble {.
  importc, header: "<math.h>".}
proc sin(x: cdouble): cdouble {.
  importc, header: "<math.h>".}
proc sinf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}

const
  screenWidth = 800
  screenHeight = 450
  numBlocks = 15

InitWindow(screenWidth, screenHeight, "raylib [models] example - waving cubes")

var camera = Camera(
      position: Vector3(x: 30.0, y: 20.0, z: 30.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 70.0,
      type: CAMERA_PERSPECTIVE)

SetTargetFPS(60)

while not WindowShouldClose():
  var time = GetTime().cdouble

  var scale: cfloat = (2.0 + sin(time).cfloat)*0.7
  var cameraTime: cdouble = time*0.3

  camera.position.x = cos(cameraTime).cfloat*40.0
  camera.position.z = sin(cameraTime).cfloat*40.0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawGrid(10, 5.0)

  for x in 0..<numBlocks:
    for y in 0..<numBlocks:
      for z in 0..<numBlocks:
        var blockScale: cfloat = ((x + y + z) div 30).cfloat
        var scatter: cfloat = sinf(blockScale*20.0 + (float)(time*4.0))
        var cubePos = Vector3(
            x: (x - numBlocks div 2).cfloat*(scale*3.0) + scatter,
            y: (y - numBlocks div 2).cfloat*(scale*2.0) + scatter,
            z: (z - numBlocks div 2).cfloat*(scale*3.0) + scatter)
        var cubeColor = ColorFromHSV(
            Vector3(x: (((x + y + z)*18) mod 360).cfloat, y: 0.75, z: 0.9))
        var  cubeSize: cfloat = (2.4 - scale)*blockScale
        DrawCube(cubePos, cubeSize, cubeSize, cubeSize, cubeColor)

  EndMode3D()
  DrawFPS(10, 10)

  EndDrawing()

CloseWindow()
