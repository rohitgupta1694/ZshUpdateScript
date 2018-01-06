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

#Loop to read a file content line by line 
while IFS='' read -r line || [[ -n "$line" ]]; do
#	grep to extract command from each line.
	string="$(grep -Po "$2" <<< "$line")"

#	To count exact string in a file.
#	output1="$(grep -oF "$string" "$1" | wc -l)"
#	echo $output1

#	To delete occurances of exact string in a file.
#	output="$(sed -i "/$(echo "$string" | sed 's/\([[$~/\-]\)/\\\1/g')/d" "$1")"

	if [[ ${#commands[@]} -eq 0 ]]; then
		commands[$count]=$string
		count=$((count+1))
	elif [[ ! " ${commands[@]} " =~ " ${string} " ]]; then
		commands[$count]=$string
		count=$((count+1))
	fi
done < "$1"
#Loop ends

#To store content of array into a temporary file.
{ [ "${#commands[@]}" -eq 0 ] || printf '%s\n' "${commands[@]}"; } > .outputfile

#To delete the content of actual file.
true > "$1"

# Print file data line by line.
#while IFS='' read -r line; do
#       echo $line
#done < ".outputfile"

#To copy the data from temorary file to actual file.
cat .outputfile > $1

#To remove the temporary file.
rm .outputfile

echo "Script successfully completed."

