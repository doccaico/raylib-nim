SRC = audio_module_playing.nim \
			audio_music_stream.nim \
			audio_raw_stream.nim \
			audio_sound_loading.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c --passl:"-lraylib -lm" --hints:off $@

clean:
	rm -f $(PRG)
