#[
*   raylib [core] example - 2d camera
*
*   Example complexity rating: [★★☆☆] 2/4
*
*   Example originally created with raylib 1.5, last time updated with raylib 3.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2025 Ramon Santamaria (@raysan5)
*   Modifications Copyright (c) 2026 doccaico
]#

import std / [math]

import raylib

const
  screenWidth = 800
  screenHeight = 450
  MAX_BUILDINGS = 100

InitWindow(screenWidth, screenHeight, "raylib [core] example - 2d camera")

var
  player = Rectangle(x: 400, y: 280.0, width: 40.0, height: 40.0)
  buildings: array[MAX_BUILDINGS, Rectangle]
  buildColors: array[MAX_BUILDINGS, Color]
  spacing = 0

for i in 0..<MAX_BUILDINGS:
  buildings[i].width = GetRandomValue(50, 200).cfloat
  buildings[i].height = GetRandomValue(100, 800).cfloat
  buildings[i].y = (screenHeight - 130 - buildings[i].height).cfloat
  buildings[i].x = (-6000 + spacing).cfloat
  spacing += buildings[i].width.int32
  buildColors[i] = Color(
      r: GetRandomValue(200, 240).uint8,
      g: GetRandomValue(200, 240).uint8,
      b: GetRandomValue(200, 250).uint8,
      a: 255)

var camera = Camera2D(
      offset: Vector2(x: player.x + 20.0, y: player.y + 20.0),
      target: Vector2(x: screenWidth/2.0, y: screenHeight/2.0),
      rotation: 0.0,
      zoom: 1.0)

SetTargetFPS(60)

while not WindowShouldClose():
  # Player movement
  if IsKeyDown(KEY_RIGHT.int32): player.x += 2
  elif IsKeyDown(KEY_LEFT.int32): player.x -= 2

  # Camera target follows player
  camera.target = Vector2(x: player.x + 20, y: player.y + 20)

  # Camera rotation controls
  if IsKeyDown(KEY_A.int32): camera.rotation -= 1.0
  elif IsKeyDown(KEY_S.int32): camera.rotation += 1.0

  # Limit camera rotation to 80 degrees (-40 to 40)
  if camera.rotation > 40: camera.rotation = 40
  elif camera.rotation < -40: camera.rotation = -40

  # Camera zoom controls
  # Uses log scaling to provide consistent zoom speed
  camera.zoom = exp(ln(camera.zoom) + (GetMouseWheelMove() * 0.1))

  if camera.zoom > 3.0: camera.zoom = 3.0
  elif camera.zoom < -0.1: camera.zoom = 0.1

  # Camera reset (zoom and rotation)
  if IsKeyPressed(KEY_R.int32):
    camera.zoom = 1.0
    camera.rotation = 0.0

  BeginDrawing()
  ClearBackground(RAYWHITE)

  BeginMode2D(camera)
  DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY)
  for i in 0..<MAX_BUILDINGS:
    DrawRectangleRec(buildings[i], buildColors[i])

  DrawRectangleRec(player, RED)
  DrawLine(camera.target.x.int32, -screenHeight * 10,
      camera.target.x.int32, screenHeight * 10, GREEN)
  DrawLine(-screenWidth * 10, camera.target.y.int32,
      screenWidth * 10, camera.target.y.int32, GREEN)
  EndMode2D()

  DrawText("SCREEN AREA", 640, 10, 20, RED)

  DrawRectangle(0, 0, screenWidth, 5, RED)
  DrawRectangle(0, 5, 5, screenHeight - 10, RED)
  DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED)
  DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED)

  DrawRectangle(10, 10, 250, 113, Fade(SKYBLUE, 0.5))
  DrawRectangleLines(10, 10, 250, 113, BLUE)

  DrawText("Free 2d camera controls:", 20, 20, 10, BLACK)
  DrawText("- Right/Left to move player", 40, 40, 10, DARKGRAY)
  DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
  DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY)
  DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)

  EndDrawing()
CloseWindow()
