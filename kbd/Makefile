# Assuming qmk keymap name is viktor-ku
# Assuming qmk keyboard in use is dztech/dz60rgb/v2

all: cp build

cp:
	cp -rf viktor-ku $(HOME)/qmk_firmware/keyboards/dztech/dz60rgb/keymaps

build:
	qmk compile

flash:
	qmk flash
