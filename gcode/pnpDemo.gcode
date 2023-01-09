G0 Z10 ;Raise
G0 X0 Y0 F5000 ;Move over pick
G0 Z0 ;Drop
M41 ;Activate
G4 S0.5 ;Wait to pick
G0 Z10 ;Raise
G0 X-8.284 Y91.716 F5000;Move over place
G0 Z0 ;Drop
M40 ;Deactivate
G4 S0.5 ;Wait to place
G0 Z10 ;Raise