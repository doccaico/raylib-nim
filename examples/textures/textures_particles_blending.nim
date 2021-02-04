import raylib

type
  Particle = object
    position: Vector2
    color: Color
    alpha: cfloat
    size: cfloat
    rotation: cfloat
    active: bool

const
  MAX_PARTICLES = 200
  screenWidth = 800
  screenHeight = 450

InitWindow(screenWidth, screenHeight, "raylib [textures] example - particles blending")

var mouseTail: array[MAX_PARTICLES, Particle]

for i in 0..<MAX_PARTICLES:
  mouseTail[i].position = Vector2(x: 0, y: 0)
  mouseTail[i].color = Color(
      r: GetRandomValue(0, 255).cuchar,
      g: GetRandomValue(0, 255).cuchar,
      b: GetRandomValue(0, 255).cuchar,
      a: 255.cuchar)
  mouseTail[i].alpha = 1.0
  mouseTail[i].size = GetRandomValue(1, 30)/20
  mouseTail[i].rotation = GetRandomValue(0, 360).cfloat
  mouseTail[i].active = false

var
  gravity = 3.0
  smoke = LoadTexture("resources/smoke.png")
  blending = BLEND_ALPHA

SetTargetFPS(60)

while not WindowShouldClose():
  var i = 0
  while i < MAX_PARTICLES:
    if not mouseTail[i].active:
      mouseTail[i].active = true
      mouseTail[i].alpha = 1.0
      mouseTail[i].position = GetMousePosition()
      i = MAX_PARTICLES
    inc i

  for i in 0..<MAX_PARTICLES:
    if mouseTail[i].active:
      mouseTail[i].position.y += gravity;
      mouseTail[i].alpha -= 0.01
      if mouseTail[i].alpha <= 0.0:
        mouseTail[i].active = false
      mouseTail[i].rotation += 5.0

  if IsKeyPressed(KEY_SPACE):
    blending = if blending == BLEND_ALPHA: BLEND_ADDITIVE else: BLEND_ALPHA

  BeginDrawing()
  ClearBackground(DARKGRAY)
  BeginBlendMode(blending.cint)

  for i in 0..<MAX_PARTICLES:
    if mouseTail[i].active:
      DrawTexturePro(smoke,
          Rectangle(x: 0.0, y: 0.0,
              width: smoke.width.cfloat,
              height: smoke.height.cfloat),
          Rectangle(x: mouseTail[i].position.x, y: mouseTail[i].position.y,
              width: smoke.width.cfloat*mouseTail[i].size,
              height: smoke.height.cfloat*mouseTail[i].size),
          Vector2(x: smoke.width.cfloat*mouseTail[i].size/2.0,
              y: smoke.height.cfloat*mouseTail[i].size/2.0),
          mouseTail[i].rotation,
          Fade(mouseTail[i].color, mouseTail[i].alpha))

  EndBlendMode()

  DrawText("PRESS SPACE to CHANGE BLENDING MODE", 180, 20, 20, BLACK)
  if blending == BLEND_ALPHA:
    DrawText("ALPHA BLENDING", 290, screenHeight - 40, 20, BLACK)
  else:
    DrawText("ADDITIVE BLENDING", 280, screenHeight - 40, 20, RAYWHITE)

  EndDrawing()

UnloadTexture(smoke)
CloseWindow()
