import raylib
import raylib/raymath

# use `-lm`

proc fminf(x: cfloat, y: cfloat): cfloat {.
  importc: "fminf", header: "<math.h>".}
proc fmaxf(x: cfloat, y: cfloat): cfloat {.
  importc: "fmaxf", header: "<math.h>".}

const
  G = 400
  PLAYER_JUMP_SPD = 350.0
  PLAYER_HOR_SPD = 200.0
  screenWidth = 800
  screenHeight = 450

type
  Player = object
    position: Vector2
    speed: cfloat
    canJump: bool
  PPlayer = ptr Player
  EnvItem = object
    rect: Rectangle
    blocking: bool
    color: Color
  PEnvItems = ptr array[5, EnvItem]
  PCamera2D = ptr Camera2D
  UpdatersProc = proc(camera: PCamera2D, player: PPlayer,
      envItems: PEnvItems, envItemsLength: int, delta: float, width: int,
      height: int)


proc UpdatePlayer(player: PPlayer, envItems: PEnvItems, envItemsLength: int,
    delta: float)
proc UpdateCameraCenter(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int)
proc UpdateCameraCenterInsideMap(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int)
proc UpdateCameraCenterSmoothFollow(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int)
proc UpdateCameraEvenOutOnLanding(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int)
proc UpdateCameraPlayerBoundsPush(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int)


InitWindow(screenWidth, screenHeight, "raylib [core] example - 2d camera")

var
  player = Player(
      position: Vector2(x: 400, y: 280),
      speed: 0,
      canJump: false)
  envItems = [
      EnvItem(rect: Rectangle(x: 0, y: 0, width: 1000, height: 400),
          blocking: false, color: LIGHTGRAY),
      EnvItem(rect: Rectangle(x: 0, y: 400, width: 1000, height: 200),
          blocking: true, color: GRAY),
      EnvItem(rect: Rectangle(x: 300, y: 200, width: 400, height: 10),
          blocking: true, color: GRAY),
      EnvItem(rect: Rectangle(x: 250, y: 300, width: 100, height: 10),
          blocking: true, color: GRAY),
      EnvItem(rect: Rectangle(x: 650, y: 300, width: 100, height: 10),
          blocking: true, color: GRAY)]
  envItemsLength = envItems.len.cint
  camera = Camera2d(
      offset: Vector2(x: screenWidth/2, y: screenHeight/2),
      target: player.position,
      rotation: 0.0,
      zoom: 1.0)
  cameraUpdaters = [
      UpdateCameraCenter.UpdatersProc,
      UpdateCameraCenterInsideMap,
      UpdateCameraCenterSmoothFollow,
      UpdateCameraEvenOutOnLanding,
      UpdateCameraPlayerBoundsPush]
  cameraOption = 0.cint
  cameraUpdatersLength = cameraUpdaters.len
  cameraDescriptions = [
      "Follow player center".cstring,
      "Follow player center, but clamp to map edges",
      "Follow player center; smoothed",
      "Follow player center horizontally; updateplayer center vertically after landing",
      "Player push camera on getting too close to screen edge"]

SetTargetFPS(60)

while not WindowShouldClose():
  var deltaTime = GetFrameTime().cfloat
  UpdatePlayer(player.addr, envItems.addr, envItemsLength, deltaTime)
  camera.zoom += GetMouseWheelMove().cfloat * 0.05

  if camera.zoom > 3.0:
    camera.zoom = 3.0
  elif camera.zoom < 0.25:
    camera.zoom = 0.25

  if IsKeyPressed(KEY_R):
    camera.zoom = 1.0
    player.position = Vector2(x: 400, y: 280)

  if IsKeyPressed(KEY_C):
    cameraOption = ((cameraOption + 1) mod cameraUpdatersLength).cint

  cameraUpdaters[cameraOption](camera.addr, player.addr, envItems.addr,
      envItemsLength, deltaTime, screenWidth, screenHeight)

  BeginDrawing()
  ClearBackground(LIGHTGRAY)

  BeginMode2D(camera)
  for i in 0..<envItemsLength:
    DrawRectangleRec(envItems[i].rect, envItems[i].color)
  DrawRectangleRec(
      Rectangle(
          x: player.position.x - 20, y: player.position.y - 40,
          width: 40, height: 40),
      RED)
  EndMode2D()

  DrawText("Controls:", 20, 20, 10, BLACK)
  DrawText("- Right/Left to move", 40, 40, 10, DARKGRAY)
  DrawText("- Space to jump", 40, 60, 10, DARKGRAY)
  DrawText("- Mouse Wheel to Zoom in-out, R to reset zoom", 40, 80, 10, DARKGRAY)
  DrawText("- C to change camera mode", 40, 100, 10, DARKGRAY)
  DrawText("Current camera mode:", 20, 120, 10, BLACK)
  DrawText(cameraDescriptions[cameraOption], 40, 140, 10, DARKGRAY)

  EndDrawing()
CloseWindow()

