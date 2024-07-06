OUT_DIR=$(PWD)/out
SRC_DIR=$(PWD)/src

ENTRY_FILE=$(SRC_DIR)/main.asm
OUTPUT_FILE=$(OUT_DIR)/main

link: assemble
	gcc -o $(OUTPUT_FILE) -no-pie \
		$(OUT_DIR)/main.o \
		$(OUT_DIR)/modulo.o \
		$(OUT_DIR)/fizzbuzz.o

assemble: $(ENTRY_FILE) utils
	nasm \
		-f elf64 \
		-g \
		-F dwarf \
		$(ENTRY_FILE) \
		-o $(OUT_DIR)/main.o \
		-l $(OUT_DIR)/main.lst

utils: $(SRC_DIR)/utils/modulo.asm \
			 $(SRC_DIR)/utils/fizzbuzz.asm 
	nasm -f elf64 -g -F dwarf $(SRC_DIR)/utils/modulo.asm -o $(OUT_DIR)/modulo.o -l $(OUT_DIR)/modulo.lst
	nasm -f elf64 -g -F dwarf $(SRC_DIR)/utils/fizzbuzz.asm -o $(OUT_DIR)/fizzbuzz.o -l $(OUT_DIR)/fizzbuzz.lst
