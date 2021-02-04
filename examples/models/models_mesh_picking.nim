import raylib
import raylib/raymath

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

const
  FLT_MAX = 340282346638528859811704183484516925440.0
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [models] example - mesh picking")

var
  camera = Camera(
    position: Vector3(x: 20.0, y: 20.0, z: 20.0),
    target: Vector3(x: 0.0, y: 8.0, z: 0.0),
    up: Vector3(x: 0.0, y: 1.6, z: 0.0),
    fovy: 45.0,
    type: CAMERA_PERSPECTIVE)
  ray: Ray
  tower = LoadModel("resources/models/turret.obj")
  texture = LoadTexture("resources/models/turret_diffuse.png")
  towerPos: Vector3
  hitMeshBBox = false
  hitTriangle = false
  ta = Vector3(x: -25.0, y: 0.5, z: 0.0)
  tb = Vector3(x: -4.0, y: 2.5, z: 1.0)
  tc = Vector3(x: -8.0, y: 6.5, z: 0.0)
  bary = Vector3(x: 0.0, y: 0.0, z: 0.0)
  towerBBox = MeshBoundingBox(tower.meshes[0])

tower.materials[0].maps[MAP_DIFFUSE].texture = texture

SetCameraMode(camera, CAMERA_FREE)

SetTargetFPS(60)

while not WindowShouldClose():
  UpdateCamera(camera.addr)

  var nearestHit: RayHitInfo
  var hitObjectName = "None"
  var cursorColor = WHITE

  nearestHit.distance = FLT_MAX
  nearestHit.hit = false

  ray = GetMouseRay(GetMousePosition(), camera)

  var groundHitInfo = GetCollisionRayGround(ray, 0.0)

  if groundHitInfo.hit and groundHitInfo.distance < nearestHit.distance:
    nearestHit = groundHitInfo
    cursorColor = GREEN
    hitObjectName = "Ground"

  var triHitInfo = GetCollisionRayTriangle(ray, ta, tb, tc)

  if triHitInfo.hit and triHitInfo.distance < nearestHit.distance:
    nearestHit = triHitInfo
    cursorColor = PURPLE
    hitObjectName = "Triangle"
    bary = Vector3Barycenter(nearestHit.position, ta, tb, tc)
    hitTriangle = true
  else:
    hitTriangle = false

  var meshHitInfo: RayHitInfo

  if CheckCollisionRayBox(ray, towerBBox):
    hitMeshBBox = true
    meshHitInfo = GetCollisionRayModel(ray, tower)
    if meshHitInfo.hit and meshHitInfo.distance < nearestHit.distance:
      nearestHit = meshHitInfo
      cursorColor = ORANGE
      hitObjectName = "Mesh"
  hitMeshBBox = false

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode3D(camera)
  DrawModel(tower, towerPos, 1.0, WHITE)
  DrawLine3D(ta, tb, PURPLE)
  DrawLine3D(tb, tc, PURPLE)
  DrawLine3D(tc, ta, PURPLE)

  if hitMeshBBox:
    DrawBoundingBox(towerBBox, LIME)
  if nearestHit.hit:
    DrawCube(nearestHit.position, 0.3, 0.3, 0.3, cursorColor)
    DrawCubeWires(nearestHit.position, 0.3, 0.3, 0.3, RED)
    var normalEnd = Vector3(
        x: nearestHit.position.x + nearestHit.normal.x,
        y: nearestHit.position.y + nearestHit.normal.y,
        z: nearestHit.position.z + nearestHit.normal.z)
    DrawLine3D(nearestHit.position, normalEnd, RED)

  DrawRay(ray, MAROON)
  DrawGrid(10, 10.0)
  EndMode3D()

  DrawText(FormatText("Hit Object: %s", hitObjectName), 10, 50, 10, BLACK)
  if nearestHit.hit:
    var ypos = 70.cint
    DrawText(FormatText("Distance: %3.2f", nearestHit.distance), 10, ypos, 10, BLACK)
    DrawText(FormatText("Hit Pos: %3.2f %3.2f %3.2f",
        nearestHit.position.x,
        nearestHit.position.y,
        nearestHit.position.z), 10, ypos + 15, 10, BLACK)
    DrawText(FormatText("Hit Norm: %3.2f %3.2f %3.2f",
        nearestHit.normal.x,
        nearestHit.normal.y,
        nearestHit.normal.z), 10, ypos + 30, 10, BLACK)
    if hitTriangle:
      DrawText(FormatText("Barycenter: %3.2f %3.2f %3.2f",
          bary.x, bary.y, bary.z), 10, ypos + 45, 10, BLACK)
  DrawText("Use Mouse to Move Camera", 10, 430, 10, GRAY)
  DrawText("(c) Turret 3D model by Alberto Cano",
      screenWidth - 200, screenHeight - 20, 10, GRAY)
  DrawFPS(10, 10)

  EndDrawing()

UnloadModel(tower)
UnloadTexture(texture)
CloseWindow()
