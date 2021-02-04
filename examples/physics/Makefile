SRC = physics_demo.nim \
			physics_friction.nim \
			physics_movement.nim \
			physics_restitution.nim \
			physics_shatter.nim
PRG = $(basename $(SRC))

.PHONY: all clean

all: $(PRG)

$(PRG): $(SRC)
	nim c --passl:"-lraylib -lm" --hints:off $@

clean:
	rm -f $(PRG)
