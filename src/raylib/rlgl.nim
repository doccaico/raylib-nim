from raylib import Model, Shader, Texture2D, RenderTexture2D, RenderTexture,
    Mesh, Material, Vector3, Matrix

when defined(unix):
  const LIB_RAYLIB* = "libraylib.so"
elif defined(macosx):
  const LIB_RAYLIB* = "libraylib.dylib"
elif defined(windows):
  const LIB_RAYLIB* = "raylib.dll"


const
  DEFAULT_BATCH_BUFFER_ELEMENTS* = 8192
  DEFAULT_BATCH_BUFFERS* = 1
  DEFAULT_BATCH_DRAWCALLS* = 256
  MAX_BATCH_ACTIVE_TEXTURES* = 4
  MAX_MATRIX_STACK_SIZE* = 32
  MAX_SHADER_LOCATIONS* = 32
  MAX_MATERIAL_MAPS* = 12
  RL_CULL_DISTANCE_NEAR* = 0.01
  RL_CULL_DISTANCE_FAR* = 1000.0
  RL_TEXTURE_WRAP_S* = 0x00002802
  RL_TEXTURE_WRAP_T* = 0x00002803
  RL_TEXTURE_MAG_FILTER* = 0x00002800
  RL_TEXTURE_MIN_FILTER* = 0x00002801
  RL_TEXTURE_ANISOTROPIC_FILTER* = 0x00003000
  RL_FILTER_NEAREST* = 0x00002600
  RL_FILTER_LINEAR* = 0x00002601
  RL_FILTER_MIP_NEAREST* = 0x00002700
  RL_FILTER_NEAREST_MIP_LINEAR* = 0x00002702
  RL_FILTER_LINEAR_MIP_NEAREST* = 0x00002701
  RL_FILTER_MIP_LINEAR* = 0x00002703
  RL_WRAP_REPEAT* = 0x00002901
  RL_WRAP_CLAMP* = 0x0000812F
  RL_WRAP_MIRROR_REPEAT* = 0x00008370
  RL_WRAP_MIRROR_CLAMP* = 0x00008742
  RL_MODELVIEW* = 0x00001700
  RL_PROJECTION* = 0x00001701
  RL_TEXTURE* = 0x00001702
  RL_LINES* = 0x00000001
  RL_TRIANGLES* = 0x00000004
  RL_QUADS* = 0x00000007

const
  OPENGL_11* = 1
  OPENGL_21* = 2
  OPENGL_33* = 3
  OPENGL_ES_20* = 4

const
  RL_ATTACHMENT_COLOR_CHANNEL0* = 0
  RL_ATTACHMENT_COLOR_CHANNEL1* = 1
  RL_ATTACHMENT_COLOR_CHANNEL2* = 2
  RL_ATTACHMENT_COLOR_CHANNEL3* = 3
  RL_ATTACHMENT_COLOR_CHANNEL4* = 4
  RL_ATTACHMENT_COLOR_CHANNEL5* = 5
  RL_ATTACHMENT_COLOR_CHANNEL6* = 6
  RL_ATTACHMENT_COLOR_CHANNEL7* = 7
  RL_ATTACHMENT_DEPTH* = 100
  RL_ATTACHMENT_STENCIL* = 200

const
  RL_ATTACHMENT_CUBEMAP_POSITIVE_X* = 0
  RL_ATTACHMENT_CUBEMAP_NEGATIVE_X* = 1
  RL_ATTACHMENT_CUBEMAP_POSITIVE_Y* = 2
  RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y* = 3
  RL_ATTACHMENT_CUBEMAP_POSITIVE_Z* = 4
  RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z* = 5
  RL_ATTACHMENT_TEXTURE2D* = 100
  RL_ATTACHMENT_RENDERBUFFER* = 200


{.push cdecl, dynlib: LIB_RAYLIB, importc.}

proc rlMatrixMode*(mode: cint)
proc rlPushMatrix*()
proc rlPopMatrix*()
proc rlLoadIdentity*()
proc rlTranslatef*(x: cfloat; y: cfloat; z: cfloat)
proc rlRotatef*(angleDeg: cfloat; x: cfloat; y: cfloat; z: cfloat)
proc rlScalef*(x: cfloat; y: cfloat; z: cfloat)
proc rlMultMatrixf*(matf: ptr cfloat)
proc rlFrustum*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
               znear: cdouble; zfar: cdouble)
