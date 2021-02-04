import raylib

proc free(p: pointer) {.
  importc, header: "<stdlib.h>".}

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - model animation")

var
  camera = Camera(
      position: Vector3(x: 10.0, y: 10.0, z: 10.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: CAMERA_PERSPECTIVE)
  model = LoadModel("resources/guy/guy.iqm")
  texture = LoadTexture("resources/guy/guytex.png")
  position = Vector3(x: 0.0, y: 0.0, z: 0.0)
  animsCount = 0.cint
  animFrameCounter = 0.cint

SetMaterialTexture(cast[ptr Material](model.materials), MAP_DIFFUSE, texture)

var anims = LoadModelAnimations("resources/guy/guyanim.iqm", animsCount.addr)

SetCameraMode(camera, CAMERA_FREE)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  if IsKeyDown(KEY_SPACE):
    inc animFrameCounter
    UpdateModelAnimation(model, anims[0], animFrameCounter)
    if animFrameCounter >= anims[0].frameCount: animFrameCounter = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModelEx(model, position,
      Vector3(x: 1.0, y: 0.0, z: 0.0), -90.0, Vector3(x: 1.0, y: 1.0, z: 1.0), WHITE)
  for i in 0..<model.boneCount:
    DrawCube(anims[0].framePoses[animFrameCounter][i].translation, 0.2, 0.2, 0.2, RED)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON)
  DrawText("(c) Guy IQM 3D model by @culacant",
      screenWidth - 200, screenHeight - 20, 10, GRAY)
  EndDrawing()

UnloadTexture(texture)
for i in 0..<animsCount:
  UnloadModelAnimation(anims[i])
free(anims)
UnloadModel(model)
CloseWindow()
