import raylib

{.passL: "-lm".}

proc sinf(x: cfloat): cfloat {.
  importc, header: "<math.h>".}

template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))

template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

template `[]=`[T](p: ptr T, off: int, val: T) =
  (p + off)[] = val

const
  MAX_SAMPLES = 512
  MAX_SAMPLES_PER_UPDATE = 4096
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [audio] example - raw audio streaming")

InitAudioDevice()

var
  stream = InitAudioStream(22050, 16, 1)
  data = cast[ptr cshort](alloc(cshort.sizeof*MAX_SAMPLES))
  writeBuf = cast[ptr cshort](alloc(cshort.sizeof*MAX_SAMPLES_PER_UPDATE))
  mousePosition = Vector2(x: -100.0, y: -100.0)
  frequency = 440.0.cfloat
  oldFrequency = 1.0.cfloat
  readCursor = 0.cint
  waveLength = 1.cint
  position = Vector2(x: 0.0, y: 0.0)

PlayAudioStream(stream)

SetTargetFPS(30)

while not WindowShouldClose():
  mousePosition = GetMousePosition()

  if IsMouseButtonDown(MOUSE_LEFT_BUTTON):
    var fp = mousePosition.y
    frequency = 40.0 + fp
  if frequency != oldFrequency:
    var oldWavelength = waveLength
    waveLength = (22050.0 / frequency).cint
    if waveLength > MAX_SAMPLES div 2: waveLength = MAX_SAMPLES div 2
    if waveLength < 1: waveLength = 1
    for i in 0..<waveLength*2:
      data[i] = (sinf(2*PI*i.cfloat / waveLength.cfloat)*32000).cshort
    readCursor = readCursor * (waveLength div oldWavelength)
    oldFrequency = frequency

  if IsAudioStreamProcessed(stream):
    var writeCursor = 0.cint
    while writeCursor < MAX_SAMPLES_PER_UPDATE:
      var writeLength = MAX_SAMPLES_PER_UPDATE - writeCursor
      var readLength = waveLength - readCursor
      if writeLength > readLength:
        writeLength = readLength
      copyMem(
          writeBuf[writeCursor].addr,
          data[readCursor].addr,
          writeLength*cshort.sizeof)
      readCursor = (readCursor + writeLength) mod waveLength
      writeCursor += writeLength
    UpdateAudioStream(stream, writeBuf, MAX_SAMPLES_PER_UPDATE)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawText(FormatText("sine frequency: %i",frequency.cint),
      GetScreenWidth() - 220, 10, 20, RED)
  DrawText("click mouse button to change frequency", 10, 10, 20, DARKGRAY)

  for i in 0..<screenWidth:
    position.x = i.cfloat
    position.y = (250 + 50*data[i*MAX_SAMPLES div screenWidth].cint div 32000).cfloat
    DrawPixelV(position, RED)

  EndDrawing()

dealloc(data)
dealloc(writeBuf)
CloseAudioStream(stream)
CloseAudioDevice()
CloseWindow()
