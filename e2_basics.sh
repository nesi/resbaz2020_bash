#!/bin/bash

# Returns the name of the script in this directory with the most lines.

# I am a comment.
file_type=".sh" # I am a variable.
most_lines=0
longest_script="" # I am an empty variable.

for filename in *${file_type}
do  
    num_lines=$(wc -l < ${filename}) # Using a 'subshell' executing the 'wc' command.
    echo "'$filename' is $num_lines lines long."
    if ((num_lines>=most_lines)) # Using a 'subshell'
    then
        most_lines=${num_lines}
        longest_script=${filename}
    fi
done
echo "---"
echo "'${longest_script}' is the longest script at ${most_lines} lines long."