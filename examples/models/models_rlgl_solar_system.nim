import raylib
import raylib/rlgl

{.passL: "-lm".}

proc cosf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}
proc sinf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}

proc DrawSphereBasic(color: Color)

const
  screenWidth = 800
  screenHeight = 450
  sunRadius = 4.0
  earthRadius = 0.6
  earthOrbitRadius = 8.0
  moonRadius = 0.16
  moonOrbitRadius = 1.5

InitWindow(screenWidth, screenHeight,
    "raylib [models] example - rlgl module usage with push/pop matrix transformations")

var
  camera = Camera(
      position: Vector3(x: 16.0, y: 16.0, z: 16.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  rotationSpeed = 0.2.cfloat
  earthRotation = 0.0.cfloat
  earthOrbitRotation = 0.0.cfloat
  moonRotation = 0.0.cfloat
  moonOrbitRotation = 0.0.cfloat

SetCameraMode(camera, CAMERA_FREE)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  earthRotation += (5.0*rotationSpeed)
  earthOrbitRotation += (365 div 360*(5.0*rotationSpeed)*rotationSpeed)
  moonRotation += (2.0*rotationSpeed)
  moonOrbitRotation += (8.0*rotationSpeed)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  rlPushMatrix()
  rlScalef(sunRadius, sunRadius, sunRadius)
  DrawSphereBasic(GOLD)
  rlPopMatrix()

  rlPushMatrix()
  rlRotatef(earthOrbitRotation, 0.0, 1.0, 0.0)
  rlTranslatef(earthOrbitRadius, 0.0, 0.0)
  rlRotatef(-earthOrbitRotation, 0.0, 1.0, 0.0)

  rlPushMatrix()
  rlRotatef(earthRotation, 0.25, 1.0, 0.0)
  rlScalef(earthRadius, earthRadius, earthRadius)
  DrawSphereBasic(BLUE)
  rlPopMatrix()

  rlRotatef(moonOrbitRotation, 0.0, 1.0, 0.0)
  rlTranslatef(moonOrbitRadius, 0.0, 0.0)
  rlRotatef(-moonOrbitRotation, 0.0, 1.0, 0.0)
  rlRotatef(moonRotation, 0.0, 1.0, 0.0)
  rlScalef(moonRadius, moonRadius, moonRadius)

  DrawSphereBasic(LIGHTGRAY)
  rlPopMatrix()

  DrawCircle3D(
      Vector3(x:  0.0, y: 0.0, z: 0.0 ), earthOrbitRadius,
      Vector3(x:  1, y: 0, z: 0 ), 90.0, Fade(RED, 0.5))
  DrawGrid(20, 1.0)
  EndMode3D()

  DrawText("EARTH ORBITING AROUND THE SUN!", 400, 10, 20, MAROON)
  DrawFPS(10, 10)

  EndDrawing()

CloseWindow()


proc DrawSphereBasic(color: Color) =
  var rings = 16.cint
  var slices = 16.cint

  rlBegin(RL_TRIANGLES)
  rlColor4ub(color.r, color.g, color.b, color.a)

  for i in 0..<(rings+2):
    for j in 0..<slices:
      rlVertex3f(
          cosf(DEG2RAD*(270+(180 div (rings + 1))*i).cfloat) *
              sinf(DEG2RAD*(j*360 div slices).cfloat),
          sinf(DEG2RAD*(270+(180 div (rings + 1))*i).cfloat),
          cosf(DEG2RAD*(270+(180 div (rings + 1))*i).cfloat) *
              cosf(DEG2RAD*(j*360 div slices).cfloat))

      rlVertex3f(
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat) *
              sinf(DEG2RAD*((j+1)*360 div slices).cfloat),
          sinf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat),
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat) *
              cosf(DEG2RAD*((j+1)*360 div slices).cfloat))

      rlVertex3f(
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat) *
              sinf(DEG2RAD*(j*360 div slices).cfloat),
          sinf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat),
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat) *
              cosf(DEG2RAD*(j*360 div slices).cfloat))

      rlVertex3f(
          cosf(DEG2RAD*(270+(180 div (rings + 1))*i).cfloat) *
              sinf(DEG2RAD*(j*360 div slices).cfloat),
          sinf(DEG2RAD*(270+(180 div (rings + 1))*i).cfloat),
          cosf(DEG2RAD*(270+(180 div (rings + 1))*i).cfloat) *
              cosf(DEG2RAD*(j*360 div slices).cfloat))

      rlVertex3f(
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i)).cfloat) *
              sinf(DEG2RAD*((j+1)*360 div slices).cfloat),
          sinf(DEG2RAD*(270+(180 div (rings + 1))*(i)).cfloat),
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i)).cfloat) *
              cosf(DEG2RAD*((j+1)*360 div slices).cfloat))

      rlVertex3f(
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat) *
              sinf(DEG2RAD*((j+1)*360 div slices).cfloat),
          sinf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat),
          cosf(DEG2RAD*(270+(180 div (rings + 1))*(i+1)).cfloat) *
              cosf(DEG2RAD*((j+1)*360 div slices).cfloat))
  rlEnd()
