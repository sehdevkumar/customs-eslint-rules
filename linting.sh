#!/bin/bash

username=$(whoami)

echo "This log file is generated for user: $username. Users can also change the folder paths. To do so, please visit the linting.log file and update the list to lint specific folders."


# Specify the output file for storing linting results
output_file="linting.log"
# Variable to store the total number of problems found during linting
totalProblems=0

# Specify the folders you want to lint
folders=("src/app")

# Remove the existing log file, if any
echo "Remove the Existing Log File"
rm -f $output_file

# Notify the user that the existing log file has been successfully removed
echo "File is Successfully Removed"

# Notify the user that the linting process has started
echo "Started Static code Linting Process......."

# Loop through the specified folders and lint the TypeScript files
for folder in "${folders[@]}"
   do
    # Notify the user about which folder is being linted
    echo "Linting files in folder: $folder $totalProblems"
    # Run the linting command and capture the output, then append it to the output file
    problems=$(npm run lint --lint-file-patterns="$folder/**/*.ts" 2>&1 | tee -a $output_file | grep -o '✖ [0-9]* problems' | head -n 1)
    # Add the number of problems found in the current folder to the totalProblems variable
    number=$(echo "$problems" | grep -o '[0-9]\+')
    totalProblems=$((totalProblems + number))
    # Add a separator line in the output file to distinguish results for different folders
    echo "--------------------End of Linting for $folder------------------" >> "$output_file"
   done

# Notify the user that the linting process is completed and mention the output file where results are saved
echo "Linting completed. Results have been saved to $output_file"
# Display the total number of problems found during the linting process
echo "Total Problems $totalProblems"
code $output_file
