## Assignment Grading Pipeline
(Why am I saying pipeline here? It sounds cool!)

This repository contains the grading scripts for [CSE447/M547 NLP spring 2022](https://courses.cs.washington.edu/courses/cse447/22sp/) at University of Washington. This course is originallly from [CS11711 (Algorithms for NLP) at CMU](http://demo.clab.cs.cmu.edu/11711fa20/).

This directory will be the directory you use for grading. Every script assumes that you run it under this directory.

#### Step 1. Pull student's submission
Code input:
```bash
bash pull_student_assginments.sh
> Enter the path to student netIds: students_list.txt
> Enter assignment index (1-4): 1
> Enter assignment index (1-4): Apr
> Enter the deadline day: 25
```
* **What you will need:** A `.txt` list of student netids.
* Be sure to include a blank line at the end of `.txt` file!
* This script will clone all the student's submission into your directory with netid as the directory name.
* It will also copy the write-up files into the subdirectory `write-ups`.
* This script will also output the **number of late days** the student used (if they used any) and if they have no submission.

#### Step 2. Grade the students' coding submissions.
On Canvas, go through each student's netId and log their scores on the grading dashboard. Be sure to finalize the Canvas grading rubric first. 

Code input:
```bash
bash grade_a1.sh
> Enter the student netId: netid
> Output error message (Y/n): n
```
Sample output:
```
Passed: Deliverable 1.1
Passed: Deliverable 1.2
Passed: Deliverable 1.3
...
Passed: Deliverable 7.1
Passed: Deliverable 7.2
This submission passed all the tests.
```

#### Step 3. Grade the students' write-ups
The write-ups will be in the subdirectory `write-ups` with the student net id `.pdf` as the name.

#### Step 4. Release the grades, chill, and wait for regrade requests :)