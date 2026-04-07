#!/usr/bin/env bash

set -e

#Supports apt, dnf, pacman

if command -v pacman &> /dev/null; then
	if sudo pacman -Syu; then
		echo -e "\e[32mUpdate successful!\e[0m"
	else
		echo -e "\e[31mUpdate failed!\e[0m"
		exit 1
	fi
elif command -v apt &> /dev/null; then
	if sudo apt update && sudo apt upgrade -y; then
		echo -e "\e[32mUpdate successful!\e[0m"
	else
		echo -e "\e[31mUpdate failed!\e[0m"
		exit 1
	fi
elif command -v dnf &> /dev/null; then
	if sudo dnf update -y; then
		echo -e "\e[32mUpdate successful!\e[0m"
	else
		echo -e "\e[31mUpdate failed!\e[0m"
		exit 1
	fi
else
	echo -e "\e[31mUnsupported system\e[0m"
	exit 1


fi
