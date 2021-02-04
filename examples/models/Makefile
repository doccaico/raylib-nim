SRC = models_animation.nim \
			models_billboard.nim \
			models_box_collisions.nim \
			models_cubicmap.nim \
			models_first_person_maze.nim \
			models_geometric_shapes.nim \
			models_heightmap.nim \
			models_loading.nim \
			models_mesh_generation.nim \
			models_mesh_picking.nim \
			models_orthographic_projection.nim \
			models_rlgl_solar_system.nim \
			models_waving_cubes.nim \
			models_yaw_pitch_roll.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c --passl:"-lraylib -lm" --hints:off $@

clean:
	rm -f $(PRG)
