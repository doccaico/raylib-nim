import raylib

proc strcpy(dest: cstring, src: cstring) {.
  importc: "strcpy", header: "<string.h>".}

const
  MAX_GESTURE_STRINGS = 20
  screenWidth = 800
  screenHeight = 450

var
  touchPosition = Vector2(x: 0.0, y: 0.0)
  touchArea = Rectangle(x: 220.0, y: 10.0, width: screenWidth - 230.0,
      height: screenHeight - 20.0)
  gesturesCount = 0.cint
  gestureStrings: array[MAX_GESTURE_STRINGS, array[32, cchar]]
  currentGesture = GESTURE_NONE
  lastGesture = GESTURE_NONE

InitWindow(screenWidth, screenHeight, "raylib [core] example - input gestures")
SetTargetFPS(60)

while not WindowShouldClose():
  lastGesture = currentGesture
  currentGesture = GetGestureDetected()
  touchPosition = GetTouchPosition(0)
  if CheckCollisionPointRec(touchPosition, touchArea) and currentGesture != GESTURE_NONE:
    if currentGesture != lastGesture:
      case currentGesture:
        of GESTURE_TAP:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE TAP")
        of GESTURE_DOUBLETAP:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE DOUBLETAP")
        of GESTURE_HOLD:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE HOLD")
        of GESTURE_DRAG:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE DRAG")
        of GESTURE_SWIPE_RIGHT:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE SWIPE RIGHT")
        of GESTURE_SWIPE_LEFT:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE SWIPE LEFT")
        of GESTURE_SWIPE_UP:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE SWIPE UP")
        of GESTURE_SWIPE_DOWN:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE SWIPE DOWN")
        of GESTURE_PINCH_IN:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE PINCH IN")
        of GESTURE_PINCH_OUT:
          strcpy(gestureStrings[gesturesCount].addr, "GESTURE PINCH OUT")
        else:
          discard
      inc gesturesCount
      if gesturesCount >= MAX_GESTURE_STRINGS:
        for i in 0..<MAX_GESTURE_STRINGS:
          strcpy(gestureStrings[i].addr, "\0");
        gesturesCount = 0

  BeginDrawing()
  ClearBackground(RAYWHITE)
  DrawRectangleRec(touchArea, GRAY)
  DrawRectangle(225, 15, screenWidth - 240, screenHeight - 30, RAYWHITE)
  DrawText("GESTURES TEST AREA", screenWidth - 270, screenHeight - 40, 20, Fade(
      GRAY, 0.5))
  for i in 0..<gesturesCount:
    if i mod 2 == 0:
      DrawRectangle(10, 30 + 20*i, 200, 20, Fade(LIGHTGRAY, 0.5))
    else:
      DrawRectangle(10, 30 + 20*i, 200, 20, Fade(LIGHTGRAY, 0.3))
    if i < gesturesCount - 1:
      DrawText(gestureStrings[i].addr, 35, 36 + 20*i, 10, DARKGRAY)
    else:
      DrawText(gestureStrings[i].addr, 35, 36 + 20*i, 10, MAROON)
  DrawRectangleLines(10, 29, 200, screenHeight - 50, GRAY)
  DrawText("DETECTED GESTURES", 50, 15, 10, GRAY)
  if currentGesture != GESTURE_NONE:
    DrawCircleV(touchPosition, 30, MAROON)
  EndDrawing()
CloseWindow()
