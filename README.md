# FOS (Flip OS)

![Demo](.github/demo.gif)

**A Minimalist Low-Level Visualization Kernel**

FOS is a lightweight, bare-metal operating system written entirely in **x86 Assembly (NASM)**. It is designed specifically for performance testing and graphics validation within the **Bochs** emulator on the **Light OS** environment.

By bypassing the overhead of a traditional terminal or file system, FOS interacts directly with the hardware to produce a high-frequency "static noise" or "flip" effect across the entire VGA spectrum.

### 1. Technical Specifications

* **Architecture:** 16-bit Real Mode (x86).
* **Platform:** DOS/MBR-compatible bootsector.
* **Form Factor:** Exactly **512 bytes** (including the `0xAA55` boot signature) Floppy Disk Image (.img).
* **Graphics Standard:** VGA Mode 13h.

### 2. Video Subsystem

FOS utilizes the legacy **BIOS Interrupt 10h** to initialize the display. Unlike modern operating systems that use complex drivers, FOS writes directly to the **Linear Frame Buffer**:

* **Resolution:** 320x200 pixels.
* **Color Depth:** 8-bit Indexed Color (256-color palette).
* **Memory Mapping:** Direct access via segment `0xA000:0000`.
* **Visual Logic:** The kernel employs a Linear Congruential Generator (LCG) combined with hardware entropy from the System Timer (PIT Port 0x40) to ensure high-speed, non-repeating pixel patterns.

### 3. Interactive Speed Control

The kernel includes a real-time interrupt handler for keyboard input (IRQ1), allowing the user to modulate the processing load and visual frequency on the fly:

* **[ + ] Key (or =):** Increases the refresh frequency by reducing the CPU delay cycles (Accelerates the "noise").
* **[ - ] Key:** Decreases the frequency by injecting additional wait states.
* **Zero-State:** The system can be throttled down to a complete "Freeze" state, effectively pausing the kernel's execution loop until speed is increased.

### 4. Build Instructions

To compile the OS from source, use the **Makefile**:

```bash
make build
```

Everything that is built will be in the 'build' folder. You can run it via make without leaving the folder where the Makefile is located. Just type 'make run' in the terminal to run it via QEMU. The .bochsrc file is only needed for Bochs in Light OS, which is what it was built for, but the Makefile is just for building and additional debugging.

Besides compiling, you can also use help, which contains more commands:

```bash
make
```

The help command is just `make`

The resulting `Flip.img` in build dir is a bootable binary that can be mounted as a floppy disk in any x86 virtual machine or flashed to a physical USB drive for testing on real hardware.

---

### Project Goal

FOS was created to demonstrate the capabilities of minimal code. By placing a fully interactive graphical environment on a single disk sector, it serves as a base tool for Light OS and, there, as a testbed for Bochs, an example of an OS. Floppy disk .img x86
