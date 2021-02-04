from raylib import Vector2, Vector3, Vector4, Quaternion, Matrix

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

proc Clamp*(value: cfloat; min: cfloat; max: cfloat): cfloat
proc Lerp*(start: cfloat; `end`: cfloat; amount: cfloat): cfloat
proc Normalize*(value: cfloat; start: cfloat; `end`: cfloat): cfloat
proc Remap*(value: cfloat; inputStart: cfloat; inputEnd: cfloat; outputStart: cfloat;
           outputEnd: cfloat): cfloat
proc Vector2Zero*(): Vector2
proc Vector2One*(): Vector2
proc Vector2Add*(v1: Vector2; v2: Vector2): Vector2
proc Vector2AddValue*(v: Vector2; add: cfloat): Vector2
proc Vector2Subtract*(v1: Vector2; v2: Vector2): Vector2
proc Vector2SubtractValue*(v: Vector2; sub: cfloat): Vector2
proc Vector2Length*(v: Vector2): cfloat
proc Vector2LengthSqr*(v: Vector2): cfloat
proc Vector2DotProduct*(v1: Vector2; v2: Vector2): cfloat
proc Vector2Distance*(v1: Vector2; v2: Vector2): cfloat
proc Vector2Angle*(v1: Vector2; v2: Vector2): cfloat
proc Vector2Scale*(v: Vector2; scale: cfloat): Vector2
proc Vector2Multiply*(v1: Vector2; v2: Vector2): Vector2
proc Vector2Negate*(v: Vector2): Vector2
proc Vector2Divide*(v1: Vector2; v2: Vector2): Vector2
proc Vector2Normalize*(v: Vector2): Vector2
proc Vector2Lerp*(v1: Vector2; v2: Vector2; amount: cfloat): Vector2
proc Vector2Reflect*(v: Vector2; normal: Vector2): Vector2
proc Vector2Rotate*(v: Vector2; degs: cfloat): Vector2
proc Vector2MoveTowards*(v: Vector2; target: Vector2;
    maxDistance: cfloat): Vector2
proc Vector3Zero*(): Vector3
proc Vector3One*(): Vector3
proc Vector3Add*(v1: Vector3; v2: Vector3): Vector3
proc Vector3AddValue*(v: Vector3; add: cfloat): Vector3
proc Vector3Subtract*(v1: Vector3; v2: Vector3): Vector3
proc Vector3SubtractValue*(v: Vector3; sub: cfloat): Vector3
proc Vector3Scale*(v: Vector3; scalar: cfloat): Vector3
proc Vector3Multiply*(v1: Vector3; v2: Vector3): Vector3
proc Vector3CrossProduct*(v1: Vector3; v2: Vector3): Vector3
proc Vector3Perpendicular*(v: Vector3): Vector3
proc Vector3Length*(v: Vector3): cfloat
proc Vector3LengthSqr*(v: Vector3): cfloat
proc Vector3DotProduct*(v1: Vector3; v2: Vector3): cfloat
proc Vector3Distance*(v1: Vector3; v2: Vector3): cfloat
proc Vector3Negate*(v: Vector3): Vector3
proc Vector3Divide*(v1: Vector3; v2: Vector3): Vector3
proc Vector3Normalize*(v: Vector3): Vector3
proc Vector3OrthoNormalize*(v1: ptr Vector3; v2: ptr Vector3)
proc Vector3Transform*(v: Vector3; mat: Matrix): Vector3
proc Vector3RotateByQuaternion*(v: Vector3; q: Quaternion): Vector3
proc Vector3Lerp*(v1: Vector3; v2: Vector3; amount: cfloat): Vector3
proc Vector3Reflect*(v: Vector3; normal: Vector3): Vector3
proc Vector3Min*(v1: Vector3; v2: Vector3): Vector3
proc Vector3Max*(v1: Vector3; v2: Vector3): Vector3
proc Vector3Barycenter*(p: Vector3; a: Vector3; b: Vector3; c: Vector3): Vector3
proc Vector3ToFloatV*(v: Vector3): float3
proc MatrixDeterminant*(mat: Matrix): cfloat
proc MatrixTrace*(mat: Matrix): cfloat
proc MatrixTranspose*(mat: Matrix): Matrix
proc MatrixInvert*(mat: Matrix): Matrix
proc MatrixNormalize*(mat: Matrix): Matrix
proc MatrixIdentity*(): Matrix
proc MatrixAdd*(left: Matrix; right: Matrix): Matrix
proc MatrixSubtract*(left: Matrix; right: Matrix): Matrix
proc MatrixMultiply*(left: Matrix; right: Matrix): Matrix
proc MatrixTranslate*(x: cfloat; y: cfloat; z: cfloat): Matrix
proc MatrixRotate*(axis: Vector3; angle: cfloat): Matrix
proc MatrixRotateX*(angle: cfloat): Matrix
proc MatrixRotateY*(angle: cfloat): Matrix
proc MatrixRotateZ*(angle: cfloat): Matrix
proc MatrixRotateXYZ*(ang: Vector3): Matrix
proc MatrixRotateZYX*(ang: Vector3): Matrix
proc MatrixScale*(x: cfloat; y: cfloat; z: cfloat): Matrix
proc MatrixFrustum*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
                   near: cdouble; far: cdouble): Matrix
