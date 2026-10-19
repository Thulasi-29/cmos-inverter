v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 170 -160 170 -140 {lab=vss}
N 170 -140 200 -140 {lab=vss}
N 100 -300 130 -300 {lab=in}
N 100 -300 100 -190 {lab=in}
N 100 -190 130 -190 {lab=in}
N 80 -240 100 -240 {lab=in}
N 170 -270 170 -220 {lab=out}
N 170 -240 270 -240 {lab=out}
N 170 -370 170 -330 {lab=vdd}
N 170 -370 180 -370 {lab=vdd}
N 170 -190 190 -190 {lab=vss}
N 190 -190 200 -190 {lab=vss}
N 200 -190 200 -140 {lab=vss}
C {sky130_fd_pr/nfet_01v8.sym} 150 -190 0 0 {name=M1
W=4.5
L=0.18
nf=3
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 150 -300 0 0 {name=M2
W=3
L=0.18
body=vdd
nf=3
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {ipin.sym} 80 -240 0 0 {name=p1 lab=in}
C {opin.sym} 270 -240 0 0 {name=p2 lab=out}
C {iopin.sym} 200 -140 0 0 {name=p3 lab=vss}
C {iopin.sym} 180 -370 0 0 {name=p4 lab=vdd}
