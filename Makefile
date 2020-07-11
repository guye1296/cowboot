AS = nasm
MSG = guy
OBJCOPY = objcopy
COWSAY = cowsay

cowboot: cowboot.bin
	$(OBJCOPY) -O binary --only-section=.text $< $@

cowboot.o : cowboot.S
	$(AS) -f elf -o $@ $<

boot_message.o: boot_message.cow
	$(OBJCOPY) -I binary -O elf32-i386 --rename-section .data=.cowdata $< $@

boot_message.cow:
	$(COWSAY) $(MSG) > $@

cowboot.bin: pack_boot_section.ld cowboot.o boot_message.o
	$(LD) -T $< $(filter %.o, $^) -o $@

clean:
	rm -f *.o *.bin *.cow cowboot
