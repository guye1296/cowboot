AS = nasm
MSG = guy
OBJCOPY = objcopy
COWSAY = cowsay

cowboot: cowboot.bin
	$(OBJCOPY) -O binary --only-section=.text $< $@

cowboot.o : cowboot.S boot_message.o
	$(AS) -f elf -o $@ $<

boot_message.o: boot_message.cow
	$(OBJCOPY) -I binary -O elf32-i386 --rename-section .data=.cowdata $< $@

boot_message.cow:
	$(COWSAY) $(MSG) > $@

cowboot.bin: cowboot.o
	$(LD) -T pack_boot_section.ld cowboot.o boot_message.o -o cowboot.bin

clean:
	rm -f cowboot.o cowboot.bin cowboot boot_message.o
