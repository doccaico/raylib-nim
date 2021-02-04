from os import parentDir
from raylib import Vector3, Color, Shader

const headerPath = currentSourcePath.parentDir() & "/include"

{.localPassC:"-DRLIGHTS_IMPLEMENTATION".}
{.emit: "#include <raylib.h>".}
{.emit: "#include \"" & headerPath & "/rlights.h\"".}

## ----------------------------------------------------------------------------------
##  Defines and Macros
## ----------------------------------------------------------------------------------

const
  MAX_LIGHTS* = 4

##  Light data

type
  Light* {.bycopy.} = object
    `type`*: cint
    position*: Vector3
    target*: Vector3
    color*: Color
    enabled*: bool             ##  Shader locations
    enabledLoc*: cint
    typeLoc*: cint
    posLoc*: cint
    targetLoc*: cint
    colorLoc*: cint

##  Light type

# type
#   LightType* = enum

const
  LIGHT_DIRECTIONAL* = 0
  LIGHT_POINT* = 1

var lightsCount*: cint = 0

{.push cdecl, importc.}

##  Create a light and get shader locations
proc CreateLight*(`type`: cint; position: Vector3; target: Vector3; color: Color;
                 shader: Shader): Light
##  Send light properties to shader
##  NOTE: Light shader locations should be available
proc UpdateLightValues*(shader: Shader; light: Light)