proc rlOrtho*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
             znear: cdouble; zfar: cdouble)
proc rlViewport*(x: cint; y: cint; width: cint; height: cint)
proc rlBegin*(mode: cint)
proc rlEnd*()
proc rlVertex2i*(x: cint; y: cint)
proc rlVertex2f*(x: cfloat; y: cfloat)
proc rlVertex3f*(x: cfloat; y: cfloat; z: cfloat)
proc rlTexCoord2f*(x: cfloat; y: cfloat)
proc rlNormal3f*(x: cfloat; y: cfloat; z: cfloat)
proc rlColor4ub*(r: cuchar; g: cuchar; b: cuchar; a: cuchar)
proc rlColor3f*(x: cfloat; y: cfloat; z: cfloat)
proc rlColor4f*(x: cfloat; y: cfloat; z: cfloat; w: cfloat)
proc rlEnableTexture*(id: cuint)
proc rlDisableTexture*()
proc rlTextureParameters*(id: cuint; param: cint; value: cint)
proc rlEnableShader*(id: cuint)
proc rlDisableShader*()
proc rlEnableFramebuffer*(id: cuint)
proc rlDisableFramebuffer*()
proc rlEnableDepthTest*()
proc rlDisableDepthTest*()
proc rlEnableDepthMask*()
proc rlDisableDepthMask*()
proc rlEnableBackfaceCulling*()
proc rlDisableBackfaceCulling*()
proc rlEnableScissorTest*()
proc rlDisableScissorTest*()
proc rlScissor*(x: cint; y: cint; width: cint; height: cint)
proc rlEnableWireMode*()
proc rlDisableWireMode*()
proc rlSetLineWidth*(width: cfloat)
proc rlGetLineWidth*(): cfloat
proc rlEnableSmoothLines*()
proc rlDisableSmoothLines*()
proc rlClearColor*(r: cuchar; g: cuchar; b: cuchar; a: cuchar)
proc rlClearScreenBuffers*()
proc rlUpdateBuffer*(bufferId: cint; data: pointer; dataSize: cint)
proc rlLoadAttribBuffer*(vaoId: cuint; shaderLoc: cint; buffer: pointer; size: cint;
                        dynamic: bool): cuint
proc rlglInit*(width: cint; height: cint)
proc rlglClose*()
proc rlglDraw*()
proc rlCheckErrors*()
proc rlGetVersion*(): cint
proc rlCheckBufferLimit*(vCount: cint): bool
proc rlSetDebugMarker*(text: cstring)
proc rlSetBlendMode*(glSrcFactor: cint; glDstFactor: cint; glEquation: cint)
proc rlLoadExtensions*(loader: pointer)
proc rlLoadTexture*(data: pointer; width: cint; height: cint; format: cint;
                   mipmapCount: cint): cuint
proc rlLoadTextureDepth*(width: cint; height: cint; useRenderBuffer: bool): cuint
proc rlLoadTextureCubemap*(data: pointer; size: cint; format: cint): cuint
proc rlUpdateTexture*(id: cuint; offsetX: cint; offsetY: cint; width: cint; height: cint;
                     format: cint; data: pointer)
proc rlGetGlTextureFormats*(format: cint; glInternalFormat: ptr cuint;
                           glFormat: ptr cuint; glType: ptr cuint)
proc rlUnloadTexture*(id: cuint)
proc rlGenerateMipmaps*(texture: ptr Texture2D)
proc rlReadTexturePixels*(texture: Texture2D): pointer
proc rlReadScreenPixels*(width: cint; height: cint): ptr cuchar
proc rlLoadFramebuffer*(width: cint; height: cint): cuint
proc rlFramebufferAttach*(fboId: cuint; texId: cuint; attachType: cint; texType: cint)
proc rlFramebufferComplete*(id: cuint): bool
proc rlUnloadFramebuffer*(id: cuint)
proc rlLoadMesh*(mesh: ptr Mesh; dynamic: bool)
proc rlUpdateMesh*(mesh: Mesh; buffer: cint; count: cint)
proc rlUpdateMeshAt*(mesh: Mesh; buffer: cint; count: cint; index: cint)
proc rlDrawMesh*(mesh: Mesh; material: Material; transform: Matrix)
proc rlDrawMeshInstanced*(mesh: Mesh; material: Material; transforms: ptr Matrix;
                         count: cint)
proc rlUnloadMesh*(mesh: Mesh)

{.pop.}
