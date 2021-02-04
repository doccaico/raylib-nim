import raylib
{.define: PHYSAC_NO_THREADS.}
import raylib/physac

const
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)
InitWindow(screenWidth, screenHeight, "Physac [raylib] - Physics restitution")

var logoX: cint = screenWidth - MeasureText("Physac", 30) - 10
var logoY: cint = 15

InitPhysics()

var floor = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth/2, y: screenHeight), screenWidth, 100, 10)
floor.enabled = false
floor.restitution = 1

var circleA = CreatePhysicsBodyCircle(
    Vector2(x: screenWidth*0.25, y: screenHeight/2), 30, 10)
circleA.restitution = 0

var circleB = CreatePhysicsBodyCircle(
    Vector2(x: screenWidth*0.5, y: screenHeight/2), 30, 10)
circleB.restitution = 0.5

var circleC = CreatePhysicsBodyCircle(
    Vector2(x: screenWidth*0.75, y: screenHeight/2), 30, 10)
circleC.restitution = 1

SetPhysicsTimeStep(1.0/60.0/100*1000)

SetTargetFPS(60)

while not WindowShouldClose():
  RunPhysicsStep()

  if IsKeyPressed(KEY_R):
    circleA.position = Vector2(x: screenWidth*0.25, y: screenHeight/2)
    circleA.velocity = Vector2(x: 0, y: 0)
    circleB.position = Vector2(x: screenWidth*0.5, y: screenHeight/2)
    circleB.velocity = Vector2(x: 0, y: 0)
    circleC.position = Vector2(x: screenWidth*0.75, y: screenHeight/2)
    circleC.velocity = Vector2(x: 0, y: 0)

  BeginDrawing()
  ClearBackground(BLACK)

  DrawFPS(screenWidth - 90, screenHeight - 30)

  var bodiesCount = GetPhysicsBodiesCount()
  for i in 0..<bodiesCount:
    var body = GetPhysicsBody(i)
    var vertexCount = GetPhysicsShapeVerticesCount(i)
    for j in 0..<vertexCount:
      var vertexA = GetPhysicsShapeVertex(body, j)
      var jj = if (j + 1) < vertexCount: (j + 1) else: 0
      var vertexB = GetPhysicsShapeVertex(body, jj)
      DrawLineV(vertexA, vertexB, GREEN)

  DrawText("Restitution amount",
      ((screenWidth - MeasureText("Restitution amount", 30))/2).cint, 75, 30, WHITE)
  DrawText("0",
      (circleA.position.x - MeasureText("0", 20)/2).cint,
      (circleA.position.y - 7).cint, 20, WHITE)
  DrawText("0.5",
      (circleB.position.x - MeasureText("0.5", 20)/2).cint,
      (circleB.position.y - 7).cint, 20, WHITE)
  DrawText("1",
      (circleC.position.x - MeasureText("1", 20)/2).cint,
      (circleC.position.y - 7).cint, 20, WHITE)

  DrawText("Press 'R' to reset example", 10, 10, 10, WHITE)

  DrawText("Physac", logoX, logoY, 30, WHITE)
  DrawText("Powered by", logoX + 50, logoY - 7, 10, WHITE)

  EndDrawing()

DestroyPhysicsBody(circleA)
DestroyPhysicsBody(circleB)
DestroyPhysicsBody(circleC)
DestroyPhysicsBody(floor)
ClosePhysics()
CloseWindow()
