from os import parentDir
from raylib import Vector2

when defined(PHYSAC_NO_THREADS):
  {.localPassC:"-DPHYSAC_NO_THREADS".}

const headerPath = currentSourcePath.parentDir() & "/include"

{.localPassC:"-DPHYSAC_IMPLEMENTATION".}
{.emit: "#include <raylib.h>".}
{.emit: "#include \"" & headerPath & "/physac.h\"".}

const
  PHYSAC_MAX_BODIES* = 64
  PHYSAC_MAX_MANIFOLDS* = 4096
  PHYSAC_MAX_VERTICES* = 24
  PHYSAC_CIRCLE_VERTICES* = 24

  PHYSAC_COLLISION_ITERATIONS* = 100
  PHYSAC_PENETRATION_ALLOWANCE* = 0.05
  PHYSAC_PENETRATION_CORRECTION* = 0.4

  PHYSAC_PI* = 3.14159265358979323846
  PHYSAC_DEG2RAD* = (PHYSAC_PI/180.0)

type
  PhysicsShapeType* = enum
    PHYSICS_CIRCLE, PHYSICS_POLYGON

##----------------------------------------------------------------------------------
##  Data Types Structure
##----------------------------------------------------------------------------------

type
  PhysicsBody* = ptr PhysicsBodyData
  Matrix2x2* {.bycopy.} = object
    m00*: cfloat
    m01*: cfloat
    m10*: cfloat
    m11*: cfloat

  PolygonData* {.bycopy.} = object
    vertexCount*: cuint        ##  Current used vertex and normals count
    positions*: array[PHYSAC_MAX_VERTICES, Vector2] ##  Polygon vertex positions vectors
    normals*: array[PHYSAC_MAX_VERTICES, Vector2] ##  Polygon vertex normals vectors

  PhysicsShape* {.bycopy.} = object
    `type`*: PhysicsShapeType  ##  Physics shape type (circle or polygon)
    body*: PhysicsBody         ##  Shape physics body reference
    radius*: cfloat            ##  Circle shape radius (used for circle shapes)
    transform*: Matrix2x2      ##  Vertices transform matrix 2x2
    vertexData*: PolygonData   ##  Polygon shape vertices position and normals data (just used for polygon shapes)

  PhysicsBodyData* {.bycopy.} = object
    id*: cuint                 ##  Reference unique identifier
    enabled*: bool             ##  Enabled dynamics state (collisions are calculated anyway)
    position*: Vector2         ##  Physics body shape pivot
    velocity*: Vector2         ##  Current linear velocity applied to position
    force*: Vector2            ##  Current linear force (reset to 0 every step)
    angularVelocity*: cfloat   ##  Current angular velocity applied to orient
    torque*: cfloat            ##  Current angular force (reset to 0 every step)
    orient*: cfloat            ##  Rotation in radians
    inertia*: cfloat           ##  Moment of inertia
    inverseInertia*: cfloat    ##  Inverse value of inertia
    mass*: cfloat              ##  Physics body mass
    inverseMass*: cfloat       ##  Inverse value of mass
    staticFriction*: cfloat    ##  Friction when the body has not movement (0 to 1)
    dynamicFriction*: cfloat   ##  Friction when the body has movement (0 to 1)
    restitution*: cfloat       ##  Restitution coefficient of the body (0 to 1)
    useGravity*: bool          ##  Apply gravity force to dynamics
    isGrounded*: bool          ##  Physics grounded on other body state
    freezeOrient*: bool        ##  Physics rotation constraint
    shape*: PhysicsShape       ##  Physics body shape information (type, radius, vertices, normals)

  PhysicsManifoldData* {.bycopy.} = object
    id*: cuint                 ##  Reference unique identifier
    bodyA*: PhysicsBody        ##  Manifold first physics body reference
    bodyB*: PhysicsBody        ##  Manifold second physics body reference
    penetration*: cfloat       ##  Depth of penetration from collision
    normal*: Vector2           ##  Normal direction vector from 'a' to 'b'
    contacts*: array[2, Vector2] ##  Points of contact during collision
    contactsCount*: cuint      ##  Current collision number of contacts
    restitution*: cfloat       ##  Mixed restitution during collision
    dynamicFriction*: cfloat   ##  Mixed dynamic friction during collision
    staticFriction*: cfloat    ##  Mixed static friction during collision

  PhysicsManifold* = ptr PhysicsManifoldData


{.push cdecl, importc.}

##----------------------------------------------------------------------------------
##  Module Functions Declaration
##----------------------------------------------------------------------------------

proc InitPhysics*()
##  Initializes physics values, pointers and creates physics loop thread
proc RunPhysicsStep*()
##  Run physics step, to be used if PHYSICS_NO_THREADS is set in your main loop
proc SetPhysicsTimeStep*(delta: cdouble)
##  Sets physics fixed time step in milliseconds. 1.666666 by default
proc IsPhysicsEnabled*(): bool
##  Returns true if physics thread is currently enabled
proc SetPhysicsGravity*(x: cfloat; y: cfloat)
##  Sets physics global gravity force
proc CreatePhysicsBodyCircle*(pos: Vector2; radius: cfloat; density: cfloat): PhysicsBody
##  Creates a new circle physics body with generic parameters
proc CreatePhysicsBodyRectangle*(pos: Vector2; width: cfloat; height: cfloat;
                                density: cfloat): PhysicsBody
##  Creates a new rectangle physics body with generic parameters
proc CreatePhysicsBodyPolygon*(pos: Vector2; radius: cfloat; sides: cint;
                              density: cfloat): PhysicsBody
##  Creates a new polygon physics body with generic parameters
proc PhysicsAddForce*(body: PhysicsBody; force: Vector2)
##  Adds a force to a physics body
proc PhysicsAddTorque*(body: PhysicsBody; amount: cfloat)
##  Adds an angular force to a physics body
proc PhysicsShatter*(body: PhysicsBody; position: Vector2; force: cfloat)
##  Shatters a polygon shape physics body to little physics bodies with explosion force
proc GetPhysicsBodiesCount*(): cint
##  Returns the current amount of created physics bodies
proc GetPhysicsBody*(index: cint): PhysicsBody
##  Returns a physics body of the bodies pool at a specific index
proc GetPhysicsShapeType*(index: cint): cint
##  Returns the physics body shape type (PHYSICS_CIRCLE or PHYSICS_POLYGON)
proc GetPhysicsShapeVerticesCount*(index: cint): cint
##  Returns the amount of vertices of a physics body shape
proc GetPhysicsShapeVertex*(body: PhysicsBody; vertex: cint): Vector2
##  Returns transformed position of a body shape (body position + vertex transformed position)
proc SetPhysicsBodyRotation*(body: PhysicsBody; radians: cfloat)
##  Sets physics body shape transform based on radians parameter
proc DestroyPhysicsBody*(body: PhysicsBody)
##  Unitializes and destroy a physics body
proc ResetPhysics*()
##  Destroys created physics bodies and manifolds and resets global values
proc ClosePhysics*()
##  Unitializes physics pointers and closes physics loop thread

# {.pop.}
