import raylib
{.define: PHYSAC_NO_THREADS.}
import raylib/physac

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight, "Physac [raylib] - Physics demo")

var
  logoX = (screenWidth - MeasureText("Physac", 30) - 10).cint
  logoY = 15.cint
  needsReset = false

InitPhysics()

var floor = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth/2, y: screenHeight.cfloat), 500, 100, 10)
floor.enabled = false

var circle = CreatePhysicsBodyCircle(
    Vector2(x: screenWidth/2, y: screenHeight/2), 45, 10)
circle.enabled = false

SetTargetFPS(60)

while not WindowShouldClose():

  RunPhysicsStep()

  if needsReset:
    floor = CreatePhysicsBodyRectangle(
        Vector2(x: screenWidth/2, y: screenHeight), 500, 100, 10)
    floor.enabled = false
    circle = CreatePhysicsBodyCircle(
        Vector2(x: screenWidth/2, y: screenHeight/2), 45, 10)
    circle.enabled = false
    needsReset = false

  if IsKeyPressed(KEY_R):
    ResetPhysics()
    needsReset = true

  if IsMouseButtonPressed(MOUSE_LEFT_BUTTON):
    discard CreatePhysicsBodyPolygon(GetMousePosition(), GetRandomValue(20, 80).cfloat,
        GetRandomValue(3, 8), 10.0)
  elif IsMouseButtonPressed(MOUSE_RIGHT_BUTTON):
    discard CreatePhysicsBodyCircle(GetMousePosition(), GetRandomValue(10, 45).cfloat, 10)

  var bodiesCount = GetPhysicsBodiesCount()
  var i = bodiesCount - 1
  while i >= 0:
    var body = GetPhysicsBody(i)
    if body != nil and body.position.y > screenHeight*2:
      DestroyPhysicsBody(body)
    dec i

  BeginDrawing()
  ClearBackground(BLACK)

  DrawFPS(screenWidth - 90, screenHeight - 30)

  bodiesCount = GetPhysicsBodiesCount()
  for i in 0..<bodiesCount:
    var body = GetPhysicsBody(i)
    if body != nil:
      var vertexCount = GetPhysicsShapeVerticesCount(i)
      for j in 0..<vertexCount:
        var vertexA = GetPhysicsShapeVertex(body, j)
        var jj = if (j + 1) < vertexCount: (j + 1) else: 0
        var vertexB = GetPhysicsShapeVertex(body, jj)
        DrawLineV(vertexA, vertexB, GREEN)

  DrawText("Left mouse button to create a polygon", 10, 10, 10, WHITE)
  DrawText("Right mouse button to create a circle", 10, 25, 10, WHITE)
  DrawText("Press 'R' to reset example", 10, 40, 10, WHITE)

  DrawText("Physac", logoX, logoY, 30, WHITE)
  DrawText("Powered by", logoX + 50, logoY - 7, 10, WHITE)

  EndDrawing()

ClosePhysics()
CloseWindow()
