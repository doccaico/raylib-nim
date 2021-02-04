import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - box collisions")

var
  camera = Camera(
      position: Vector3(x: 0.0, y: 10.0, z: 10.0),
      target: Vector3(x: 0.0, y: 0.0, z: 0.0),
      up: Vector3(x: 0.0, y: 1.0, z: 0.0),
      fovy: 45.0,
      type: 0)
  playerPosition = Vector3(x: 0.0, y: 1.0, z: 2.0)
  playerSize = Vector3(x: 1.0, y: 2.0, z: 1.0)
  enemyBoxPos = Vector3(x: -4.0, y: 1.0, z: 0.0)
  enemyBoxSize = Vector3(x: 2.0, y: 2.0, z: 2.0)
  enemySpherePos = Vector3(x: 4.0, y: 0.0, z: 0.0)
  enemySphereSize = 1.5
  collision = false
  playerColor = GREEN

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyDown(KEY_RIGHT): playerPosition.x += 0.2
  elif IsKeyDown(KEY_LEFT): playerPosition.x -= 0.2
  elif IsKeyDown(KEY_DOWN): playerPosition.z += 0.2
  elif IsKeyDown(KEY_UP): playerPosition.z -= 0.2

  collision = false

  if CheckCollisionBoxes(
      BoundingBox(
          min: Vector3(x: playerPosition.x - playerSize.x/2,
              y: playerPosition.y - playerSize.y/2,
              z: playerPosition.z - playerSize.z/2),
          max: Vector3(x: playerPosition.x + playerSize.x/2,
              y: playerPosition.y + playerSize.y/2,
              z: playerPosition.z + playerSize.z/2)),
      BoundingBox(
          min: Vector3(x: enemyBoxPos.x - enemyBoxSize.x/2,
              y: enemyBoxPos.y - enemyBoxSize.y/2,
              z: enemyBoxPos.z - enemyBoxSize.z/2),
          max: Vector3(x: enemyBoxPos.x + enemyBoxSize.x/2,
              y: enemyBoxPos.y + enemyBoxSize.y/2,
              z: enemyBoxPos.z + enemyBoxSize.z/2))):
    collision = true

  if CheckCollisionBoxSphere(
      BoundingBox(
          min: Vector3(x: playerPosition.x - playerSize.x/2,
              y: playerPosition.y - playerSize.y/2,
              z: playerPosition.z - playerSize.z/2),
          max: Vector3(x: playerPosition.x + playerSize.x/2,
              y: playerPosition.y + playerSize.y/2,
              z: playerPosition.z + playerSize.z/2)),
      enemySpherePos,
      enemySphereSize):
    collision = true

  if collision: playerColor = RED
  else: playerColor = GREEN

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawCube(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, GRAY)
  DrawCubeWires(enemyBoxPos, enemyBoxSize.x, enemyBoxSize.y, enemyBoxSize.z, DARKGRAY)

  DrawSphere(enemySpherePos, enemySphereSize, GRAY)
  DrawSphereWires(enemySpherePos, enemySphereSize, 16, 16, DARKGRAY)

  DrawCubeV(playerPosition, playerSize, playerColor)
  DrawGrid(10, 1.0)
  EndMode3D()

  DrawText("Move player with cursors to collide", 220, 40, 20, GRAY)
  DrawFPS(10, 10)

  EndDrawing()

CloseWindow()
