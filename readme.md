# A simple bash student picker

## Initialize the student list
Run the program with a list (CSV style) of students.
```
$ sh whosnext.sh Yann,Doug,Trouni

>> The new students list: Yann,Trouni,Doug
```

## Pick a student from the list
Run the program with no arguments
```
$ sh whosnext.sh
>>
>> The remaining peeps: Yann,Trouni,Doug
>> 
>> And I pick...
>> 
>> ------------
>>  Trouni! 🤓
>> ------------
>> 
```
The list reinitialize itself automatically when there is no students left.

## Reset the student pick, to pick back on the full list
Run the program `reset`
```
$ sh whosnext.sh reset
>> Everyone's back in the picking game: Yann,Trouni,Doug
```

## Show the student full list
Run the program `list`
```
$ sh whosnext.sh list
>> The students list:
>> Yann,Trouni,Doug
```

## Get an array of students
Run the program with an Integer (1,23,100,..)
```
$ sh whosnext.sh 2
>>
>> Here is an array of 2 students:
>> ["Yann","Trouni"]
>> 
```
