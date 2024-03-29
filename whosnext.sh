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

function pick_three_student {
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
  printf "And I pick 🤓"
  for times in {1..3}
  do
    rand_index=$[$RANDOM % ${#tmp_students_array[@]}]
    for number in {1..30}
    do
      student_index=$[$number % ${#tmp_students_array[@]}]
      sleep_time=$(echo "0.0001 + $number * 0.001" | bc)
      # a_student=$[$RANDOM % ${#tmp_students_array[@]}]
      printf '\n'
      echo " 🤔 Let's piiick, ${tmp_students_array[$student_index]}"
      # echo $sleep_time
      # echo ""
      sleep $sleep_time
      # printf '\e[1A\e[K'
      # printf '\e[1A\e[K'
      printf '\e[1A\e[K'
      printf '\e[1A\e[K'
    done
    echo "👉 ${tmp_students_array[$rand_index]}!"
    # erase the picked name
    unset 'tmp_students_array[$rand_index]'
  done
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
  for number in {1..30}
  do
    student_index=$[$number % ${#tmp_students_array[@]}]
    sleep_time=$(echo "0.0005 + $number * 0.005" | bc)
    # a_student=$[$RANDOM % ${#tmp_students_array[@]}]
    printf '\n'
    echo " 🤔 Let's piiick, ${tmp_students_array[$student_index]}"
    # echo $sleep_time
    # echo ""
    sleep $sleep_time
    # printf '\e[1A\e[K'
    # printf '\e[1A\e[K'
    printf '\e[1A\e[K'
    printf '\e[1A\e[K'
  done
  echo "------------"
  echo " ${tmp_students_array[$rand_index]}! 🤓"
  echo "------------"
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

function show_students {
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

  echo "The students list:"
  echo "${students}"
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
elif [ $1 == "three" ]
  # if arg is three
then
  pick_three_student
elif [ $1 == "reset" ]
  # if arg is reset
then
  reset_pick
elif [ $1 == "list" ]
  # if arg is list
then
  show_students
elif [ $1 == "set" ]
# if arg is set
then
  new_students ${2}
elif [[ "$1" =~ ^[0-9]+$ ]]
# if arg existing get the students in an array
then
  students_list ${1}
else
# if any other arguments (especially a comma spearated list)
  echo 'Wrong argument! try one of the following:'
  echo '- SET A STUDENT LIST:         whosnext set yann,trouni,sasha'
  echo '- LIST UP THE CURRENT LIST:   whosnext list'
  echo '- RESET THE STUDENT PICKS:    whosnext reset'
  echo '- SELECT ONE STUDENT:         whosnext three'
  echo '- SELECT 3 STUDENTS:          whosnext'
fi
