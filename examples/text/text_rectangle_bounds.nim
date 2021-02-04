import raylib

const
  screenWidth = 800
  screenHeight = 450
  text = "Text cannot escape\tthis container\t...word wrap also works when active so " &
         "here's a long text for testing.\n\nLorem ipsum dolor sit amet, consectetur " &
         "adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna " &
         "aliqua. Nec ullamcorper sit amet risus nullam eget felis eget."
  minWidth = 60
  minHeight = 60
  maxWidth = screenWidth - 50
  maxHeight = screenHeight - 160

InitWindow(screenWidth, screenHeight, "raylib [text] example - draw text inside a rectangle")

var
  resizing = false
  wordWrap = true
  container = Rectangle(
      x: 25, y: 25,
      width: screenWidth - 50, height: screenHeight - 250)
  resizer = Rectangle(
      x: container.x + container.width - 17, y: container.y + container.height - 17,
      width: 14, height: 14)
  lastMouse: Vector2
  borderColor = MAROON
  font = GetFontDefault()

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_SPACE):
    wordWrap = not wordWrap
  var mouse = GetMousePosition()
  if CheckCollisionPointRec(mouse, container):
    borderColor = Fade(MAROON, 0.4)
  elif not resizing:
    borderColor = MAROON

  if resizing:
    if IsMouseButtonReleased(MOUSE_LEFT_BUTTON):
      resizing = false
    let width = container.width + (mouse.x - lastMouse.x)
    if width > minWidth:
      if width < maxWidth:
        container.width = width
      else:
        container.width = maxWidth
    else:
      container.width = minWidth
    let height = container.height + (mouse.y - lastMouse.y)
    if height > minHeight:
      if height < maxHeight:
        container.height = height
      else:
        container.height = maxHeight
    else:
      container.height = minHeight
  else:
    if IsMouseButtonDown(MOUSE_LEFT_BUTTON) and CheckCollisionPointRec(mouse, resizer):
      resizing = true

  resizer.x = container.x + container.width - 17
  resizer.y = container.y + container.height - 17
  lastMouse = mouse

  BeginDrawing()
  ClearBackground(RAYWHITE)

  DrawRectangleLinesEx(container, 3, borderColor)
  DrawTextRec(font, text,
     Rectangle(x: container.x + 4, y: container.y + 4, width: container.width - 4, height: container.height - 4),
     20.0, 2.0, wordWrap, GRAY)

  DrawRectangleRec(resizer, borderColor)

  DrawRectangle(0, screenHeight - 54, screenWidth, 54, GRAY)
  DrawRectangleRec(Rectangle(x: 382, y: screenHeight - 34, width: 12, height: 12), MAROON)

  DrawText("Word Wrap: ", 313, screenHeight-115, 20, BLACK)
  if wordWrap:
    DrawText("ON", 447, screenHeight - 115, 20, RED)
  else:
    DrawText("OFF", 447, screenHeight - 115, 20, BLACK)

  DrawText("Press [SPACE] to toggle word wrap", 218, screenHeight - 86, 20, GRAY)
  DrawText("Click hold & drag the    to resize the container", 155, screenHeight - 38, 20, RAYWHITE)

  EndDrawing()
CloseWindow()
