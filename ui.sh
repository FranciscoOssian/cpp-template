#!/bin/bash

declare -a project_names

get_projects(){
    FILE="premake.lua"

    # Check if file exists
    if [[ ! -f "$FILE" ]]; then
        echo "File $FILE not found!"
        exit 1
    fi

    # Extract project names and store them in an array
    while IFS= read -r line; do
        # Use a regular expression to extract the project name
        if [[ $line =~ project\ \"([^\"]+)\" ]]; then
            project_names+=("${BASH_REMATCH[1]}")
        fi
    done < "$FILE"
}

project_choice=""

# Function to display the menu
menu() {
    echo "Make menu: (Release only)"
    project_names=()
    get_projects
    local i=0
    for project in "${project_names[@]}"; do
        echo "$i- $project"
        i=$((i + 1))
    done
    echo "$i. Exit"
    echo

    read -p "Choose an option: " project_chosen

    clear

    i=0
    local ok=0
    for project in "${project_names[@]}"; do
        if [[ "$i" == "$project_chosen" ]]; then
            project_chosen="$project"
            ok=1
        fi
        i=$((i + 1))
    done

    if [[ $ok == 0 ]]; then
        exit 0
    fi

    cd build
    make config=release $project_chosen
    cd ..
}

SESSION="my_session"

# Check if argument was provided and set the corresponding flag
if [[ "$1" == "--menu" ]]; then
    clear
    while true; do
        menu

        tmux send-keys -t $SESSION:0.0 C-c
        sleep 2
        tmux send-keys -t $SESSION:0.0 "bash $0 --compiler" C-m
    done
elif [[ "$1" == "--compiler" ]]; then
    clear
    read -p "Enter mode (release/debug): " mode
    ./.premake/premake5 --file=premake.lua gmake
    cd build
    make config=$mode all
    cd ..
    get_projects
    bash $0 --compiler
else
    # Check if session already exists and remove it
    tmux has-session -t $SESSION 2>/dev/null
    if [ $? -eq 0 ]; then
        tmux kill-session -t $SESSION
        if [ $? -ne 0 ]; then
            echo "Error deleting existing tmux session."
            exit 1
        fi
    fi

    # Create tmux session
    tmux new-session -d -s $SESSION -n main

    # Check if session was created successfully
    if [ $? -ne 0 ];then
        echo "Error creating tmux session."
        exit 1
    fi

    # Split window horizontally
    tmux split-window -h -t $SESSION:0

    # Check if window split was successful
    if [ $? -ne 0 ];then
        echo "Error splitting tmux window."
        exit 1
    fi

    # Pause to ensure session and windows are fully configured
    sleep 1

    # Execute command in the second part of the window
    tmux send-keys -t "$SESSION":0.1 "bash $0 --menu" C-m

    # Check if command was sent correctly
    if [ $? -ne 0 ]; then
        echo "Error sending command to tmux session."
        exit 1
    fi

    # Execute command in the first part of the window
    tmux send-keys -t $SESSION:0.0 "bash $0 --compiler" C-m

    # Check if command was sent correctly
    if [ $? -ne 0 ]; then
        echo "Error sending command to tmux session."
        exit 1
    fi

    # Attach to tmux session
    tmux attach-session -t $SESSION
fi
