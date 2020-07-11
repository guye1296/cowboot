MEMORY {
    ROM : ORIGIN = 0, LENGTH = 512
}

OUTPUT_ARCH(i386)
ENTRY(_start)

SECTIONS {
    . = ORIGIN(ROM);

    .text : {
        *(.text)
        text_end = .;
        /* write cow after code */
        cow_start = .;
        *(.cowdata)

        /* put boot magic at the end of the boot section */
        . = ORIGIN(ROM) + LENGTH(ROM) - 2;
        SHORT(0x55aa)
    } > ROM
}