proc UpdatePlayer(player: PPlayer, envItems: PEnvItems, envItemsLength: int,
    delta: float) =

  if IsKeyDown(KEY_LEFT):
    player.position.x -= PLAYER_HOR_SPD*delta
  if IsKeyDown(KEY_RIGHT):
    player.position.x += PLAYER_HOR_SPD*delta
  if IsKeyDown(KEY_SPACE) and player.canJump:
    player.speed = -PLAYER_JUMP_SPD
    player.canJump = false

  var hitObstacle = false
  for i in 0..<envItemsLength:
    let ei = envItems[i].addr
    var p = player.position.addr
    if ei.blocking and ei.rect.x <= p.x and
        ei.rect.x + ei.rect.width >= p.x and
        ei.rect.y >= p.y and ei.rect.y < p.y + player.speed*delta:
      hitObstacle = true
      player.speed = 0.0
      p.y = ei.rect.y
  if not hitObstacle:
    player.position.y += player.speed*delta
    player.speed += G*delta
    player.canJump = false
  else:
    player.canJump = true

proc UpdateCameraCenter(camera: ptr Camera2D, player: ptr Player,
    envItems: ptr array[5, EnvItem], envItemsLength: int, delta: float,
    width: int, height: int) =

  camera.offset = Vector2(x: width/2, y: height/2)
  camera.target = player.position

proc UpdateCameraCenterInsideMap(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int) =

  camera.target = player.position
  camera.offset = Vector2(x: width/2, y: height/2)
  var
    minX = 1000.0
    minY = 1000.0
    maxX = -1000.0
    maxY = -1000.0
  for i in 0..<envItemsLength:
    let ei = envItems[i].addr
    minX = fminf(ei.rect.x, minX)
    maxX = fmaxf(ei.rect.x + ei.rect.width, maxX)
    minY = fminf(ei.rect.y, minY)
    maxY = fmaxf(ei.rect.y + ei.rect.height, maxY)
  var
    maxv = GetWorldToScreen2D(Vector2(x: maxX, y: maxY), camera[])
    minv = GetWorldToScreen2D(Vector2(x: minX, y: minY), camera[])
  if maxv.x < width.cfloat:
    camera.offset.x = width.cfloat - (maxv.x - width/2)
  if maxv.y < height.cfloat:
    camera.offset.y = height.cfloat - (maxv.y - height/2)
  if minv.x > 0:
    camera.offset.x = width/2 - minv.x
  if minv.y > 0:
    camera.offset.y = height/2 - minv.y

proc UpdateCameraCenterSmoothFollow(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int) =

  var minSpeed {.global.} = 30.cfloat
  var minEffectLength {.global.} = 10.cfloat
  var fractionSpeed {.global.} = 0.8.cfloat
  camera.offset = Vector2(x: width/2, y: height/2)
  var diff = Vector2Subtract(player.position, camera.target)
  var length = Vector2Length(diff)
  if length > minEffectLength.cfloat:
    let speed = fmaxf(fractionSpeed*length, minSpeed)
    camera.target = Vector2Add(camera.target, Vector2Scale(diff,
        speed*delta/length))

proc UpdateCameraEvenOutOnLanding(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int) =

  var evenOutSpeed {.global.} = 700.cfloat
  var eveningOut {.global.} = false
  var evenOutTarget {.global.}: float

  camera.offset = Vector2(x: width/2, y: height/2)
  camera.target.x = player.position.x
  if eveningOut:
    if evenOutTarget > camera.target.y:
      camera.target.y += evenOutSpeed*delta
      if camera.target.y > evenOutTarget:
        camera.target.y = evenOutTarget
        eveningOut = false
    else:
      camera.target.y -= evenOutSpeed*delta
      if camera.target.y < evenOutTarget:
        camera.target.y = evenOutTarget
        eveningOut = false
  else:
    if player.canJump and (player.speed == 0) and
        (player.position.y != camera.target.y):
      eveningOut = true
      evenOutTarget = player.position.y

proc UpdateCameraPlayerBoundsPush(camera: PCamera2D, player: PPlayer,
    envItems: PEnvItems, envItemsLength: int, delta: float, width: int, height: int) =

  var bbox {.global.} = Vector2(x: 0.2, y: 0.2)

  var bboxWorldMin = GetScreenToWorld2D(Vector2(x: (1 - bbox.x)*0.5*width.float,
      y: (1 - bbox.y)*0.5*height.float), camera[])
  var bboxWorldMax = GetScreenToWorld2D(Vector2(x: (1 + bbox.x)*0.5*width.float,
      y: (1 + bbox.y)*0.5*height.float), camera[])
  camera.offset = Vector2(x: (1 - bbox.x)*0.5 * width.float,
      y: (1 - bbox.y)*0.5*height.float)
  if player.position.x < bboxWorldMin.x:
    camera.target.x = player.position.x
  if player.position.y < bboxWorldMin.y:
    camera.target.y = player.position.y
  if player.position.x > bboxWorldMax.x:
    camera.target.x = bboxWorldMin.x + (player.position.x - bboxWorldMax.x)
  if player.position.y > bboxWorldMax.y:
    camera.target.y = bboxWorldMin.y + (player.position.y - bboxWorldMax.y)
