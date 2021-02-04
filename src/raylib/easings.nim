from os import parentDir

const headerPath = currentSourcePath.parentDir() & "/include"

{.emit: "#include \"" & headerPath & "/easings.h\"".}

{.push cdecl, importc.}

##  Linear Easing functions
proc EaseLinearNone*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseLinearIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseLinearOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseLinearInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Sine Easing functions
proc EaseSineIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseSineOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseSineInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Circular Easing functions
proc EaseCircIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseCircOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseCircInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Cubic Easing functions
proc EaseCubicIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseCubicOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseCubicInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Quadratic Easing functions
proc EaseQuadIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseQuadOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseQuadInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Exponential Easing functions
proc EaseExpoIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseExpoOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseExpoInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Back Easing functions
proc EaseBackIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseBackOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseBackInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Bounce Easing functions
proc EaseBounceOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseBounceIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseBounceInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat

##  Elastic Easing functions
proc EaseElasticIn*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseElasticOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
proc EaseElasticInOut*(t: cfloat; b: cfloat; c: cfloat; d: cfloat): cfloat
