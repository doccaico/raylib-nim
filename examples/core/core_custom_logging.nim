import raylib

import times

proc vprintf(formatstr: cstring) {.
  importc: "vprintf", header: "<stdio.h>", varargs.}

proc logCustom(msgType: cint, text: cstring, args: VaList) {.cdecl.} =
  stdout.write("[" & getDateStr() & " " & getClockStr() & "] ")
  case msgType:
    of LOG_INFO:
      stdout.write("[INFO] : ")
    of LOG_ERROR:
      stdout.write("[ERROR]: ")
    of LOG_WARNING:
      stdout.write("[WARN] : ")
    of LOG_DEBUG:
      stdout.write("[DEBUG]: ")
    else: discard
  vprintf(text, args)
  stdout.write("\n")

const
  screenWidth = 800
  screenHeight = 450

SetTraceLogCallback(logCustom)
InitWindow(screenWidth, screenHeight, "raylib [core] example - custom logging")
SetTargetFPS(60)

while not WindowShouldClose():
  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawText("Check out the console output to see the custom logger in action!",
      60, 200, 20, LIGHTGRAY)
  EndDrawing()
CloseWindow()
