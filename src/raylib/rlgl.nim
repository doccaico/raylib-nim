from raylib import Model, Shader, Texture2D, RenderTexture2D, RenderTexture,
    Mesh, Material, Vector3, Matrix

when defined(unix):
  const LIB_RAYLIB* = "libraylib.so"
elif defined(macosx):
  const LIB_RAYLIB* = "libraylib.dylib"
elif defined(windows):
  const LIB_RAYLIB* = "raylib.dll"

const
  MAX_SHADER_LOCATIONS* = 32
  MAX_MATERIAL_MAPS* = 12

##  Texture parameters (equivalent to OpenGL defines)

const
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

##  Matrix modes (equivalent to OpenGL)

const
  RL_MODELVIEW* = 0x00001700
  RL_PROJECTION* = 0x00001701
  RL_TEXTURE* = 0x00001702

##  Primitive assembly draw modes

const
  RL_LINES* = 0x00000001
  RL_TRIANGLES* = 0x00000004
  RL_QUADS* = 0x00000007

##----------------------------------------------------------------------------------
##  Types and Structures Definition
##----------------------------------------------------------------------------------

type
  GlVersion* = enum
    OPENGL_11 = 1, OPENGL_21, OPENGL_33, OPENGL_ES_20
  byte* = cuchar


{.push cdecl, dynlib: LIB_RAYLIB, importc.}

##------------------------------------------------------------------------------------
##  Functions Declaration - Matrix operations
##------------------------------------------------------------------------------------

##  Choose the current matrix to be transformed
proc rlMatrixMode*(mode: cint)
##  Push the current matrix to stack
proc rlPushMatrix*()
##  Pop lattest inserted matrix from stack
proc rlPopMatrix*()
##  Reset current matrix to identity matrix
proc rlLoadIdentity*()
##  Multiply the current matrix by a translation matrix
proc rlTranslatef*(x: cfloat; y: cfloat; z: cfloat)
##  Multiply the current matrix by a rotation matrix
proc rlRotatef*(angleDeg: cfloat; x: cfloat; y: cfloat; z: cfloat)
##  Multiply the current matrix by a scaling matrix
proc rlScalef*(x: cfloat; y: cfloat; z: cfloat)
##  Multiply the current matrix by another matrix
proc rlMultMatrixf*(matf: ptr cfloat)
##  Set the viewport area
proc rlFrustum*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
               znear: cdouble; zfar: cdouble)
proc rlOrtho*(left: cdouble; right: cdouble; bottom: cdouble; top: cdouble;
             znear: cdouble; zfar: cdouble)
proc rlViewport*(x: cint; y: cint; width: cint; height: cint)

##------------------------------------------------------------------------------------
##  Functions Declaration - Vertex level operations
##------------------------------------------------------------------------------------

##  Initialize drawing mode (how to organize vertex)
proc rlBegin*(mode: cint)
##  Finish vertex providing
proc rlEnd*()
##  Define one vertex (position) - 2 int
proc rlVertex2i*(x: cint; y: cint)
##  Define one vertex (position) - 2 float
proc rlVertex2f*(x: cfloat; y: cfloat)
##  Define one vertex (position) - 3 float
proc rlVertex3f*(x: cfloat; y: cfloat; z: cfloat)
##  Define one vertex (texture coordinate) - 2 float
proc rlTexCoord2f*(x: cfloat; y: cfloat)
##  Define one vertex (normal) - 3 float
proc rlNormal3f*(x: cfloat; y: cfloat; z: cfloat)
##  Define one vertex (color) - 4 byte
proc rlColor4ub*(r: byte; g: byte; b: byte; a: byte)
##  Define one vertex (color) - 3 float
proc rlColor3f*(x: cfloat; y: cfloat; z: cfloat)
##  Define one vertex (color) - 4 float
proc rlColor4f*(x: cfloat; y: cfloat; z: cfloat; w: cfloat)

##------------------------------------------------------------------------------------
##  Functions Declaration - OpenGL equivalent functions (common to 1.1, 3.3+, ES2)
##  NOTE: This functions are used to completely abstract raylib code from OpenGL layer
##------------------------------------------------------------------------------------

