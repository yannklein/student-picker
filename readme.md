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

>> The remaining peeps: Yann,Trouni,Doug
>> 
>> And I pick...
>> 
>> ------------
>>  Trouni! 🤓
>> ------------
```
The list reinitialize itself automatically when there is no students left.