proc MatrixPerspective*(fovy: cdouble; aspect: cdouble; near: cdouble;
    far: cdouble): Matrix
proc MatrixOrtho*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
                 near: cdouble; far: cdouble): Matrix
proc MatrixLookAt*(eye: Vector3; target: Vector3; up: Vector3): Matrix
proc MatrixToFloatV*(mat: Matrix): float16
proc QuaternionAdd*(q1: Quaternion; q2: Quaternion): Quaternion
proc QuaternionAddValue*(q: Quaternion; add: cfloat): Quaternion
proc QuaternionSubtract*(q1: Quaternion; q2: Quaternion): Quaternion
proc QuaternionSubtractValue*(q: Quaternion; sub: cfloat): Quaternion
proc QuaternionIdentity*(): Quaternion
proc QuaternionLength*(q: Quaternion): cfloat
proc QuaternionNormalize*(q: Quaternion): Quaternion
proc QuaternionInvert*(q: Quaternion): Quaternion
proc QuaternionMultiply*(q1: Quaternion; q2: Quaternion): Quaternion
proc QuaternionScale*(q: Quaternion; mul: cfloat): Quaternion
proc QuaternionDivide*(q1: Quaternion; q2: Quaternion): Quaternion
proc QuaternionLerp*(q1: Quaternion; q2: Quaternion; amount: cfloat): Quaternion
proc QuaternionNlerp*(q1: Quaternion; q2: Quaternion;
    amount: cfloat): Quaternion
proc QuaternionSlerp*(q1: Quaternion; q2: Quaternion;
    amount: cfloat): Quaternion
proc QuaternionFromVector3ToVector3*(`from`: Vector3; to: Vector3): Quaternion
proc QuaternionFromMatrix*(mat: Matrix): Quaternion
proc QuaternionToMatrix*(q: Quaternion): Matrix
proc QuaternionFromAxisAngle*(axis: Vector3; angle: cfloat): Quaternion
proc QuaternionToAxisAngle*(q: Quaternion; outAxis: ptr Vector3;
    outAngle: ptr cfloat)
proc QuaternionFromEuler*(roll: cfloat; pitch: cfloat; yaw: cfloat): Quaternion
proc QuaternionToEuler*(q: Quaternion): Vector3
proc QuaternionTransform*(q: Quaternion; mat: Matrix): Quaternion
proc Vector3Unproject*(source: Vector3; projection: Matrix;
    view: Matrix): Vector3

{.pop.}
