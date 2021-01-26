#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null || exit ; pwd -P )"
REPO_PATH=$(dirname "$SCRIPT_PATH")
REPO_METADATA_PATH="$REPO_PATH/.repo_metadata"

LEVEL1=("First Time Setup" "Reset config")

function header
{
    echo "### START USING YOUR REPOSITORY ###"
    echo "(to abort, Ctrl-C)"
    echo "-> Please choose the repo type you"
    echo "-> want to configure or to rebuild"
    echo "-> the configuration!"
}

function invalid_option
{
    echo "Invalid option $REPLY! Try again!"
}

## START
mkdir -p "$REPO_METADATA_PATH"
header
pushd "$SCRIPT_PATH" >/dev/null || exit

## MENU
echo "What do you want to do?"
select choice in "${LEVEL1[@]}"
do
    case $choice in
    "${LEVEL1[0]}")
        if [[ ! -f $REPO_METADATA_PATH"/.DONE" ]]
        then
            REPOTYPES=( $(ls repo_*.mk | cut -d'_' -f2- | cut -d'.' -f1) )
            echo "Which type of repository will this be?"
            select repo_type in "${REPOTYPES[@]}"
            do
                if [ $repo_type ]
                then
                    touch "$REPO_METADATA_PATH"/.repo_"$repo_type"
                    break
                else
                    invalid_option
                fi
            done
        fi
        make
        break
        ;;
    "${LEVEL1[1]}")
        make .force-reset
        break
        ;;
    *)
        invalid_option
        ;;
    esac
done

## END
popd >/dev/null || exit
