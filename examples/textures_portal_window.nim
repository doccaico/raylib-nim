import std / [math]

import raylib
import raymath
import rlgl

proc BeginPortalMode3D(eye: Vector3 , bottomLeft: Vector3 , bottomRight: Vector3 , topLeft: Vector3 , nearPlane: float32, farPlane: float32)
proc EndPortalMode3D()

const
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - portal window")

# Camera to navigate the "real world" (Dimension A)
var camera = Camera3D(
  position: Vector3(x: 0.0, y: 2.5, z: 7.0),
  target: Vector3(x: 0.0, y: 1.8, z: 0.0),
  up: Vector3(x: 0.0, y: 1.0, z: 0.0),
  fovy: 45.0,
  projection: CAMERA_PERSPECTIVE.int32)

# The archway opening, in Dimension A world space (used both to draw the frame and
# as the window rectangle the oblique projection is built from)
var archBottomLeft = Vector3(x: -1.5, y: 0.0, z: 0.0)
var archBottomRight = Vector3(x: 1.5, y: 0.0, z: 0.0)
var archTopLeft = Vector3(x: -1.5, y: 4.0, z: 0.0)

# The archway sits at portalA and looks out onto portalB, far away in world space.
# Every frame, Dimension B gets rendered to a texture using the same relative eye
# and window position, shifted by the offset between the two portals
var portalA = Vector3(x: 0.0, y: 0.0, z: 0.0)
var portalB = Vector3(x: 0.0, y: 0.0, z: -60.0)
var portalView = LoadRenderTexture(480, 640)

DisableCursor() # Lock cursor for first-person free camera controls
SetTargetFPS(60)

while not WindowShouldClose():

  UpdateCamera(camera.addr, CAMERA_FREE.int32)
  var time = GetTime()

  # Eye and window corners, shifted into Dimension B so they match the player's
  # actual position and viewing angle relative to the archway
  let offset = Vector3Subtract(portalB, portalA)
  let eyeInB = Vector3Add(camera.position, offset)
  let blInB = Vector3Add(archBottomLeft, offset)
  let brInB = Vector3Add(archBottomRight, offset)
  let tlInB = Vector3Add(archTopLeft, offset)

  # Render Dimension B into an offscreen texture, using an oblique projection so
  # its perspective lines up with the archway exactly as the real camera sees it
  BeginTextureMode(portalView)

  ClearBackground(Color(r: 10, g: 5, b: 20, a: 255))

  BeginPortalMode3D(eyeInB, blInB, brInB, tlInB, 0.05, 100.0)

  DrawGrid(30, 0.8)

  # Floating pulsing core sphere
  let corePos = Vector3Add(portalB, Vector3(x: 0.0, y: 2.0 + sin(time * 2.5) * 0.4, z: -4.0))
  DrawSphere(corePos, 1.2, PURPLE);
  DrawSphereWires(corePos, 1.25, 16, 16, MAGENTA);

  # Orbiting cubes
  for i in 0..4:
    let angle = time * 1.5 + i.float * (PI / 2.0)
    let pos = Vector3Add(portalB, Vector3(
      x: sin(angle) * 2.5,
      y: 2.0 + cos(time * 3.0 + i.float) * 0.5,
      z: -4.0 + cos(angle) * 2.5))
    DrawCube(pos, 0.5, 0.5, 0.5, LIME)
    DrawCubeWires(pos, 0.52, 0.52, 0.52, DARKGREEN)

  EndPortalMode3D()

  EndTextureMode()

  BeginDrawing()

  ClearBackground(RAYWHITE)

  BeginMode3D(camera)

  DrawGrid(20, 1.0f);

  # Side pillars
  DrawCube(Vector3(x: -3.5, y: 2.0, z: 0.0), 0.8, 4.0, 0.8, DARKGRAY)
  DrawCubeWires(Vector3(x: -3.5, y: 2.0, z: 0.0), 0.8, 4.0, 0.8, ORANGE)
  DrawCube(Vector3(x: 3.5, y: 2.0, z: 0.0), 0.8, 4.0, 0.8, DARKGRAY)
  DrawCubeWires(Vector3(x: 3.5, y: 2.0, z: 0.0), 0.8, 4.0, 0.8, ORANGE)

  # Golden archway frame and solid base
  DrawCubeWires(Vector3(x: 0.0, y: 2.0, z: 0.0), 3.2, 4.2, 0.2, GOLD)
  DrawCube(Vector3(x: 0.0, y: 0.05, z: 0.0), 3.4, 0.1, 0.6, MAROON)

  # Solid backing wall, only ever seen if looking at the archway from behind
  DrawCube(Vector3(x: 0.0, y: 2.0, z: -0.05), 3.1, 4.1, 0.05, MAROON)

  # The portal opening itself: a plain quad textured with the Dimension B
  # render, filling the archway exactly, so nothing "leaks" outside its shape
  rlSetTexture(portalView.texture.id)

  rlBegin(RL_QUADS)
  rlColor4ub(255, 255, 255, 255)
  rlNormal3f(0.0, 0.0, 1.0)
  rlTexCoord2f(0.0, 0.0); rlVertex3f(archBottomLeft.x, archBottomLeft.y, archBottomLeft.z)
  rlTexCoord2f(1.0, 0.0); rlVertex3f(archBottomRight.x, archBottomRight.y, archBottomRight.z)
  rlTexCoord2f(1.0, 1.0); rlVertex3f(archBottomRight.x, 4.0, archBottomRight.z)
  rlTexCoord2f(0.0, 1.0); rlVertex3f(archTopLeft.x, archTopLeft.y, archTopLeft.z)
  rlEnd()

  rlSetTexture(0)

  EndMode3D()

  # HUD overlay
  DrawRectangle(15, 15, 520, 100, Fade(BLACK, 0.75))
  DrawRectangleLines(15, 15, 520, 100, GOLD)
  DrawText("PORTAL WINDOW", 28, 25, 20, GOLD)
  DrawText("Look through the golden arch into Dimension B", 28, 52, 20, RAYWHITE)
  DrawText("Controls: Mouse to look | WASD to move", 28, 80, 20, GRAY)

  EndDrawing()

