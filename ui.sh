#!/bin/bash

# Function to execute the binary
execute_binary() {
    local bin_dir="build/bin/$1"
    
    if [[ ! -d "$bin_dir" ]]; then
        echo "Directory $bin_dir does not exist!"
        exit 1
    fi

    local bin_file
    for file in "$bin_dir"/*; do
        if [[ ! "$file" =~ \. ]]; then
            bin_file="$file"
            break
        fi
    done

    if [[ -z "$bin_file" ]]; then
        echo "No executable file found in $bin_dir"
        exit 1
    fi

    ./"$bin_file"
}

# Array to store project names
declare -a project_names

# Function to get project names from premake.lua
get_projects() {
    project_names=()

    local FILE="premake.lua"

    if [[ ! -f "$FILE" ]]; then
        echo "File $FILE not found!"
        exit 1
    fi

    local -a TEMP_PROJECTS=()
    local -a TEMP_KINDS=()

    while IFS= read -r line; do
        if [[ $line =~ project\ \"([^\"]+)\" ]]; then
            TEMP_PROJECTS+=("${BASH_REMATCH[1]}")
        fi
        if [[ $line =~ kind\ \"([^\"]+)\" ]]; then
            TEMP_KINDS+=("${BASH_REMATCH[1]}")
        fi
    done < "$FILE"

    for ((i=0; i<${#TEMP_PROJECTS[@]}; i++)); do
        if [[ "${TEMP_KINDS[i]}" != "None" ]]; then
            project_names+=("${TEMP_PROJECTS[i]}")
        fi
    done
}


# Function to display the menu and handle project selection
menu() {
    echo "Make menu: (Release only)"
    project_names=()
    get_projects

    for i in "${!project_names[@]}"; do
        echo "$i - ${project_names[i]}"
    done
    echo "${#project_names[@]} - Exit"
    echo

    read -p "Choose an option: " project_chosen

    if [[ "$project_chosen" -ge "${#project_names[@]}" || "$project_chosen" -lt 0 ]]; then
        exit 0
    fi

    clear
    cd build || exit 1
    make config=release "${project_names[project_chosen]}"
    cd ..
}

# Function to handle compiler actions
compiler() {
    clear
    echo "Enter mode"
    echo "1) Release"
    echo "2) Debug"
    echo "*) ---"
    read -p "mode: " mode
    case "$mode" in
        1)
            mode="release"
            ;;
        2)  
            mode="debug"
            ;;
        *)
            mode="all"
            ;;
    esac
    
    if [[ "$mode" == "release" ]]; then
        execute_binary Release
    elif [[ "$mode" == "debug" ]]; then
        execute_binary Debug
    fi
}

# Main function to handle tmux session creation and management
main() {
    local SESSION="my_session"

    tmux has-session -t $SESSION 2>/dev/null && tmux kill-session -t $SESSION

    tmux new-session -d -s $SESSION -n main || { echo "Error creating tmux session."; exit 1; }
    tmux split-window -h -t $SESSION:0 || { echo "Error splitting tmux window."; exit 1; }

    sleep 1

    tmux send-keys -t "$SESSION":0.1 "bash $0 --menu" C-m || { echo "Error sending command to tmux session."; exit 1; }
    tmux send-keys -t "$SESSION":0.0 "bash $0 --compiler" C-m || { echo "Error sending command to tmux session."; exit 1; }

    tmux attach-session -t $SESSION
}

# Argument handling
case "$1" in
    --menu)
        clear
        while true; do
            menu
            tmux send-keys -t my_session:0.0 C-c
            sleep 2
            tmux send-keys -t my_session:0.0 "bash $0 --compiler" C-m
        done
        ;;
    --compiler)
        while true; do
            compiler
        done
        ;;
    *)
        main
        ;;
esac
