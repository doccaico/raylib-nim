import raylib
{.define: PHYSAC_NO_THREADS.}
import raylib/physac

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)

InitWindow(screenWidth, screenHeight, "Physac [raylib] - Physics friction")

var logoX:cint = screenWidth - MeasureText("Physac", 30) - 10
var logoY:cint = 15

InitPhysics()

var floor = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth/2, y: screenHeight), screenWidth, 100, 10)
floor.enabled = false

var wall = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth/2, y: screenHeight*0.8), 10, 80, 10)
wall.enabled = false

var rectLeft = CreatePhysicsBodyRectangle(
    Vector2(x: 25, y: screenHeight - 5), 250, 250, 10)
rectLeft.enabled = false
SetPhysicsBodyRotation(rectLeft, 30*DEG2RAD)

var rectRight = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth - 25, y: screenHeight - 5), 250, 250, 10)
rectRight.enabled = false
SetPhysicsBodyRotation(rectRight, 330*DEG2RAD)

var bodyA = CreatePhysicsBodyRectangle(
    Vector2(x: 35, y: screenHeight*0.6), 40, 40, 10)
bodyA.staticFriction = 0.1
bodyA.dynamicFriction = 0.1
SetPhysicsBodyRotation(bodyA, 30*DEG2RAD)

var bodyB = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth - 35, y: screenHeight*0.6), 40, 40, 10)
bodyB.staticFriction = 1.0
bodyB.dynamicFriction = 1.0
SetPhysicsBodyRotation(bodyB, 330*DEG2RAD)

SetTargetFPS(60)

while not WindowShouldClose():
  RunPhysicsStep()

  if IsKeyPressed(KEY_R):
    bodyA.position = Vector2(x: 35, y: screenHeight*0.6)
    bodyA.velocity = Vector2(x: 0, y: 0)
    bodyA.angularVelocity = 0
    SetPhysicsBodyRotation(bodyA, 30*DEG2RAD)

    bodyB.position = Vector2(x: screenWidth - 35, y: screenHeight*0.6)
    bodyB.velocity = Vector2(x: 0, y: 0)
    bodyB.angularVelocity = 0
    SetPhysicsBodyRotation(bodyB, 330*DEG2RAD)

  BeginDrawing()
  ClearBackground(BLACK)

  DrawFPS(screenWidth - 90, screenHeight - 30)

  var bodiesCount = GetPhysicsBodiesCount()

  for i in 0..<bodiesCount:
    var body = GetPhysicsBody(i)
    if body != nil:
      var vertexCount = GetPhysicsShapeVerticesCount(i)
      for j in 0..<vertexCount:
        var vertexA = GetPhysicsShapeVertex(body, j)
        var jj = if (j + 1) < vertexCount: (j + 1) else: 0
        var vertexB = GetPhysicsShapeVertex(body, jj)
        DrawLineV(vertexA, vertexB, GREEN)

  DrawRectangle(0, screenHeight - 49, screenWidth, 49, BLACK)
  DrawText("Friction amount",
      ((screenWidth - MeasureText("Friction amount", 30))/2).cint, 75, 30, WHITE)
  DrawText("0.1",
      (bodyA.position.x - MeasureText("0.1", 20)/2).cint,
      (bodyA.position.y - 7).cint, 20, WHITE)
  DrawText("1",
      (bodyB.position.x - MeasureText("1", 20)/2).cint,
      (bodyB.position.y - 7).cint, 20, WHITE)
  DrawText("Press 'R' to reset example", 10, 10, 10, WHITE)
  DrawText("Physac", logoX, logoY, 30, WHITE)
  DrawText("Powered by", logoX + 50, logoY - 7, 10, WHITE)

  EndDrawing()

ClosePhysics()
CloseWindow()
