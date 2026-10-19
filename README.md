# cmos-inverter

This repository contains the documentation of the work done for clearing the Physical Design screening test of ESSCI-SFAL-VSD VLSI Training program for Women.

The workshop describes the physical verification process that takes place during an RTL to GDSII flow using Skywater 130nm Technology, including DRC and LVS tests. This helps the participants get ready for the tape out and is particularly helpful for chip fabrication. The workshop assists in locating and fixing violations made during the physical verification stage.

More information about the workshop can be found at https://www.vlsisystemdesign.com/physical-verification-using-sky130/

A special thanks to Tim and Kunal for creating and helping out.

R. Timothy Edwards

Kunal Ghosh

# Index

- Chapter 0 - Getting the tools
- Chapter 1 - Project setup
- Chapter 2 - Schematic and symbol (xschem)
- Chapter 3 - Testbench and simulation (ngspice)
- Chapter 4 - Layout (Magic)
- Chapter 5 - Extraction and LVS (netgen)
---

# Chapter 0 - Getting the tools

1. Install [VirtualBox](https://www.virtualbox.org/).
2. Create an Ubuntu 22.04.5 VM (keep **3D acceleration off**, video memory 128 MB, at least 40 GB free disk on the host).
3. Install the tools: `magic`, `ngspice`, `xschem`, `netgen`, then `open_pdks` **last** so it links the xschem and magic directories.
<img width="1023" height="541" alt="toolchains" src="https://github.com/user-attachments/assets/cb995f6a-a73c-44a8-91b3-0dff323f2a5b" />

```
$ sudo apt-get update
$ sudo apt-get install<img width="1023" height="541" alt="toolchains" src="https://github.com/user-attachments/assets/ee17d0ea-38b9-4ce9-8d4f-766ec974dc26" />
 build-essential git tcl-dev tk-dev xterm
```

Verify the PDK exists:

```
$ ls /usr/local/share/pdk/sky130A
```

# Chapter 1 - Project setup

Create the working folders and link the PDK start-up files.

```
$ mkdir -p ~/inverter/xschem ~/inverter/mag ~/inverter/netgen

$ cd ~/inverter/xschem
$ cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc .
$ cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit

$ cd ../mag
$ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc

$ cd ../netgen
$ cp /usr/local/share/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl setup.tcl
```
# Chapter 2 - Schematic and symbol (xschem)

```
$ cd ~/inverter/xschem
$ xschem inverter.sch
```
<img width="1280" height="720" alt="VirtualBox_root_19_10_2026_15_33_06" src="https://github.com/user-attachments/assets/ba374620-0d33-4df2-98e8-ed80ee2c124d" />

Press **Insert** and pick `sky130_fd_pr` to place the transistors.

| Device | Model | W (um) | L (um) | nf |
|--------|-------|--------|--------|----|
| M1 (nmos) | `nfet_01v8` |4.5 | 0.18 | 3  |
| M2 (pmos) | `pfet_01v8` | 3 | 0.18  | 3  |

Pins: `in`, `out`, `vdd`, `vss`. Connect the pfet body to `vdd` and the nfet body to `vss`.

> **Image:** inverter schematic

![Inverter schematic](images/02_inverter_sch.png)<img width="1280" height="720" alt="VirtualBox_root_18_10_2026_21_07_56" src="https://github.com/user-attachments/assets/e79c9fdb-b760-4d98-a26a-efc8a6fe84fe" />


Create the symbol: **Ctrl+S**, then press **a** (Symbol, Make symbol from schematic).

> **Image:** inverter symbol

![Inverter symbol](images/03_inverter_sym.png)<img width="1280" height="720" alt="VirtualBox_root_19_10_2026_15_47_36" src="https://github.com/user-attachments/assets/af87d896-ef71-4a19-b445-fb1e7f3343ed" />


---

# Chapter 3 - Testbench and simulation (ngspice)

Place the `inverter` symbol in `inverter_tb.sch` with:

- `V1` = 1.8 V supply on `vdd`
- `V2` = input source on `in` (pulse or PWL)
- Library line (the file is `sky130.lib.spice`):

```
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
```

- Control block:

```
.control
tran 1n 1u
plot v(in) v(out)
.endc
```

Run **Netlist**, then **Simulate**. For simulation, keep *LVS netlist: top level is .subckt* **unticked**.

> **Image:** testbench schematic

![Testbench](images/04_inverter_tb.png)<img width="1280" height="720" alt="VirtualBox_root_18_10_2026_21_51_05" src="https://github.com/user-attachments/assets/9a27b64b-fd3f-4ff6-9c7c-0929b999e0f8" />


> **Image:** simulation waveform (`in` and `out`)

![Waveform](images/05_waveform.png)<img width="1280" height="720" alt="VirtualBox_root_18_10_2026_21_52_09" src="https://github.com/user-attachments/assets/78d9249a-fbc1-42c1-b48b-14f134ae5ae8" />


# Chapter 4 - Layout (Magic)

Create the netlist for layout import: open `inverter.sch`, tick **Options, LVS netlist: top level is .subckt**, **Ctrl+S**, then **Netlist**. Check line 2 of `inverter.spice` is `.subckt inverter ...` with no `**`.

Start Magic from the `mag` folder:

```
$ cd ~/inverter/mag
$ magic -d X11 -rcfile /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc
```

In the tkcon console:

```
% save inverter
```

Then **File, Import SPICE** and pick `~/inverter/xschem/inverter.spice`. The two transistors and the `in`, `out`, `vdd`, `vss` pin boxes appear.

> **Image:** Magic window after importing the netlist

![Imported netlist](images/07_magic_import.png)<img width="1280" height="720" alt="VirtualBox_root_19_10_2026_15_35_38" src="https://github.com/user-attachments/assets/6b558b00-b376-4d86-af89-9fecd307ac60" />


Route the layout:

1. Gates together with poly: this is `in`.
2. Drains together with metal1: this is `out`.
3. pfet source and body to the top rail: `vdd`.
4. nfet source and body to the bottom rail: `vss`.
5. Place each pin label on its metal and make it a port.

> **Image:** completed inverter layout with labels

![Final layout](images/10_layout_final.png)<img width="1280" height="720" alt="VirtualBox_root_19_10_2026_02_54_15" src="https://github.com/user-attachments/assets/efba4a70-db5c-49fc-932f-f0c88b81f008" />


Check DRC:

```
% drc check
% drc count
```

# Chapter 5 - Extraction and LVS (netgen)

Extract the layout netlist in tkcon:

```
% extract do local
% extract all
% ext2spice lvs
% ext2spice
```

Clean the intermediate files:

```
$ rm *.ext
```

> **Image:** extraction commands in tkcon

![Extraction](images/12_extract_commands.png)<img width="1280" height="720" alt="VirtualBox_root_19_10_2026_15_37_49" src="https://github.com/user-attachments/assets/56fc01e1-6677-478c-b784-83b4d166d8df" />


Run LVS with the sky130 setup file:

```
$ cd ~/inverter/netgen
$ netgen -batch lvs "../mag/inverter.spice inverter" "../xschem/inverter.spice inverter" \
    /usr/local/share/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl comp.out
$ tail -30 comp.out
```

Target result: `Circuits match uniquely.`

> **Image:** first LVS run (mismatch)

![LVS mismatch](images/13_lvs_mismatch.png)<img width="1280" height="720" alt="VirtualBox_root_19_10_2026_16_04_46" src="https://github.com/user-attachments/assets/1f78d80c-9d68-49d2-85e3-ea8b50b23d80" />

