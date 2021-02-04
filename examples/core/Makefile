SRC = core_2d_camera.nim \
			core_2d_camera_platformer.nim \
			core_3d_camera_first_person.nim \
			core_3d_camera_free.nim \
			core_3d_camera_mode.nim \
			core_3d_picking.nim \
			core_basic_window.nim \
			core_custom_logging.nim \
			core_drop_files.nim \
			core_input_gamepad.nim \
			core_input_gestures.nim \
			core_input_keys.nim \
			core_input_mouse.nim \
			core_input_mouse_wheel.nim \
			core_input_multitouch.nim \
			core_random_values.nim \
			core_scissor_test.nim \
			core_storage_values.nim \
			core_vr_simulator.nim \
			core_window_letterbox.nim \
			core_world_screen.nim
PRG = $(basename $(SRC))

SRC2 = core_loading_thread.nim
PRG2 = $(basename $(SRC2))

.PHONY: all clean

all: $(PRG) $(PRG2)

$(PRG): $(SRC)
	nim c -d:PLATFORM_DESKTOP --passl:"-lraylib -lm" --hints:off $@

$(PRG2): $(SRC2)
	nim c --threads:on --passl:"-lraylib -lm" --hints:off $@

clean:
	rm -f $(PRG) $(PRG2)
