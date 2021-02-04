from raylib import Vector2, Vector3, Quaternion, Matrix

when defined(unix):
  const LIB_RAYLIB* = "libraylib.so"
elif defined(macosx):
  const LIB_RAYLIB* = "libraylib.dylib"
elif defined(windows):
  const LIB_RAYLIB* = "raylib.dll"

type
  float3* {.bycopy.} = object
    v*: array[3, cfloat]
  float16* {.bycopy.} = object
    v*: array[3, cfloat]

template MatrixToFloat*(mat: untyped): untyped =
  (MatrixToFloatV(mat).v)

template Vector3ToFloat*(vec: untyped): untyped =
  (Vector3ToFloatV(vec).v)


{.push cdecl, dynlib: LIB_RAYLIB, importc.}

## ----------------------------------------------------------------------------------
##  Module Functions - Utils math
## ----------------------------------------------------------------------------------

##  Clamp float value
proc Clamp*(value: cfloat; min: cfloat; max: cfloat): cfloat
##  Calculate linear interpolation between two floats
proc Lerp*(start: cfloat; `end`: cfloat; amount: cfloat): cfloat

## ----------------------------------------------------------------------------------
##  Module Functions - Vector2 math
## ----------------------------------------------------------------------------------

##  Vector with components value 0.0f
proc Vector2Zero*(): Vector2
##  Vector with components value 1.0f
proc Vector2One*(): Vector2
##  Add two vectors (v1 + v2)
proc Vector2Add*(v1: Vector2; v2: Vector2): Vector2
##  Subtract two vectors (v1 - v2)
proc Vector2Subtract*(v1: Vector2; v2: Vector2): Vector2
##  Calculate vector length
proc Vector2Length*(v: Vector2): cfloat
##  Calculate two vectors dot product
proc Vector2DotProduct*(v1: Vector2; v2: Vector2): cfloat
##  Calculate distance between two vectors
proc Vector2Distance*(v1: Vector2; v2: Vector2): cfloat
##  Calculate angle from two vectors in X-axis
proc Vector2Angle*(v1: Vector2; v2: Vector2): cfloat
##  Scale vector (multiply by value)
proc Vector2Scale*(v: Vector2; scale: cfloat): Vector2
##  Multiply vector by vector
proc Vector2MultiplyV*(v1: Vector2; v2: Vector2): Vector2
##  Negate vector
proc Vector2Negate*(v: Vector2): Vector2
##  Divide vector by a float value
proc Vector2Divide*(v: Vector2; `div`: cfloat): Vector2
##  Divide vector by vector
proc Vector2DivideV*(v1: Vector2; v2: Vector2): Vector2
##  Normalize provided vector
proc Vector2Normalize*(v: Vector2): Vector2
##  Calculate linear interpolation between two vectors
proc Vector2Lerp*(v1: Vector2; v2: Vector2; amount: cfloat): Vector2
##  Rotate Vector by float in Degrees.
proc Vector2Rotate*(v: Vector2; degs: cfloat): Vector2

## ----------------------------------------------------------------------------------
##  Module Functions - Vector3 math
## ----------------------------------------------------------------------------------

##  Vector with components value 0.0f
proc Vector3Zero*(): Vector3
##  Vector with components value 1.0f
proc Vector3One*(): Vector3
##  Add two vectors
proc Vector3Add*(v1: Vector3; v2: Vector3): Vector3
##  Subtract two vectors
proc Vector3Subtract*(v1: Vector3; v2: Vector3): Vector3
##  Multiply vector by scalar
proc Vector3Scale*(v: Vector3; scalar: cfloat): Vector3
##  Multiply vector by vector
proc Vector3Multiply*(v1: Vector3; v2: Vector3): Vector3
##  Calculate two vectors cross product
proc Vector3CrossProduct*(v1: Vector3; v2: Vector3): Vector3
##  Calculate one vector perpendicular vector
proc Vector3Perpendicular*(v: Vector3): Vector3
##  Calculate vector length
proc Vector3Length*(v: Vector3): cfloat
##  Calculate two vectors dot product
proc Vector3DotProduct*(v1: Vector3; v2: Vector3): cfloat
##  Calculate distance between two vectors
proc Vector3Distance*(v1: Vector3; v2: Vector3): cfloat
##  Negate provided vector (invert direction)
proc Vector3Negate*(v: Vector3): Vector3
##  Divide vector by a float value
proc Vector3Divide*(v: Vector3; `div`: cfloat): Vector3
##  Divide vector by vector
proc Vector3DivideV*(v1: Vector3; v2: Vector3): Vector3
##  Normalize provided vector
proc Vector3Normalize*(v: Vector3): Vector3
##  Orthonormalize provided vectors
##  Makes vectors normalized and orthogonal to each other
##  Gram-Schmidt function implementation
proc Vector3OrthoNormalize*(v1: ptr Vector3; v2: ptr Vector3)
##  Transforms a Vector3 by a given Matrix
proc Vector3Transform*(v: Vector3; mat: Matrix): Vector3
##  Transform a vector by quaternion rotation
proc Vector3RotateByQuaternion*(v: Vector3; q: Quaternion): Vector3
##  Calculate linear interpolation between two vectors
proc Vector3Lerp*(v1: Vector3; v2: Vector3; amount: cfloat): Vector3
##  Calculate reflected vector to normal
proc Vector3Reflect*(v: Vector3; normal: Vector3): Vector3
##  Return min value for each pair of components
proc Vector3Min*(v1: Vector3; v2: Vector3): Vector3
##  Return max value for each pair of components
proc Vector3Max*(v1: Vector3; v2: Vector3): Vector3
##  Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
##  NOTE: Assumes P is on the plane of the triangle
proc Vector3Barycenter*(p: Vector3; a: Vector3; b: Vector3; c: Vector3): Vector3
##  Returns Vector3 as float array
proc Vector3ToFloatV*(v: Vector3): float3

