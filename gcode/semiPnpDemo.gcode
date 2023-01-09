G0 Z10 ;Raise
G0 X0 Y0 A0 F5000 ; ;Move over pick
G0 Z0 ;Drop
M41 ;Activate
G4 S2 ;Wait to pick
G0 Z10 ;Raise
G0 X50.5 Y-22.9 A-45 F5000 ; ;Move over place
G0 Z0 ;Drop
M40 ;Deactivate
G4 S2 ;Wait to place
G0 Z10 ;Raise

G0 Z10 ;Raise
G0 X-0.3 Y20 A0 F5000 ; ;Move over pick
G0 Z0 ;Drop
M41 ;Activate
G4 S2 ;Wait to pick
G0 Z10 ;Raise
G0 X79.4 Y19.7 A0 F5000 ; ;Move over place
G0 Z0 ;Drop
M40 ;Deactivate
G4 S2 ;Wait to place
G0 Z10 ;Raise