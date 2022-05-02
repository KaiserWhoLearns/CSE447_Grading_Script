
#!/bin/bash
# Authored by Kaiser Sun, Apr 28, 2022
# Grading script for CSE447/M557 at University of Washington
# Pulls students' submissions into current directory, with netid as their repo name

# There can be a better computation for how many late days, used. But now it works
# for our quater. This will not work if maximal late date happens at different month
# as the original due date.

# Pull the student repository with a given path to student netIds
read -p "Enter the path to student netIds: " student_list_path
read -p "Enter assignment index (1-4): " a_idx
read -p "Enter the deadline month (in abbrv, capitalize the first character) e.g. Mar: " ddl_month
read -p "Enter the deadline day: " ddl_day

mkdir write-ups

while read line; do
    clone_msg=$(git clone "git@gitlab.cs.washington.edu:cse447-sp2022/assignments/a$a_idx/CSE447-sp22-a$a_idx-$line.git" "$line" 2>&1)
    cd $line
    # Check out to the corresponding tag
    checkout_msg=$(git checkout "a$a_idx-final" 2>&1)
    if [[ $checkout_msg == *"error"* ]]
    then
        echo "Student $line has no submission!"
    else
        # Output the time information, format like this: "Date:   Mon Feb 28 15:30:27 2022 -0800"
        submission_date=$(git log -1 a$a_idx-final | grep "Date:")
        # Convert the date to date
        submission_date_list_format=($submission_date)
        if [[ ${submission_date_list_format[2]} == $ddl_month ]]
        then
            # Check if day is within deadline
            if [[ ${submission_date_list_format[3]} -gt $ddl_day ]]
            then
                echo "Student $line used late days for $((${submission_date_list_format[3]}-$ddl_day)) days!"
            fi
        fi

        # Copy the student's writeup to write-up
        cp -i *.pdf ../write-ups/$line.pdf
    fi
    pwd_msg=$(pwd 2>&1)

    if [[ $pwd_msg == *"$line"* ]]
    then
        cd ..
    fi
    
done <$student_list_path