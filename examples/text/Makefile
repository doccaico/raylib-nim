SRC = text_font_filters.nim \
			text_font_loading.nim \
			text_font_sdf.nim \
			text_font_spritefont.nim \
			text_format_text.nim \
			text_input_box.nim \
			text_raylib_fonts.nim \
			text_rectangle_bounds.nim \
			text_unicode.nim \
			text_writing_anim.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c -d:PLATFORM_DESKTOP --passl:"-lraylib" --hints:off $@

clean:
	rm -f $(PRG)
