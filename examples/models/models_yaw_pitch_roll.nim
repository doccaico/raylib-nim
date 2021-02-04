import raylib
import raylib/raymath

{.passL: "-lm".}

proc DrawAngleGauge(angleGauge: Texture2D , x: cint, y: cint, angle: cfloat,
    title: cstring, color: Color)

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight,
    "raylib [models] example - plane rotations (yaw, pitch, roll)")

var
  texAngleGauge = LoadTexture("resources/angle_gauge.png")
  texBackground = LoadTexture("resources/background.png")
  texPitch = LoadTexture("resources/pitch.png")
  texPlane = LoadTexture("resources/plane.png")
  framebuffer = LoadRenderTexture(192, 192)
  model = LoadModel("resources/plane.obj")
  camera = Camera(
      position: Vector3(x: 0.0, y: 60.0, z: -120.0),
      target: Vector3(x: 0.0, y: 12.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 30.0,
      type: CAMERA_PERSPECTIVE)
  pitch = 0.0.cfloat
  roll = 0.0.cfloat
  yaw = 0.0.cfloat

model.materials[0].maps[MAP_DIFFUSE].texture = LoadTexture("resources/plane_diffuse.png")

GenTextureMipmaps(model.materials[0].maps[MAP_DIFFUSE].texture.addr)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyDown(KEY_LEFT): roll += 1.0
  elif IsKeyDown(KEY_RIGHT): roll -= 1.0
  else:
    if roll > 0.0: roll -= 0.5
    elif roll < 0.0: roll += 0.5

  if IsKeyDown(KEY_S): yaw += 1.0
  elif IsKeyDown(KEY_A): yaw -= 1.0
  else:
    if yaw > 0.0: yaw -= 0.5
    elif yaw < 0.0: yaw += 0.5

  if IsKeyDown(KEY_DOWN): pitch += 0.6
  elif IsKeyDown(KEY_UP): pitch -= 0.6
  else:
    if pitch > 0.3: pitch -= 0.3
    elif pitch < -0.3: pitch += 0.3

  var pitchOffset = pitch
  while pitchOffset > 180: pitchOffset -= 360
  while pitchOffset < -180: pitchOffset += 360
  pitchOffset *= 10
  model.transform = MatrixRotateXYZ(
      Vector3(x: DEG2RAD*pitch, y: DEG2RAD*yaw, z: DEG2RAD*roll))

  BeginDrawing()
  ClearBackground(RAYWHITE)

  var centerX: cint = framebuffer.texture.width div 2
  var centerY: cint = framebuffer.texture.height div 2
  var scaleFactor = 0.5.cfloat

  BeginTextureMode(framebuffer)
  BeginBlendMode(BLEND_ALPHA)

  DrawTexturePro(texBackground,
      Rectangle(x: 0.0, y: 0.0, width: texBackground.width.cfloat,
          height: texBackground.height.cfloat),
      Rectangle(x: centerX.cfloat, y: centerY.cfloat,
          width: texBackground.width.cfloat*scaleFactor,
          height: texBackground.height.cfloat*scaleFactor),
      Vector2(x: texBackground.width/2*scaleFactor,
          y: texBackground.height/2*scaleFactor + pitchOffset*scaleFactor), roll, WHITE)
  DrawTexturePro(texPitch,
      Rectangle(x: 0.0, y: 0.0, width: texPitch.width.cfloat,
          height: texPitch.height.cfloat),
      Rectangle(x: centerX.cfloat, y: centerY.cfloat,
          width: texPitch.width.cfloat*scaleFactor,
          height: texPitch.height.cfloat*scaleFactor),
      Vector2(x: texPitch.width/2*scaleFactor,
          y: texPitch.height/2*scaleFactor + pitchOffset*scaleFactor), roll, WHITE)
  DrawTexturePro(texPlane,
      Rectangle(x: 0.0, y: 0.0, width: texPlane.width.cfloat,
          height: texPlane.height.cfloat),
      Rectangle(x: centerX.cfloat, y: centerY.cfloat,
          width: texPlane.width.cfloat*scaleFactor,
          height: texPlane.height.cfloat*scaleFactor),
      Vector2(x: texPlane.width/2*scaleFactor,
          y: texPlane.height/2*scaleFactor), 0, WHITE)

  EndBlendMode()
  EndTextureMode()

  BeginMode3D(camera)
  DrawModel(model, Vector3(x: 0.0, y: 6.0, z: 0.0), 1.0, WHITE)
  DrawGrid(10, 10.0)
  EndMode3D()

  DrawAngleGauge(texAngleGauge, 80, 70, roll, "roll", RED)
  DrawAngleGauge(texAngleGauge, 190, 70, pitch, "pitch", GREEN)
  DrawAngleGauge(texAngleGauge, 300, 70, yaw, "yaw", SKYBLUE)

  DrawRectangle(30, 360, 260, 70, Fade(SKYBLUE, 0.5))
  DrawRectangleLines(30, 360, 260, 70, Fade(DARKBLUE, 0.5))
  DrawText("Pitch controlled with: KEY_UP / KEY_DOWN", 40, 370, 10, DARKGRAY)
  DrawText("Roll controlled with: KEY_LEFT / KEY_RIGHT", 40, 390, 10, DARKGRAY)
  DrawText("Yaw controlled with: KEY_A / KEY_S", 40, 410, 10, DARKGRAY)

  DrawTextureRec(framebuffer.texture,
      Rectangle(x: 0.0, y: 0.0, width: framebuffer.texture.width.cfloat,
          height: -framebuffer.texture.height.cfloat),
      Vector2(x: (screenWidth - framebuffer.texture.width - 20).cfloat, y: 20.0),
          Fade(WHITE, 0.8))
  DrawRectangleLines(screenWidth - framebuffer.texture.width - 20, 20,
      framebuffer.texture.width, framebuffer.texture.height, DARKGRAY)

  EndDrawing()

UnloadTexture(model.materials[0].maps[MAP_DIFFUSE].texture)
UnloadModel(model)
UnloadRenderTexture(framebuffer)
UnloadTexture(texAngleGauge)
UnloadTexture(texBackground)
UnloadTexture(texPitch)
UnloadTexture(texPlane)
CloseWindow()

proc DrawAngleGauge(angleGauge: Texture2D , x: cint, y: cint, angle: cfloat,
    title: cstring, color: Color) =

  var srcRec = Rectangle(x: 0.0, y: 0.0,
      width: angleGauge.width.cfloat, height: angleGauge.height.cfloat)
  var dstRec = Rectangle(x: x.cfloat, y: y.cfloat,
      width: angleGauge.width.cfloat, height: angleGauge.height.cfloat)
  var origin = Vector2(x: angleGauge.width/2, y: angleGauge.height/2)
  var textSize = 20.cint

  DrawTexturePro(angleGauge, srcRec, dstRec, origin, angle, color)

  DrawText(FormatText("%5.1f", angle), x - MeasureText(FormatText("%5.1f", angle),
      textSize) div 2, y + 10, textSize, DARKGRAY)
  DrawText(title, x - MeasureText(title, textSize) div 2, y + 60, textSize, DARKGRAY)
