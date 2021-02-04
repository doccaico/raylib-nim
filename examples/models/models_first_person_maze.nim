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

InitWindow(screenWidth, screenHeight, "raylib [models] example - first person maze")

var
  camera = Camera(
      position: Vector3(x: 0.2, y: 0.4, z: 0.2),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: 0)
  imMap = LoadImage("resources/cubicmap.png")
  cubicmap = LoadTextureFromImage(imMap)
  mesh = GenMeshCubicmap(imMap, Vector3(x: 1.0, y: 1.0, z: 1.0))
  model = LoadModelFromMesh(mesh)
  texture = LoadTexture("resources/cubicmap_atlas.png")
  mapPixels = GetImageData(imMap)
  mapPosition = Vector3(x: -16.0, y: 0.0, z: -8.0)
  playerPosition = camera.position

model.materials[0].maps[MAP_DIFFUSE].texture = texture

UnloadImage(imMap)

SetCameraMode(camera, CAMERA_FIRST_PERSON)

SetTargetFPS(60)

while not WindowShouldClose():
  var oldCamPos = camera.position

  UpdateCamera(camera.addr)

  var playerPos = Vector2(x: camera.position.x, y: camera.position.z)
  var playerRadius = 0.1

  var playerCellX = cint(playerPos.x - mapPosition.x + 0.5)
  var playerCellY = cint(playerPos.y - mapPosition.z + 0.5)

  if playerCellX < 0: playerCellX = 0
  elif playerCellX >= cubicmap.width: playerCellX = cubicmap.width - 1

  if playerCellY < 0: playerCellY = 0
  elif playerCellY >= cubicmap.height: playerCellY = cubicmap.height - 1

  for y in 0..<cubicmap.height:
    for x in 0..<cubicmap.width:
      if mapPixels[y*cubicmap.width + x].r == 255.cuchar and
          CheckCollisionCircleRec(
                playerPos,
                playerRadius,
                Rectangle(
                    x: mapPosition.x - 0.5 + x.float*1.0,
                    y: mapPosition.z - 0.5 + y.float*1.0,
                    width: 1.0,
                    height: 1.0)):
        camera.position = oldCamPos

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(model, mapPosition, 1.0, WHITE)
  DrawCubeV(playerPosition, Vector3(x: 0.2, y: 0.4, z: 0.2), RED)
  EndMode3D()

  DrawTextureEx(cubicmap,
      Vector2(x: (GetScreenWidth() - cubicmap.width*4 - 20).cfloat, y: 20.0),
      0.0, 4.0, WHITE)
  DrawRectangleLines(GetScreenWidth() - cubicmap.width*4 - 20, 20,
      cubicmap.width*4, cubicmap.height*4, GREEN)

  DrawRectangle(GetScreenWidth() - cubicmap.width*4 - 20 + playerCellX*4,
      20 + playerCellY*4, 4, 4, RED)
  DrawFPS(10, 10)

  EndDrawing()

free(mapPixels)
UnloadTexture(cubicmap)
UnloadTexture(texture)
UnloadModel(model)
CloseWindow()
