#!/usr/bin/env bash

# Append boilerplate .gitignore(s) to the .gitignore in target directory.
# Written with the help of ChatGPT

GITIGNORE_DIR="$HOME/.local/share/bpgi/gitignore"

build_header() {
	local file="$1"
	local len="$2"

	local bar
	bar=$(printf '%*s' "$((len+31))" '' | tr ' ' '#')

	local text="#   Boilerplate ${file} .gitignore   #"
	printf `%s\n%s\n%s\n\n` "$bar" "$text" "$bar"

}

# Ensure GITIGNORE_DIR exists
if [[ ! -d $GITIGNORE_DIR ]]; then
	echo "ERROR: GITIGNORE_DIR does not exist"
	echo "       Update GITIGNORE_DIR in bpgi.sh, OR consider cloning" 
	echo "       .gitignore templates into existing GITIGNORE_DIR from:"
	echo "              https://github.com/github/gitignore"
	exit 1
fi

# Ensure one or more arguement was passed
if [[ $# -eq 0 ]]; then
	echo "Usage: bpgi <file1> [file2] [...]"
	exit 1
fi

# Append each file
for file in "$@"; do
	# Remove .gitignore suffix if supplied
	file="${file%.gitignore}"
	file_len="${#file}"

	# SECURITY: Reject path separators to prevent directory traversal
	if [[ "$file" == */* ]]; then
		echo "Error: Invalid character ('/') in '$file'"
		continue
	fi
	
	# SECURITY: Reject input if longer than 256 char
	if [[ "$file_len" -gt 256 || "$file_len" -lt 1 ]]; then
		echo "Error: Filename must be between 1 and 256 characters."
		continue
	fi

	fp="$GITIGNORE_DIR/$file.gitignore"
	cap_fp="$GITIGNORE_DIR/${file^}.gitignore"
	upper_fp="$GITIGNORE_DIR/${file^^}.gitignore"

	# Check that the file exists, then append
	if [[ -f "$fp" ]]; then
		build_header "$file" "$file_len" >> .gitignore
		cat "$fp" >> .gitignore
		echo "\n" >>.gitignore
		echo "Added: $file to .gitignore"
	elif [[ -f "$cap_fp" ]]; then
		echo "'$file'.gitignore does not exist. But '${file^}' was found."
		read -p "Add '${file^}?' (y/n): " confirm

		if [[ "$confirm" =~ ^([yY]|[yY][eE][sS])$ ]]; then
			build_header "${file^}" "$file_len" >> .gitignore
			cat "$cap_fp" >> .gitignore
			echo "\n" >>.gitignore
			echo "Added: ${file^} to .gitignore"
		else
			echo "Error: '$file'.gitignore does not exist."
			continue
		fi
	elif [[ -f "$upper_fp" ]]; then
		echo "'$file'.gitignore does not exist. But '${file^^}' was found."
		read -p "Add '${file^^}?' (y/n): " confirm

		if [[ "$confirm" =~ ^([yY]|[yY][eE][sS])$ ]]; then
			build_header "${file^^}" "$file_len" >> .gitignore
			cat "$upper_fp" >> .gitignore
			echo "\n" >>.gitignore
			echo "Added: ${file^^} to .gitignore"
		else
			echo "Error: '${file^^}'.gitignore does not exist."
			continue
		fi
	else
		echo "Error: '$file'.gitignore does not exist."
		exit 1
	fi
done
