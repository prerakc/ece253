onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label Clock /lab5part1/clk
add wave -noupdate -label D /lab5part1/D
add wave -noupdate -label Qa /lab5part1/Qa
add wave -noupdate -label Qb /lab5part1/Qb
add wave -noupdate -label Qc /lab5part1/Qc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {513974 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {525 ns}
