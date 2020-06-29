BINARY=esc
DEVICE=stm32f407vgt6
OPENCM3_DIR=$(realpath libopencm3)
OBJS += $(patsubst %.c,%.o,$(wildcard src/*.c))

#CFLAGS          += -Os -ggdb3
#CPPFLAGS += -MD
LDFLAGS += -static -nostartfiles
LDLIBS += -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group

include $(OPENCM3_DIR)/mk/genlink-config.mk
include $(OPENCM3_DIR)/mk/gcc-config.mk

.PHONY: clean all

all: $(BINARY).elf $(BINARY).hex

clean:
	$(Q)$(RM) -rf $(BINARY).* *.o

flash: all
	st-flash --format ihex write $(BINARY).hex

opencm3:
	$(MAKE) -C $(OPENCM3_DIR)

include $(OPENCM3_DIR)/mk/genlink-rules.mk
include $(OPENCM3_DIR)/mk/gcc-rules.mk
