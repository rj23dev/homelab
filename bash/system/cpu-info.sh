#!/usr/bin/env bash

lscpu | awk -F: ' $1=="Model name" {
		       gsub(/^[ \t]+|[ \t]+$/, "", $2); 
		       model=$2 
		  }
	          $1=="CPU(s)" {
		       gsub(/^[ \t]+|[ \t]+$/, "", $2); 
		       threads=$2 
		  }
		  $1=="Core(s) per socket" { 
		       sub(/^[ \t]+|[ \t]+$/, "", $2); 
		       coresPerSockets=$2 
		  }
		  $1=="Socket(s)" {
		       gsub(/^[ \t]+|[ \t]+$/, "", $2); 
		       sockets=$2 
		  }

		END {
			cores = coresPerSockets * sockets 
			printf "Model: %s\nThreads: %s\nCores: %d\n", model, threads, cores
}
'
