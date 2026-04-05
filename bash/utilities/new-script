#!/usr/bin/env bash

#Exit if no arguments are present
if [[ $# -eq 0 ]]; then
	echo "At least one argument needed"
	exit 1

else 
	for item in "$@"; do
		if [[ ! -f "$item" ]]; then
			printf '#!/usr/bin/env bash\n' > "$item"
		else
			echo "Skipping: $item already exists"
			sleep 1
		fi
		chmod +x "$item"
	done
	
	#Open in nano if only one argument is given 
	if [[ $# -eq 1 ]]; then
		nano "$1"
	fi
fi


