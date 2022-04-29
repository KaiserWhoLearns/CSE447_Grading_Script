#!/bin/bash

read -p "Enter the path to student netIds: " student_list_path
while read line; do
    rm -rf $line
done <$student_list_path

rm -rf write-ups