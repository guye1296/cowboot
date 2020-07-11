AS = nasm
MSG = guy
OBJCOPY = objcopy

cowboot: cowboot.bin
	$(OBJCOPY) -O binary --only-section=.text $< $@

cowboot.o : cowboot.S boot_message.cow
	$(AS) -f elf -o $@ $<

boot_message.cow:
	cowsay $(MSG) > $@

cowboot.bin: cowboot.o
	$(LD) -T pack_boot_section.ld cowboot.o -o cowboot.bin

clean:
	rm -f cowboot.o cowboot.bin cowboot
