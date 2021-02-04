SRC = textures_background_scrolling.nim \
			textures_bunnymark.nim \
			textures_image_drawing.nim \
			textures_image_generation.nim \
			textures_image_loading.nim \
			textures_image_processing.nim \
			textures_image_text.nim \
			textures_logo_raylib.nim \
			textures_mouse_painting.nim \
			textures_npatch_drawing.nim \
			textures_particles_blending.nim \
			textures_raw_data.nim \
			textures_rectangle.nim \
			textures_sprite_button.nim \
			textures_sprite_explosion.nim \
			textures_srcrec_dstrec.nim \
			textures_to_image.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c --passl:"-lraylib" --hints:off $@

clean:
	rm -f $(PRG)
