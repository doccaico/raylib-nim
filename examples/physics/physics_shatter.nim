import raylib
{.define: PHYSAC_NO_THREADS.}
import raylib/physac

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)
InitWindow(screenWidth, screenHeight, "Physac [raylib] - Body shatter")

var logoX = (screenWidth - MeasureText("Physac", 30) - 10).cint
var logoY: cint = 15
var needsReset = false

InitPhysics()
SetPhysicsGravity(0, 0)

discard CreatePhysicsBodyPolygon(
    Vector2(x: screenWidth/2, y: screenHeight/2), GetRandomValue(80, 200).cfloat,
    GetRandomValue(3, 8), 10)

SetTargetFPS(60)

while not WindowShouldClose():
  RunPhysicsStep()

  if needsReset:
    discard CreatePhysicsBodyPolygon(
        Vector2(x: screenWidth/2, y: screenHeight/2), GetRandomValue(80, 200).cfloat,
        GetRandomValue(3, 8), 10)
    needsReset = false

  if IsKeyPressed(KEY_R):
    ResetPhysics()
    needsReset = true

  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    var count = GetPhysicsBodiesCount()
    var i = count - 1
    while i >= 0:
      var currentBody = GetPhysicsBody(i)
      if currentBody != nil:
        PhysicsShatter(currentBody, GetMousePosition(), 10/currentBody.inverseMass)
      dec i

  BeginDrawing()
  ClearBackground(BLACK)

  var bodiesCount = GetPhysicsBodiesCount()
  for i in 0..<bodiesCount:
    var currentBody = GetPhysicsBody(i)
    var vertexCount = GetPhysicsShapeVerticesCount(i)
    for j in 0..<vertexCount:
      var vertexA = GetPhysicsShapeVertex(currentBody, j)
      var jj = if (j + 1) < vertexCount: (j + 1) else: 0
      var vertexB = GetPhysicsShapeVertex(currentBody, jj)
      DrawLineV(vertexA, vertexB, GREEN)

  DrawText("Left mouse button in polygon area to shatter body\nPress 'R' to reset example",
      10, 10, 10, WHITE)

  DrawText("Physac", logoX, logoY, 30, WHITE)
  DrawText("Powered by", logoX + 50, logoY - 7, 10, WHITE)

  EndDrawing()

ClosePhysics()
CloseWindow()
