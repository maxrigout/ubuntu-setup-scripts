#!/bin/bash

# https://stackoverflow.com/questions/38794449/creating-array-of-objects-in-bash
# declare -rA installoption0=(
# 	[name]='ssh'
# 	[script]='./install-scripts/install-ssh.sh'
# )
# declare -rA installoption1=(
# 	[name]='vscode'
# 	[script]='./install-scripts/install-vscode.sh'
# )
# declare -rA installoption2=(
# 	[name]='docker'
# 	[script]='./install-scripts/install-docker.sh'
# )

# declare -n installoption

# installArray=() # https://stackoverflow.com/questions/1951506/add-a-new-element-to-an-array-without-specifying-the-index-in-bash

# checklistOptions=""
# index=0

# for installoption in ${!installoption@}; do
# 	installArray+=(${installoption})
# 	label=${installoption[name]}
# 	value=$index
# 	checklistOptions="$checklistOptions $value $label off"
# 	((index++)) # https://askubuntu.com/questions/385528/how-to-increment-a-variable-in-bash
# done

# TODO: scan directory to get all the scripts
BASE_SCRIPT_DIR="./install-scripts"
installScripts=("${BASE_SCRIPT_DIR}/install-open-ssh.sh" "${BASE_SCRIPT_DIR}/install-open-vpn.sh" "${BASE_SCRIPT_DIR}/install-mysql.sh" "${BASE_SCRIPT_DIR}/install-postgres.sh" "${BASE_SCRIPT_DIR}/install-mongo.sh" "${BASE_SCRIPT_DIR}/install-redis.sh" "${BASE_SCRIPT_DIR}/install-c++-tools.sh" "${BASE_SCRIPT_DIR}/install-vscode.sh" "${BASE_SCRIPT_DIR}/install-docker.sh" "${BASE_SCRIPT_DIR}/install-kubernetes.sh" "${BASE_SCRIPT_DIR}/install-minikube.sh" "${BASE_SCRIPT_DIR}/install-gitlab.sh")
checklistOptions=""

# create the options for the checklist
for index in "${!installScripts[@]}"; do
	installScript=${installScripts[index]}
	label="${installScript:26:${#installScript}-4}" 
	checklistOptions="$checklistOptions $index $label off"
done

selectedOptions=$(whiptail --checklist "Please pick one" 10 60 5 $checklistOptions 3>&1 1>&2 2>&3) # https://stackoverflow.com/questions/8813260/checkboxes-with-bash-script

exitstatus=$?
if [ $exitstatus != 0 ]; then
	echo "User canceled input."
	exit
fi

echo $selectedOptions

# create an array from the output of whiptail
IFS=' ' read -r -a selectedOptionsArray <<< "$selectedOptions" # https://stackoverflow.com/questions/10586153/how-to-split-a-string-into-an-array-in-bash

# stripping the " and replacing the old value with the new value in the array
for index in "${!selectedOptionsArray[@]}"; do
	val=${selectedOptionsArray[index]}
	strippedVal="${val:1:${#val}-2}" # https://askubuntu.com/questions/89995/bash-remove-first-and-last-characters-from-a-string
	selectedOptionsArray[$index]=$strippedVal
done

# execute the script
for element in "${selectedOptionsArray[@]}"; do
	echo "-$element-"
	option=${installScripts[$element]}
	source $option # https://stackoverflow.com/questions/8352851/shell-how-to-call-one-shell-script-from-another-shell-script
done
