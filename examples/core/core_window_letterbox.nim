import raylib

proc ClampValue(val: Vector2, minval: Vector2, maxval: Vector2): Vector2 =
  result = val
  result.x = if result.x > maxval.x: maxval.x else: result.x
  result.x = if result.x < minval.x: minval.x else: result.x
  result.y = if result.y > maxval.y: maxval.y else: result.y
  result.y = if result.y < minval.y: minval.y else: result.y

const
  windowWidth = 800
  windowHeight = 450
  gameScreenWidth = 640
  gameScreenHeight = 480

SetConfigFlags(FLAG_WINDOW_RESIZABLE or FLAG_VSYNC_HINT)
InitWindow(windowWidth, windowHeight, "raylib [core] example - window scale letterbox")
SetWindowMinSize(320, 240)

var
  colors: array[10, Color]
  target = LoadRenderTexture(gameScreenWidth, gameScreenHeight)

for i in 0..<10:
  colors[i] = Color(r: GetRandomValue(100, 250).cuchar, g: GetRandomValue(50,
      150).cuchar, b: GetRandomValue(10, 100).cuchar, a: 255.cuchar)
SetTextureFilter(target.texture, FILTER_BILINEAR)

SetTargetFPS(60)

while not WindowShouldClose():
  let scale: float = min(
      GetScreenWidth() / gameScreenWidth, GetScreenHeight() / gameScreenHeight)
  if IsKeyPressed(KEY_SPACE):
    for i in 0..<10:
      colors[i] = Color(r: GetRandomValue(100, 250).cuchar, g: GetRandomValue(
          50, 150).cuchar, b: GetRandomValue(10, 100).cuchar, a: 255.cuchar)
  let mouse = GetMousePosition()
  var virtualMouse = Vector2(
    x: (mouse.x - (GetScreenWidth().float - (gameScreenWidth * scale)) * 0.5) / scale,
    y: (mouse.y - (GetScreenHeight().float - (gameScreenHeight * scale)) * 0.5) / scale)
  virtualMouse = ClampValue(virtualMouse, Vector2(x: 0.0, y: 0.0),
      Vector2(x: gameScreenWidth.cfloat, y: gameScreenHeight.cfloat))

  BeginDrawing()
  ClearBackground(BLACK)
  BeginTextureMode(target)
  ClearBackground(RAYWHITE)

  for i in 0.cint..<10:
    DrawRectangle(0, (gameScreenHeight/10).cint * i, gameScreenWidth,
        (gameScreenHeight/10).cint, colors[i])

  DrawText(
      """If executed inside a window,
      you can resize the window,
      and see the screen scaling!""", 10, 25, 20, WHITE)
  DrawText(TextFormat("Default Mouse: [%i , %i]", mouse.x.cint, mouse.y.cint),
      350, 25, 20, GREEN)
  DrawText(TextFormat("Virtual Mouse: [%i , %i]", virtualMouse.x.cint,
      virtualMouse.y.cint), 350, 55, 20, YELLOW)
  EndTextureMode()

  DrawTexturePro(
      target.texture,
      Rectangle(
          x: 0.0,
          y: 0.0,
          width: target.texture.width.cfloat,
          height: -target.texture.height.cfloat),
      Rectangle(
        x: (GetScreenWidth().float - (gameScreenWidth * scale)).cfloat * 0.5,
        y: (GetScreenHeight().float - (gameScreenHeight * scale)).cfloat * 0.5,
        width: gameScreenWidth.float * scale,
        height: gameScreenHeight.float * scale),
      Vector2(x: 0.0, y: 0.0),
      0.0,
      WHITE)
  EndDrawing()
UnloadRenderTexture(target)
CloseWindow()