## ----------------------------------------------------------------------------------
##  Module Functions - Matrix math
## ----------------------------------------------------------------------------------

##  Compute matrix determinant
proc MatrixDeterminant*(mat: Matrix): cfloat
##  Returns the trace of the matrix (sum of the values along the diagonal)
proc MatrixTrace*(mat: Matrix): cfloat
##  Transposes provided matrix
proc MatrixTranspose*(mat: Matrix): Matrix
##  Invert provided matrix
proc MatrixInvert*(mat: Matrix): Matrix
##  Normalize provided matrix
proc MatrixNormalize*(mat: Matrix): Matrix
##  Returns identity matrix
proc MatrixIdentity*(): Matrix
##  Add two matrices
proc MatrixAdd*(left: Matrix; right: Matrix): Matrix
##  Subtract two matrices (left - right)
proc MatrixSubtract*(left: Matrix; right: Matrix): Matrix
##  Returns translation matrix
proc MatrixTranslate*(x: cfloat; y: cfloat; z: cfloat): Matrix
##  Create rotation matrix from axis and angle
##  NOTE: Angle should be provided in radians
proc MatrixRotate*(axis: Vector3; angle: cfloat): Matrix
##  Returns xyz-rotation matrix (angles in radians)
proc MatrixRotateXYZ*(ang: Vector3): Matrix
##  Returns x-rotation matrix (angle in radians)
proc MatrixRotateX*(angle: cfloat): Matrix
##  Returns y-rotation matrix (angle in radians)
proc MatrixRotateY*(angle: cfloat): Matrix
##  Returns z-rotation matrix (angle in radians)
proc MatrixRotateZ*(angle: cfloat): Matrix
##  Returns scaling matrix
proc MatrixScale*(x: cfloat; y: cfloat; z: cfloat): Matrix
##  Returns two matrix multiplication
##  NOTE: When multiplying matrices... the order matters!
proc MatrixMultiply*(left: Matrix; right: Matrix): Matrix
##  Returns perspective projection matrix
proc MatrixFrustum*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
                   near: cdouble; far: cdouble): Matrix
##  Returns perspective projection matrix
##  NOTE: Angle should be provided in radians
proc MatrixPerspective*(fovy: cdouble; aspect: cdouble; near: cdouble; far: cdouble): Matrix
##  Returns orthographic projection matrix
proc MatrixOrtho*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
                 near: cdouble; far: cdouble): Matrix
##  Returns camera look-at matrix (view matrix)
proc MatrixLookAt*(eye: Vector3; target: Vector3; up: Vector3): Matrix
##  Returns float array of matrix data
proc MatrixToFloatV*(mat: Matrix): float16

## ----------------------------------------------------------------------------------
##  Module Functions - Quaternion math
## ----------------------------------------------------------------------------------

##  Returns identity quaternion
proc QuaternionIdentity*(): Quaternion
##  Computes the length of a quaternion
proc QuaternionLength*(q: Quaternion): cfloat
##  Normalize provided quaternion
proc QuaternionNormalize*(q: Quaternion): Quaternion
##  Invert provided quaternion
proc QuaternionInvert*(q: Quaternion): Quaternion
##  Calculate two quaternion multiplication
proc QuaternionMultiply*(q1: Quaternion; q2: Quaternion): Quaternion
##  Calculate linear interpolation between two quaternions
proc QuaternionLerp*(q1: Quaternion; q2: Quaternion; amount: cfloat): Quaternion
##  Calculate slerp-optimized interpolation between two quaternions
proc QuaternionNlerp*(q1: Quaternion; q2: Quaternion; amount: cfloat): Quaternion
##  Calculates spherical linear interpolation between two quaternions
proc QuaternionSlerp*(q1: Quaternion; q2: Quaternion; amount: cfloat): Quaternion
##  Calculate quaternion based on the rotation from one vector to another
proc QuaternionFromVector3ToVector3*(`from`: Vector3; to: Vector3): Quaternion
##  Returns a quaternion for a given rotation matrix
proc QuaternionFromMatrix*(mat: Matrix): Quaternion
##  Returns a matrix for a given quaternion
proc QuaternionToMatrix*(q: Quaternion): Matrix
##  Returns rotation quaternion for an angle and axis
##  NOTE: angle must be provided in radians
proc QuaternionFromAxisAngle*(axis: Vector3; angle: cfloat): Quaternion
##  Returns the rotation angle and axis for a given quaternion
proc QuaternionToAxisAngle*(q: Quaternion; outAxis: ptr Vector3; outAngle: ptr cfloat)
##  Returns he quaternion equivalent to Euler angles
proc QuaternionFromEuler*(roll: cfloat; pitch: cfloat; yaw: cfloat): Quaternion
##  Return the Euler angles equivalent to quaternion (roll, pitch, yaw)
##  NOTE: Angles are returned in a Vector3 struct in degrees
proc QuaternionToEuler*(q: Quaternion): Vector3
##  Transform a quaternion given a transformation matrix
proc QuaternionTransform*(q: Quaternion, mat: Matrix): Quaternion

# {.pop.}