CloseWindow()

# Starts a 3D mode using an off-axis ("oblique frustum") projection, built directly from
# an eye point and 3 corners of a rectangular window, instead of a fovy centered straight
# ahead of the camera. This is the standard technique for rendering a scene as seen through
# a window that isn't necessarily faced head-on (also used for multi-monitor and VR
# rendering) - the key difference from a normal Camera3D is that the frustum is allowed
# to be asymmetric, so perspective lines through the window line up correctly from any
# eye position, instead of behaving like a flat image pasted onto the window
proc BeginPortalMode3D(eye: Vector3 , bottomLeft: Vector3 , bottomRight: Vector3 , topLeft: Vector3 , nearPlane: float32, farPlane: float32) =
  let right = Vector3Normalize(Vector3Subtract(bottomRight, bottomLeft))
  let up = Vector3Normalize(Vector3Subtract(topLeft, bottomLeft))
  let normal = Vector3Normalize(Vector3CrossProduct(right, up))

  # Vectors from the eye to 3 corners of the window, used to project the window onto
  # the near plane and read off how far it extends left/right/bottom/top of the eye
  let toBL = Vector3Subtract(bottomLeft, eye)
  let toBR = Vector3Subtract(bottomRight, eye)
  let toTL = Vector3Subtract(topLeft, eye)

  var dist = -Vector3DotProduct(toBL, normal)
  if dist < 0.01f: dist = 0.01 # Keep the eye from crossing the window plane

  let scale = nearPlane/dist

  rlDrawRenderBatchActive()

  rlMatrixMode(RL_PROJECTION.int32)
  rlPushMatrix()
  rlSetMatrixProjection(MatrixFrustum(
      Vector3DotProduct(right, toBL)*scale, Vector3DotProduct(right, toBR)*scale,
      Vector3DotProduct(up, toBL)*scale, Vector3DotProduct(up, toTL)*scale,
      nearPlane, farPlane))

  # View orientation is fixed to the window's own plane (looking straight through it
  # along its normal), NOT aimed at any target - that's what the asymmetric frustum
  # above is for, and is what lets the eye move off to one side without distorting
  rlMatrixMode(RL_MODELVIEW.int32)
  rlLoadIdentity()

  var matFloat = MatrixToFloat(MatrixLookAt(eye, Vector3Subtract(eye, normal), up))
  rlMultMatrixf(cast[ptr float32](matFloat.addr))

  rlEnableDepthTest()

# End portal 3D mode and returns to default 2D orthographic mode
# NOTE: Similar implementation to EndMode3D()
proc EndPortalMode3D() =
  rlDrawRenderBatchActive() # Update and draw internal render batch

  rlMatrixMode(RL_PROJECTION.int32) # Switch to projection matrix
  rlPopMatrix() # Restore previous matrix (projection) from matrix stack

  rlMatrixMode(RL_MODELVIEW.int32) # Switch back to modelview matrix
  rlLoadIdentity() # Reset current matrix (modelview)

  rlDisableDepthTest() # Disable DEPTH_TEST for 2D
