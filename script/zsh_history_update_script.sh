#This script is made to remove all the extra lines which have multiple occurances in a file.
#Just add the file name and regex in the arguments to run the script.

#Variable to interate and count unique commands.
count=0

#Variable to store unique commands.
commands=()

#Variable to store actual file name passed in arguments.
actualfilename=$1

#To append any character or string in every line of a file.
#tempvar="$(sed -i "s/$/$/" "$1")"

if [ -z "$1" ]; then
	echo "Error: Please pass the file path as first argument."
fi

if [ -z "$2" ]; then
	echo "Error: Please pass the regex as second argument."
else
	echo "Progress Report: Script started..."	

#	Loop to read a file content line by line 
	while IFS='' read -r line || [[ -n "$line" ]]; do
#		grep to extract command from each line.
		string="$(grep -Po "$2" <<< "$line")"
#		Condition to check old commands and new commands to be added in the array.
		if [[ -z "$string" ]]; then
			commands[$count]=$line
                        count=$((count+1))
		elif [[ ${#commands[@]} -eq 0 ]]; then
			commands[$count]=$string
			count=$((count+1))
		elif [[ ! " ${commands[@]} " =~ " ${string} " ]]; then
			commands[$count]=$string
			count=$((count+1))
		fi

#               To count exact string in a file.
#               output1="$(grep -oF "$string" "$1" | wc -l)"
#               echo $output1

#               To delete occurances of exact string in a file.
#               output="$(sed -i "/$(echo "$string" | sed 's/\([[$~/\-]\)/\\\1/g')/d" "$1")"


	done < "$1"
#	Loop ends

#	To delete the content of actual file.
	true > "$1"

#	To store content of array into a temporary file.
	{ [ "${#commands[@]}" -eq 0 ] || printf '%s\n' "${commands[@]}"; } > $1

#	 Print file data line by line.
#	while IFS='' read -r line; do
#	       echo $line
#	done < ".outputfile"

#	To copy the data from temorary file to actual file.
#	cat .outputfile > $1

#	To remove the temporary file.
#	rm .outputfile

	echo "Progress Report: Script successfully completed."
fi
