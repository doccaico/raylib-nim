SRC = shaders_basic_lighting.nim \
			shaders_custom_uniform.nim \
			shaders_eratosthenes.nim \
			shaders_fog.nim \
			shaders_julia_set.nim \
			shaders_model_shader.nim \
			shaders_palette_switch.nim \
			shaders_postprocessing.nim \
			shaders_raymarching.nim \
			shaders_shapes_textures.nim \
			shaders_simple_mask.nim \
			shaders_spotlight.nim \
			shaders_texture_drawing.nim \
			shaders_texture_waves.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c -d:PLATFORM_DESKTOP --passl:"-lraylib -lm" --hints:off $@

clean:
	rm -f $(PRG)
