ASM = nasm

all:
	@echo "- Flip OS -"
	@echo "make       - Build Help"
	@echo "make build - Build FOS"
	@echo "make clean - Clean Build"
	@echo "make run   - Run FOS in QEMU"

build: flip.asm
	mkdir -p build
	$(ASM) -f bin flip.asm -o build/Flip.img
	cp Flip.bochsrc build/Flip.bochsrc || true

clean:
	rm -rf build

run:
	qemu-system-i386 -fda build/Flip.img
