#! /bin/bash

tasks_file=~/.tasks

displayTasks() {
	IFS="|"
	line_number=1
	while read -r -a line
	do
		echo $line_number "${line[1]}" "${line[0]}"
		let line_number+=1
	done < "$tasks_file"
}

addTask() {
	echo $@ "|" `date` >> "$tasks_file"
	echo Created task: $@
}

deleteTask() {
	sed -i "" "$2"'d' "$tasks_file"
	echo Deleted task $2
} 

if [ $# -eq 0 ]
then
	displayTasks
else
	if [ $1 == "-d" ]
	then
		if [ $# -eq 2 ]
		then
			deleteTask $@
		else
			echo Please enter a task number to delete
		fi
	else
		addTask $@
	fi
fi

exit 0
