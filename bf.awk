# Brainfuck interprater in AWK/GAWK <10maurycy10@gmail.com>
BEGIN {
        scan_idx = 0
        prog[0] = ""
}

{
	# read the program into prog[]
	# this might break on some awk's.
	split($0,chars,"")
	for (i = 1; i <= length($0); i++) {
		prog[scan_idx] = chars[i]
		scan_idx += 1
	}
}

END {
	tape[0] = 0
	tape_idx = 0
	e_idx = 0
	while (e_idx < scan_idx) {
		if (prog[e_idx] == "+") {
			# add one
			tape[tape_idx] += 1
		} else if (prog[e_idx] == "-") {
			# subtract one
			tape[tape_idx] -= 1
		} else if (prog[e_idx] == ">") {
			tape_idx += 1
		} else if (prog[e_idx] == "<") {
			tape_idx -= 1
		} else if (prog[e_idx] == ".") {
			printf "%c",tape[tape_idx]
		} else if (prog[e_idx] == ",") {
			printf "> "
			getline input<"/dev/tty"
			tape[tape_idx]=input
		} else if (prog[e_idx] == "[") {
			if (tape[tape_idx] == 0) {
				#skip to matching ]
				seek_ctr = 1
				seek_idx = e_idx
				while (seek_ctr > 0) {
					seek_idx += 1
					if (prog[seek_idx] == "[") {
						seek_ctr += 1
					}
					if (prog[seek_idx] == "]") {
						seek_ctr -= 1
					}
				}
				e_idx = seek_idx
			}
		} else if (prog[e_idx] == "]") {
			if (tape[tape_idx] != 0) {
				#skip to matching [
				seek_ctr = 1
				seek_idx = e_idx
				while (seek_ctr > 0) {
					seek_idx -= 1
					if (prog[seek_idx] == "]") {
						seek_ctr += 1
					}
					if (prog[seek_idx] == "[") {
						seek_ctr -= 1
					}
				}
				e_idx = seek_idx
			}
		}
		if (!(tape_idx in tape)) {
			tape[tape_idx] = 0
		}
		e_idx += 1
	}
}
