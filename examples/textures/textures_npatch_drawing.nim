import raylib

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - N-patch drawing")

var
  nPatchTexture = LoadTexture("resources/ninepatch_button.png")
  mousePosition: Vector2
  origin: Vector2
  dstRec1 = Rectangle(x: 480.0, y: 160.0, width: 32.0, height: 32.0)
  dstRec2 = Rectangle(x: 160.0, y: 160.0, width: 32.0, height: 32.0)
  dstRecH = Rectangle(x: 160.0, y: 93.0, width: 32.0, height: 32.0)
  dstRecV = Rectangle(x: 92.0, y: 160.0, width: 32.0, height: 32.0)
  ninePatchInfo1 = NPatchInfo(
      sourceRec: Rectangle(x: 0.0, y: 0.0, width: 64.0, height: 64.0),
      left: 12,
      top: 40,
      right: 12,
      bottom: 12,
      `type`: NPT_9PATCH)
  ninePatchInfo2 = NPatchInfo(
      sourceRec: Rectangle(x: 0.0, y: 128.0, width: 64.0, height: 64.0),
      left: 16,
      top: 16,
      right: 16,
      bottom: 16,
      `type`: NPT_9PATCH)
  h3PatchInfo = NPatchInfo(
      sourceRec: Rectangle(x: 0.0, y: 64.0, width: 64.0, height: 64.0),
      left: 8,
      top: 8,
      right: 8,
      bottom: 8,
      `type`: NPT_3PATCH_HORIZONTAL)
  v3PatchInfo = NPatchInfo(
      sourceRec: Rectangle(x: 0.0, y: 192.0, width: 64.0, height: 64.0),
      left: 6,
      top: 6,
      right: 6,
      bottom: 6,
      `type`: NPT_3PATCH_VERTICAL)

SetTargetFPS(60)

while not WindowShouldClose():
  mousePosition = GetMousePosition()

  dstRec1.width = mousePosition.x - dstRec1.x
  dstRec1.height = mousePosition.y - dstRec1.y
  dstRec2.width = mousePosition.x - dstRec2.x
  dstRec2.height = mousePosition.y - dstRec2.y
  dstRecH.width = mousePosition.x - dstRecH.x
  dstRecV.height = mousePosition.y - dstRecV.y

  if dstRec1.width < 1.0: dstRec1.width = 1.0
  if dstRec1.width > 300.0: dstRec1.width = 300.0
  if dstRec1.height < 1.0: dstRec1.height = 1.0
  if dstRec2.width < 1.0: dstRec2.width = 1.0
  if dstRec2.width > 300.0: dstRec2.width = 300.0
  if dstRec2.height < 1.0: dstRec2.height = 1.0
  if dstRecH.width < 1.0: dstRecH.width = 1.0
  if dstRecV.height < 1.0: dstRecV.height = 1.0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawTextureNPatch(nPatchTexture, ninePatchInfo2, dstRec2, origin, 0.0, WHITE)
  DrawTextureNPatch(nPatchTexture, ninePatchInfo1, dstRec1, origin, 0.0, WHITE)
  DrawTextureNPatch(nPatchTexture, h3PatchInfo, dstRecH, origin, 0.0, WHITE)
  DrawTextureNPatch(nPatchTexture, v3PatchInfo, dstRecV, origin, 0.0, WHITE)

  DrawRectangleLines(5, 88, 74, 266, BLUE)
  DrawTexture(nPatchTexture, 10, 93, WHITE)
  DrawText("TEXTURE", 15, 360, 10, DARKGRAY)

  DrawText("Move the mouse to stretch or shrink the n-patches", 10, 20, 20, DARKGRAY)
  EndDrawing()

UnloadTexture(nPatchTexture)
CloseWindow()
