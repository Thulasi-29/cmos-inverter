v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -190 -110 -150 {lab=#net1}
N -500 -190 -110 -190 {lab=#net1}
N -500 -190 -500 -140 {lab=#net1}
N -440 -150 -410 -150 {lab=in}
N -440 -150 -440 -140 {lab=in}
N -110 -110 -110 -80 {lab=0}
N -500 -80 -110 -80 {lab=0}
N -110 -130 -80 -130 {lab=out}
N -440 -180 -440 -150 {lab=in}
C {gnd.sym} -340 -80 0 0 {name=l1 lab=0}
C {opin.sym} -80 -130 0 0 {name=p1 lab=out}
C {opin.sym} -440 -180 0 0 {name=p2 lab=in}
C {vsource.sym} -440 -110 0 0 {name=V1 value="PWL(0 0 20n 0 900n 1.8)" savecurrent=false}
C {vsource.sym} -500 -110 0 0 {name=V2 value=1.8 savecurrent=false}
C {code_shown.sym} -700 -280 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {code_shown.sym} -690 -200 0 0 {name=s2 only_toplevel=false value=".control
tran 1n 1u
plot V(in) V(out)
.endc"}
