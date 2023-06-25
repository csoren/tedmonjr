TARGETS = monitor.bin test.bin trampoline.bin

# Source files
ASM_FLAGS = -fb -mc1 -w0008 -ms1 -i. -isrc-mon -isrc-trampoline

# Paths
VPATH = src-mon src-test src-trampoline
DEPS_PATH = .deps

# Build rules
all: $(TARGETS)

test.bin: test.src monitor.bin | $(DEPS_PATH)
	@motor6502 $(ASM_FLAGS) -d$(DEPS_PATH)/$@.d -o$@ $<

monitor.bin: monitor.src trampoline.bin | $(DEPS_PATH)
	@motor6502 $(ASM_FLAGS) -d$(DEPS_PATH)/$@.d -o$@ $<

trampoline.bin: trampoline.src | $(DEPS_PATH)
	@motor6502 $(ASM_FLAGS) -d$(DEPS_PATH)/$@.d -o$@ $<

# Clean utility
clean:
	@rm -rf $(DEPS_PATH)
	@rm -f $(TARGETS)

# Make directory utility
$(DEPS_PATH): ; @mkdir -p $@

# Dependency files
DEP_FILES := $(TARGETS:%.bin=$(DEPS_PATH)/%.bin.d)

$(DEP_FILES):

include $(DEP_FILES)
