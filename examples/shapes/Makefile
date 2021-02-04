SRC = shapes_basic_shapes.nim \
			shapes_bouncing_ball.nim \
			shapes_collision_area.nim \
			shapes_colors_palette.nim \
			shapes_easings_ball_anim.nim \
			shapes_easings_box_anim.nim \
			shapes_easings_rectangle_array.nim \
			shapes_following_eyes.nim \
			shapes_lines_bezier.nim \
			shapes_logo_raylib.nim \
			shapes_logo_raylib_anim.nim \
			shapes_rectangle_scaling.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c --passl:"-lraylib -lm" --hints:off $@

clean:
	rm -f $(PRG)