##  Enable texture usage
proc rlEnableTexture*(id: cuint)
##  Disable texture usage
proc rlDisableTexture*()
##  Set texture parameters (filter, wrap)
proc rlTextureParameters*(id: cuint; param: cint; value: cint)
##  Enable render texture (fbo)
proc rlEnableRenderTexture*(id: cuint)
##  Disable render texture (fbo), return to default framebuffer
proc rlDisableRenderTexture*()
##  Enable depth test
proc rlEnableDepthTest*()
##  Disable depth test
proc rlDisableDepthTest*()
##  Enable backface culling
proc rlEnableBackfaceCulling*()
##  Disable backface culling
proc rlDisableBackfaceCulling*()
##  Enable scissor test
proc rlEnableScissorTest*()
##  Disable scissor test
proc rlDisableScissorTest*()
##  Scissor test
proc rlScissor*(x: cint; y: cint; width: cint; height: cint)
##  Enable wire mode
proc rlEnableWireMode*()
##  Disable wire mode
proc rlDisableWireMode*()
##  Delete OpenGL texture from GPU
proc rlDeleteTextures*(id: cuint)
##  Delete render textures (fbo) from GPU
proc rlDeleteRenderTextures*(target: RenderTexture2D)
##  Delete OpenGL shader program from GPU
proc rlDeleteShader*(id: cuint)
##  Unload vertex data (VAO) from GPU memory
proc rlDeleteVertexArrays*(id: cuint)
##  Unload vertex data (VBO) from GPU memory
proc rlDeleteBuffers*(id: cuint)
##  Clear color buffer with color
proc rlClearColor*(r: byte; g: byte; b: byte; a: byte)
##  Clear used screen buffers (color and depth)
proc rlClearScreenBuffers*()
##  Update GPU buffer with new data
proc rlUpdateBuffer*(bufferId: cint; data: pointer; dataSize: cint)
##  Load a new attributes buffer
proc rlLoadAttribBuffer*(vaoId: cuint; shaderLoc: cint; buffer: pointer; size: cint;
                        dynamic: bool): cuint

##------------------------------------------------------------------------------------
##  Functions Declaration - rlgl functionality
##------------------------------------------------------------------------------------

##  Initialize rlgl (buffers, shaders, textures, states)
proc rlglInit*(width: cint; height: cint)
##  De-inititialize rlgl (buffers, shaders, textures)
proc rlglClose*()
##  Update and draw default internal buffers
proc rlglDraw*()
##  Returns current OpenGL version
proc rlGetVersion*(): cint
##  Check internal buffer overflow for a given number of vertex
proc rlCheckBufferLimit*(vCount: cint): bool
##  Set debug marker for analysis
proc rlSetDebugMarker*(text: cstring)
##  Load OpenGL extensions
proc rlLoadExtensions*(loader: pointer)
##  Get world coordinates from screen coordinates
proc rlUnproject*(source: Vector3; proj: Matrix; view: Matrix): Vector3

####  Textures data management

##  Load texture in GPU
proc rlLoadTexture*(data: pointer; width: cint; height: cint; format: cint;
                   mipmapCount: cint): cuint
##  Load depth texture/renderbuffer (to be attached to fbo)
proc rlLoadTextureDepth*(width: cint; height: cint; bits: cint; useRenderBuffer: bool): cuint
##  Load texture cubemap
proc rlLoadTextureCubemap*(data: pointer; size: cint; format: cint): cuint
##  Update GPU texture with new data
proc rlUpdateTexture*(id: cuint; width: cint; height: cint; format: cint; data: pointer)
##  Get OpenGL internal formats
proc rlGetGlTextureFormats*(format: cint; glInternalFormat: ptr cuint;
                           glFormat: ptr cuint; glType: ptr cuint)
##  Unload texture from GPU memory
proc rlUnloadTexture*(id: cuint)
##  Generate mipmap data for selected texture
proc rlGenerateMipmaps*(texture: ptr Texture2D)
##  Read texture pixel data
proc rlReadTexturePixels*(texture: Texture2D): pointer
##  Read screen pixel data (color buffer)
proc rlReadScreenPixels*(width: cint; height: cint): ptr cuchar

####  Render texture management (fbo)

##  Load a render texture (with color and depth attachments)
proc rlLoadRenderTexture*(width: cint; height: cint; format: cint; depthBits: cint;
                         useDepthTexture: bool): RenderTexture2D
##  Attach texture/renderbuffer to an fbo
proc rlRenderTextureAttach*(target: RenderTexture; id: cuint; attachType: cint)
##  Verify render texture is complete
proc rlRenderTextureComplete*(target: RenderTexture): bool

####  Vertex data management

##  Upload vertex data into GPU and provided VAO/VBO ids
proc rlLoadMesh*(mesh: ptr Mesh; dynamic: bool)
##  Update vertex or index data on GPU (upload new data to one buffer)
proc rlUpdateMesh*(mesh: Mesh; buffer: cint; num: cint)
##  Update vertex or index data on GPU, at index
proc rlUpdateMeshAt*(mesh: Mesh; buffer: cint; num: cint; index: cint)
##  Draw a 3d mesh with material and transform
proc rlDrawMesh*(mesh: Mesh; material: Material; transform: Matrix)
##  Unload mesh data from CPU and GPU
proc rlUnloadMesh*(mesh: Mesh)

# {.pop.}
