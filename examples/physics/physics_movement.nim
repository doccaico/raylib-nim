import raylib
{.define: PHYSAC_NO_THREADS.}
import raylib/physac

const
  VELOCITY = 0.5
  screenWidth = 800
  screenHeight = 450

SetConfigFlags(FLAG_MSAA_4X_HINT)
InitWindow(screenWidth, screenHeight, "Physac [raylib] - Physics movement")

var logoX: cint = screenWidth - MeasureText("Physac", 30) - 10
var logoY: cint = 15

InitPhysics()

var floor = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth/2, y: screenHeight), screenWidth, 100, 10)
var platformLeft = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth*0.25, y: screenHeight*0.6), screenWidth*0.25, 10, 10)
var platformRight = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth*0.75, y: screenHeight*0.6), screenWidth*0.25, 10, 10)
var wallLeft = CreatePhysicsBodyRectangle(
    Vector2(x: -5, y: screenHeight/2), 10, screenHeight, 10)
var wallRight = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth + 5, y: screenHeight/2), 10, screenHeight, 10)

floor.enabled = false
platformLeft.enabled = false
platformRight.enabled = false
wallLeft.enabled = false
wallRight.enabled = false

var body = CreatePhysicsBodyRectangle(
    Vector2(x: screenWidth/2, y: screenHeight/2), 50, 50, 1)
body.freezeOrient = true

SetTargetFPS(60)

while not WindowShouldClose():
  RunPhysicsStep()

  if IsKeyPressed(KEY_R):
    body.position = Vector2(x: screenWidth/2, y: screenHeight/2)
    body.velocity = Vector2(x: 0.0, y: 0.0)
    SetPhysicsBodyRotation(body, 0)

  if IsKeyDown(KEY_RIGHT): body.velocity.x = VELOCITY
  elif IsKeyDown(KEY_LEFT): body.velocity.x = -VELOCITY

  if IsKeyDown(KEY_UP) and body.isGrounded: body.velocity.y = -VELOCITY*4

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

  DrawText("Use 'ARROWS' to move player", 10, 10, 10, WHITE)
  DrawText("Press 'R' to reset example", 10, 30, 10, WHITE)

  DrawText("Physac", logoX, logoY, 30, WHITE)
  DrawText("Powered by", logoX + 50, logoY - 7, 10, WHITE)

  EndDrawing()

ClosePhysics()
CloseWindow()
