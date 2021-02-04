import raylib

import posix

# pass `--threads:on` to cmmand-line option

type clock_t = clong
proc clock(): clock_t {.
  importc: "clock", header: "<time.h>".}

template ATOMIC_VAR_INIT(val: untyped): untyped =
  (val)
type atomic_bool = bool
proc atomic_store(obj: ptr atomic_bool, desired: atomic_bool) {.
  importc: "atomic_store", header: "<stdatomic.h>".}
proc atomic_load(obj: ptr atomic_bool): atomic_bool {.
  importc: "atomic_load", header: "<stdatomic.h>".}

var dataLoaded: atomic_bool  = ATOMIC_VAR_INIT(false)
var dataProgress = 0.cint

proc LoadDataThread(arg: pointer): pointer {.noconv.} =
  var timeCounter = 0.cint
  var prevTime = clock()
  while timeCounter < 5000:
    var currentTime = clock() - prevTime
    timeCounter = (currentTime * 1000 / CLOCKS_PER_SEC).cint
    dataProgress = (timeCounter / 10).cint
  atomic_store(dataLoaded.addr, true)

type
  State = enum
    STATE_WAITING
    STATE_LOADING
    STATE_FINISHED

const
  screenWidth = 800
  screenHeight = 450

var
  threadId: Pthread
  state = STATE_WAITING
  framesCounter = 0

InitWindow(screenWidth, screenHeight, "raylib [core] example - loading thread")
SetTargetFPS(60)

while not WindowShouldClose():
  case state:
    of STATE_WAITING:
      if IsKeyPressed(KEY_ENTER):
        let error = pthread_create(threadId.addr, nil, LoadDataThread, nil)
        if error != 0:
          TraceLog(LOG_ERROR, "Error creating loading thread")
        else:
          TraceLog(LOG_INFO, "Loading thread initialized successfully")
        state = STATE_LOADING
    of STATE_LOADING:
      inc framesCounter
      if atomic_load(dataLoaded.addr):
        framesCounter = 0
        state = STATE_FINISHED
    of STATE_FINISHED:
      if IsKeyPressed(KEY_ENTER):
        atomic_store(dataLoaded.addr, false);
        dataProgress = 0
        state = STATE_WAITING

  BeginDrawing()
  ClearBackground(RAYWHITE)
  case state:
    of STATE_WAITING:
      DrawText("PRESS ENTER to START LOADING DATA", 150, 170, 20, DARKGRAY)
    of STATE_LOADING:
      DrawRectangle(150, 200, dataProgress, 60, SKYBLUE)
      if (framesCounter / 15).cint mod 2 != 0:
        DrawText("LOADING DATA...", 240, 210, 40, DARKBLUE)
    of STATE_FINISHED:
        DrawRectangle(150, 200, 500, 60, LIME)
        DrawText("DATA LOADED!", 250, 210, 40, GREEN)
  DrawRectangleLines(150, 200, 500, 60, DARKGRAY)
  EndDrawing()
CloseWindow()
