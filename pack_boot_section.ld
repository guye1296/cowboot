MEMORY {
    ROM : ORIGIN = 0, LENGTH = 512
}

OUTPUT_ARCH(i8086)
ENTRY(_start)

SECTIONS {
    . = ORIGIN(ROM);

    .text : {
        *(.text)

        /* write cow after code */
        _cow_start = .; 
        *(.cowdata)
        _cow_len = . - _cow_start;

        /* put boot magic at the end of the boot section */
        . = ORIGIN(ROM) + LENGTH(ROM) - 2;
        BYTE(0x55)
        BYTE(0xaa)
    } > ROM
}
