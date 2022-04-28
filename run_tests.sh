#!/bin/bash
read -p "Enter the student netId: " id
cd $id
for file in "tests/"
do
    nosetests $file
done
