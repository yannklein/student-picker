#!/bin/zsh

# function to join array element to string with separator
function join_by { local IFS="${1}"; shift; echo "$*"; }

if [ ${1+x} ]
# if arg existing get the students in an array
then
  if [ -e students.txt ]
  then
  # if existing erase the file content
    # echo "file exist! remove file"
    `rm students.txt`
  fi
  # add students in the file
  `touch students.txt`
  echo "tmp:$1" >> students.txt
  echo "list:$1" >> students.txt
  echo "The new students list: ${1}"

# if no arg run the program on existing students
else
  # read students from file
  while IFS='' read -r line
  do
    IFS=':' read -r -a line_array <<< "$line"
    # header=${line_array[0]}
    content=${line_array[1]}
    students+=($content)
  done < students.txt
  echo ""
  echo "The remaining peeps: ${students[0]} "
  echo ""
  # create an array of students
  IFS=',' read -r -a tmp_students_array <<< "${students[0]}"
  IFS=',' read -r -a list_students_array <<< "${students[1]}"
  # get one name random
  rand_index=$[$RANDOM % ${#tmp_students_array[@]}]
  printf "And I pick"
  sleep 0.5
  printf "."
  sleep 0.5
  printf "."
  sleep 0.5
  printf "."
  sleep 0.5
  echo " "
  echo " "
  echo "------------"
  echo " ${tmp_students_array[$rand_index]}! 🤓"
  echo "------------"
  echo ""
  # erase the picked name
  unset 'tmp_students_array[$rand_index]'
  # echo "The remaining students: ${tmp_students_array[@]}"
  # repopulating if no more students
  if [ ${#tmp_students_array[@]} -eq 0 ]
  then
    tmp_students_array=${list_students_array[@]}
  fi
  # update student.txt
  # create the lists with commas
  tmp_joined_students=$(join_by , ${tmp_students_array[@]})
  list_joined_students=$(join_by , ${list_students_array[@]})
  # remove student.txt content
  `rm students.txt`
  `touch students.txt`
  # add the new content
  echo "tmp:${tmp_joined_students}" >> students.txt
  echo "list:${list_joined_students}" >> students.txt
fi

