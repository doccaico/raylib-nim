import raylib

when defined(PLATFORM_DESKTOP):
    const GLSL_VERSION = 330
else:
    const GLSL_VERSION = 100

const
  screenWidth = 800
  screenHeight = 450

const POINTS_OF_INTEREST = [
    [cfloat(-0.348827), 0.607167],
    [cfloat(-0.786268), 0.169728],
    [cfloat(-0.8), 0.156],
    [cfloat(0.285), 0.0],
    [cfloat(-0.835), -0.2321],
    [cfloat(-0.70176), -0.3842]]

InitWindow(screenWidth, screenHeight, "raylib [shaders] example - julia sets")

var
  shader = LoadShader(nil, FormatText("resources/shaders/glsl%i/julia_set.fs",
      GLSL_VERSION))
  c = [POINTS_OF_INTEREST[0][0], POINTS_OF_INTEREST[0][1]]
  offset = [(-screenWidth/2).cfloat, -screenHeight/2 ]
  zoom = 1.0.cfloat
  offsetSpeed = Vector2(x: 0.0, y: 0.0)
  cLoc = GetShaderLocation(shader, "c")
  zoomLoc = GetShaderLocation(shader, "zoom")
  offsetLoc = GetShaderLocation(shader, "offset")
  screenDims = [screenWidth.cfloat, screenHeight]
  target = LoadRenderTexture(screenWidth, screenHeight)
  incrementSpeed = 0.cint
  showControls = true
  pause = false

SetShaderValue(shader, GetShaderLocation(shader, "screenDims"),
    cast[ptr cfloat](screenDims.addr), UNIFORM_VEC2)
SetShaderValue(shader, cLoc, cast[ptr cfloat](c.addr), UNIFORM_VEC2)
SetShaderValue(shader, zoomLoc, zoom.addr, UNIFORM_FLOAT)
SetShaderValue(shader, offsetLoc, cast[ptr cfloat](offset.addr), UNIFORM_VEC2)

SetTargetFPS(60)

while not WindowShouldClose():
  if IsKeyPressed(KEY_ONE) or IsKeyPressed(KEY_TWO) or IsKeyPressed(KEY_THREE) or
      IsKeyPressed(KEY_FOUR) or IsKeyPressed(KEY_FIVE) or IsKeyPressed(KEY_SIX):

    if IsKeyPressed(KEY_ONE):
      c[0] = POINTS_OF_INTEREST[0][0]
      c[1] = POINTS_OF_INTEREST[0][1]
    elif IsKeyPressed(KEY_TWO):
      c[0] = POINTS_OF_INTEREST[1][0]
      c[1] = POINTS_OF_INTEREST[1][1]
    elif IsKeyPressed(KEY_THREE):
      c[0] = POINTS_OF_INTEREST[2][0]
      c[1] = POINTS_OF_INTEREST[2][1]
    elif IsKeyPressed(KEY_FOUR):
      c[0] = POINTS_OF_INTEREST[3][0]
      c[1] = POINTS_OF_INTEREST[3][1]
    elif IsKeyPressed(KEY_FIVE):
      c[0] = POINTS_OF_INTEREST[4][0]
      c[1] = POINTS_OF_INTEREST[4][1]
    elif IsKeyPressed(KEY_SIX):
      c[0] = POINTS_OF_INTEREST[5][0]
      c[1] = POINTS_OF_INTEREST[5][1]

    SetShaderValue(shader, cLoc, cast[ptr cfloat](c.addr), UNIFORM_VEC2)

  if IsKeyPressed(KEY_SPACE): pause = not pause
  if IsKeyPressed(KEY_F1): showControls = not showControls

  if not pause:
    if IsKeyPressed(KEY_RIGHT): inc incrementSpeed
    elif IsKeyPressed(KEY_LEFT): dec incrementSpeed

    if IsMouseButtonDown(MOUSE_LEFT_BUTTON) or IsMouseButtonDown(MOUSE_RIGHT_BUTTON):
      if IsMouseButtonDown(MOUSE_LEFT_BUTTON): zoom += zoom*0.003
      if IsMouseButtonDown(MOUSE_RIGHT_BUTTON): zoom -= zoom*0.003

      var mousePos = GetMousePosition()

      offsetSpeed.x = mousePos.x - screenWidth/2
      offsetSpeed.y = mousePos.y - screenHeight/2

      offset[0] += GetFrameTime()*offsetSpeed.x*0.8
      offset[1] += GetFrameTime()*offsetSpeed.y*0.8
    else:
      offsetSpeed = Vector2(x: 0.0, y: 0.0)

    SetShaderValue(shader, zoomLoc, zoom.addr, UNIFORM_FLOAT)
    SetShaderValue(shader, offsetLoc, cast[ptr cfloat](offset.addr), UNIFORM_VEC2)

    var  amount = GetFrameTime()*incrementSpeed.cfloat*0.0005
    c[0] += amount
    c[1] += amount
    SetShaderValue(shader, cLoc, cast[ptr cfloat](c.addr), UNIFORM_VEC2)

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginTextureMode(target)
  ClearBackground(BLACK)
  DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), BLACK)
  EndTextureMode()

  BeginShaderMode(shader)
  DrawTexture(target.texture, 0, 0, WHITE)
  EndShaderMode()

  if showControls:
    DrawText("Press Mouse buttons right/left to zoom in/out and move",
        10, 15, 10, RAYWHITE)
    DrawText("Press KEY_F1 to toggle these controls",
        10, 30, 10, RAYWHITE)
    DrawText("Press KEYS [1 - 6] to change point of interest",
        10, 45, 10, RAYWHITE)
    DrawText("Press KEY_LEFT | KEY_RIGHT to change speed",
        10, 60, 10, RAYWHITE)
    DrawText("Press KEY_SPACE to pause movement animation",
        10, 75, 10, RAYWHITE)

  EndDrawing()

UnloadShader(shader)
UnloadRenderTexture(target)
CloseWindow()
