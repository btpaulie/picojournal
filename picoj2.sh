#!/bin/bash

# Default values

ENTRY=""
JOURNAL_FILE="$HOME/Journal.md"
DATE=
TIME=$(date +%I:%M\ %p)


# FUNCTIONS

#Function for add entry
add_entry(){
	#Prompt for Location
	read -p "Where are you writing from?" LOCATION

	# Prompt for Entry
        echo "Please add today's entry."
        read -e ENTRY

        # Append entry to file, with divider line
        echo -e "\n**$(date +%Y-%m-%d)**\nLocation: $LOCATION\n$ENTRY\n\n---" >> "$JOURNAL_FILE"
}

#Function for show help
show_help(){
	# Show help
        echo "Picojournal - a mini journaling program"
        echo "---------------------------------------"
        echo "Usage:"
        echo "  picojournal - launch the program"
	echo "  picojournal -h - show help"
}

# Parse terminal options

while getopts "help" opt; do
	case $opt in
		h)
			show_help
			exit 0
			;;
		e)
			add_entry
			exit 0
			;;
		p)
			pandoc -s -o export.pdf $JOURNAL_FILE
			exit 0
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
	esac
done	


# WITHOUT LAUNCH OPTION
# Print menu (no launch option specified by user)
echo "Picojournal - Paul's mini journal program"
echo "-----------------------------------------"
echo "Options:"
echo "  1. Add a new entry"
echo "  2. Show all entries"
echo "  3. Export to .PDF"
echo "  4. Help"
echo "  5. Quit"

# User makes choice

read -p "Enter your choice:" CHOICE

case "$CHOICE" in
	1)
		#add entry (call function) 
		add_entry
		exit 0
		;;
	2)
		# Show all entries
		cat "$JOURNAL_FILE"
		;;
	3)
		# Export .md to .PDF
		pandoc -s -o export.pdf $JOURNAL_FILE
		;;
	4) 
		# Show help
		show-help
		exit 0
		;;
	5) 
		# Quit
		echo "Ok fine be that way."
		exit 0
		;;
	6)
		# Invalid user choice
		echo "That's not an option, chief."
		;;
	esac



