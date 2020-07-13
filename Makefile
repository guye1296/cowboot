AS = nasm
MSG = guy
OBJCOPY = objcopy
COWSAY = cowsay
UNIX2DOS = unix2dos

cowboot: cowboot.elf
	$(OBJCOPY) -O binary --only-section=.text $< $@

cowboot.o : cowboot.S
	$(AS) -f elf -o $@ $<

boot_message.o: boot_message.cow
	$(OBJCOPY) -I binary -O elf32-i386 --rename-section .data=.cowdata $< $@

boot_message.cow:
	$(COWSAY) $(MSG) > $@
	$(UNIX2DOS) $@

cowboot.elf: pack_boot_section.ld cowboot.o boot_message.o
	$(LD) -T $< $(filter %.o, $^) -o $@

debug: cowboot.S
	$(AS) -f elf -g $< -o cowboot.dbg.elf



clean:
	rm -f *.o *.bin *.cow cowboot
