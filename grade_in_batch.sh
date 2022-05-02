#!/bin/bash

read -p "Enter the path to student netIds: " student_list_path
while read line; do
    echo "Grading student $line..."
    bash grade_a1.sh $line n
done <$student_list_path
