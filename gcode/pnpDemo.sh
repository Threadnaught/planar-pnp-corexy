#!/bin/bash
positions=(
	"0,0,0:-8.6,91.4,1"
	"20,-0.3,0:19.7,79.4,0"
	"39.7,-0.5,0:48,91.3,1"
	"39.7,19.5,0:59.9,119.5,0"
	"39.7,39.6,0:48.5,147.9,1"
	"19.6,39.5,0:20,159.8,0"
	"-0.3,39.9,0:-8.3,148.2,1"
	"-0.3,19.6,0:-20.1,119.7,0"
)

function gCode(){
	pos=$1
	tiltXOff="-40.9000"
	tiltYOff="-14.3000"
	xBase=$(echo $pos | cut -d ',' -f 2)
	yBase=$(echo $pos | cut -d ',' -f 1)
	if [[ $(echo $pos | cut -d ',' -f 3) == 0 ]]; then
		echo "G0 X$xBase Y$yBase A0 F5000 ;"
	else
		
		echo "G0 X$(awk "BEGIN {print $xBase + $tiltXOff; exit}") Y$(awk "BEGIN {print $yBase + $tiltYOff; exit}") A-45 F5000 ;"
	fi
}

for pos in ${positions[@]}; do
	from=$(echo $pos | cut -d ':' -f 1)
	to=$(echo $pos | cut -d ':' -f 2)

	cat <<- EOF
		G0 Z10 ;Raise
		$(gCode $from) ;Move over pick
		G0 Z0 ;Drop
		M41 ;Activate
		G4 S1 ;Wait to pick
		G0 Z10 ;Raise
		$(gCode $to) ;Move over place
		G0 Z0 ;Drop
		M40 ;Deactivate
		G4 S0.5 ;Wait to place
		G0 Z10 ;Raise

	EOF
done