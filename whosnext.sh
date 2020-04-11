#!/bin/zsh

# setting path for students.txt (inside this folder)
BASEDIR=$(dirname "$0")
STUDENTS_FILE="$BASEDIR/students.txt"

# function to join array element to string with separator
function join_by { local IFS="${1}"; shift; echo "$*"; }

function new_students() {
  if [ -e $STUDENTS_FILE ]
  then
  # if existing erase the file content
    # echo "file exist! remove file"
    `rm $STUDENTS_FILE`
  fi
  # create students file
  `touch $STUDENTS_FILE`
  # add students in the file
  echo "tmp:$1" >> $STUDENTS_FILE
  echo "list:$1" >> $STUDENTS_FILE
  echo "The new students list:"
  echo "${1}"
}

function pick_student {
  # read students from file
  while IFS='' read -r line
  do
    IFS=':' read -r -a line_array <<< "$line"
    # header=${line_array[0]}
    content=${line_array[1]}
    students+=($content)
  done < $STUDENTS_FILE
  echo "The remaining peeps: ${students[0]} "
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
  `rm $STUDENTS_FILE`
  `touch $STUDENTS_FILE`
  # add the new content
  echo "tmp:${tmp_joined_students}" >> $STUDENTS_FILE
  echo "list:${list_joined_students}" >> $STUDENTS_FILE
}
function reset_pick {
  # read students from file
  while IFS='' read -r line
  do
    IFS=':' read -r -a line_array <<< "$line"
    header=${line_array[0]}
    content=${line_array[1]}
    if [ $header == "list" ]
    then
      students=$content
    fi
  done < $STUDENTS_FILE

  # remove student.txt content
  `rm $STUDENTS_FILE`
  `touch $STUDENTS_FILE`
  # add the new content
  echo "tmp:${students}" >> $STUDENTS_FILE
  echo "list:${students}" >> $STUDENTS_FILE
  echo "Everyone's back in the picking game: ${students}"
}

function students_list() {
  # read students from file
  while IFS='' read -r line
  do
    IFS=':' read -r -a line_array <<< "$line"
    header=${line_array[0]}
    content=${line_array[1]}
    if [ $header == "list" ]
    then
      students=$content
    fi
  done < $STUDENTS_FILE

  IFS=',' read -r -a list_students <<< "${students}"

  for i in $( seq 1 $1 )
  do
    rand_index=$[$RANDOM % ${#list_students[@]}]
    if ! [ ${#list_students[@]} -eq 0 ]
    then
      picked_students+=("\"${list_students[$rand_index]}\"")
      unset 'list_students[$rand_index]'
      tmp_string=$(join_by , ${list_students[@]})
      IFS=',' read -r -a list_students <<< "${tmp_string}"
    fi
  done
  picked_students_string=$(join_by , ${picked_students[@]})
  echo "Here is an array of ${1} students:"
  echo " [${picked_students_string}] "
}

if ! [ ${1+x} ]
# if no arg run the program on existing students
then
  pick_student
elif [ $1 == "reset" ]
  # if arg is reset
then
  reset_pick
elif [[ "$1" =~ ^[0-9]+$ ]]
# if arg existing get the students in an array
then
  students_list ${1}
else
# if any other arguments (especially a comma spearated list)
  new_students ${1}
fi
