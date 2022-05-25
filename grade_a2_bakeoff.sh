#!/bin/bash
# Authored by Kaiser Sun, Apr 28, 2022
# Grading script for CSE447/M557 at University of Washington
# Grade student's extra credits and rank their accuracy
# This is for assignment 1 extra credit

swapScores() {
  local tmp=${scores[$1]}
  scores[$1]=${scores[$2]}
  scores[$2]=$tmp
}

bubblesort() {
  local size=${#scores[@]} # Size of sortable items
  
  echo -e "\nArray size: $size"
  
  n=$size
  until (( n <= 0 )); do
    newn=0
    for ((i=0; i < n; i++)); do
      s_i=(${scores[i]})
      s_ip1=(${scores[i+1]})
      if [[ 
          ( ${#scores[i+1]} > 0 ) && \
          ( ${s_ip1[1]} > ${s_i[1]} )
      ]]; then
        swapScores $((i+1)) $i
        newn=$i
      fi
    done
    n=$newn
  done
  echo -e "Array sorted\n"
}

read -p "Enter the path to student netIds: " student_list_path
read -p "Enter language (en/nr) to eval: " language
read -p "Enter dev/test: " mode

scores=()
idx=0
while read line; do
    sub_msg=$(cd $line 2>&1)
    cd $line
    # Copy the hiddentest to student test
    rsync -a --delete ../a2-tests/ tests/
    rsync -a --delete ../a2-data/ data/

    test_msg=$(nosetests -s tests/test_bakeoff.py:test_${language}_${mode}_accuracy 2>&1)

    if [[ $test_msg == *"OK"* ]]
    then
        # Student submit the extra credit, compute their accuracy
        accuracy_msg=$(nosetests -s tests/test_bakeoff.py:test_${language}_${mode}_accuracy | grep "BONUS_TEST_ACC=")
        accuracy_list_format=($accuracy_msg)
        student_acc=${accuracy_list_format[1]}
        scores[$idx]="$line $student_acc"
        # scores+=("$line $student_acc")
        idx=$idx+1
    fi
    
    if [[ $sub_msg != *"No such file or directory"* ]]
    then
        cd ..
    fi
done <$student_list_path

bubblesort

printf '%s\n' "${scores[@]}"