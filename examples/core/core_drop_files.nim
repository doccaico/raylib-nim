import raylib

const
  screenWidth = 800
  screenHeight = 450

var
  count = 0.cint
  droppedFiles: cstringArray

InitWindow(screenWidth, screenHeight, "raylib [core] example - drop files")
SetTargetFPS(60)

while not WindowShouldClose():
  if IsFileDropped():
    droppedFiles = GetDroppedFiles(count.addr);
  BeginDrawing()
  ClearBackground(RAYWHITE)
  if count == 0:
    DrawText("Drop your files to this window!", 100, 40, 20, DARKGRAY)
  else:
    DrawText("Dropped files:", 100, 40, 20, DARKGRAY);
    for i in 0..<count:
      if i mod 2 == 0:
        DrawRectangle(0, 85 + 40*i, screenWidth, 40, Fade(LIGHTGRAY, 0.5))
      else:
        DrawRectangle(0, 85 + 40*i, screenWidth, 40, Fade(LIGHTGRAY, 0.3))
      DrawText(droppedFiles[i], 120, 100 + 40*i, 10, GRAY);
    DrawText("Drop new files...", 100, 110 + 40*count, 20, DARKGRAY)
  EndDrawing()
ClearDroppedFiles()
CloseWindow()
