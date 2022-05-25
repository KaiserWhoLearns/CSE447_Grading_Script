#!/bin/bash
# Authored by Kaiser Sun, Apr 28, 2022
# Grading script for Assignment 1, CSE447/M557 at University of Washington
# To change it to other assignment, change the name of .txt file
# The text file should be formated as "deliverable_index test_name that will be called in nosetests"
# Be sure to include a white space at the end of .txt file!!!

# read -p "Enter the student netId: " id
# read -p "Output error message (Y/n): " verbose
id=$1
verbose=$2
cd $id

pwd_msg=$(pwd 2>&1)
if [[ $pwd_msg != *"$id"* ]]
then
    echo "There is no corresponding directory for $id"
else
    rsync -a --delete ../a2-tests/ tests/
    rsync -a --delete ../a2-data/ data/
    final_err=""
    failed_summary="The failed tests are for delvierables "
    all_pass=true
    while read -r grading_idx test_name; do
        test_msg=$(nosetests $test_name 2>&1)
        # If the corresponding test passed
        if [[ $test_msg == *"OK"* ]] && [[ $test_msg != *"FAILED"* ]]
        then
            echo "Passed: Deliverable $grading_idx"
        else
            echo "Failed: Deliverable $grading_idx"
            all_pass=false
            final_err+=$test_msg
            failed_summary+="$grading_idx, "
        fi
    done <../test_names/a2_tests.txt
    if [[ $all_pass != true ]]
    then
        if [[ $verbose == *"Y"* ]]
        then
            echo "The student has some failed tests. Below are their error message: "
            echo "$final_err"
            echo "The student has some failed tests. Above are their error message."
        else
            echo "The student has some failed tests."
        fi
        echo "$failed_summary"
        echo "Be sure to check their code to see if we can give them some partial credits."
    else
        echo "This submission passed all the tests."
    fi
fi