#!/bin/bash

LIST=0
ROLE=''
FORCE=0
HELP=0

# Bash script options
# @see http://stackoverflow.com/a/21128172
# @see http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt
while getopts 'lr::fh' flag; do
    case "${flag}" in
    l) LIST=1 ;;
    r) ROLE="${OPTARG}" ;;
    f) FORCE=1 ;;
    h | *) HELP=1 ;;
    esac
done

# Display Help
if [ $HELP -eq 1 ]
then
    echo
    echo "Available options:"
    echo "------------------"
    echo
    echo "-h             Print this help list"
    echo "-l             List available roles"
    echo "-r  ROLE_NAME  Selected role to create the configuration files"
    echo "-f             Force creation of configuration files"
    echo
    exit
fi

# List available roles
if [ $LIST -eq 1 ]
then
    echo
    echo "Available Roles:"
    echo "----------------"
    echo
    ls -1 chef/roles | cut -d'.' -f1
    echo
fi

# Create configuration files
if [ -n "${ROLE}" ]
then

    if [ `ls -1 chef/roles/ | grep ${ROLE}` ]
    then

        if [ $FORCE -eq 1 ]
        then
            rm Vagrantfile
            rm Berksfile
            rm "chef/roles_enabled/${ROLE}.rb"
        fi

        # Create Vagrantfile
        if [ -a Vagrantfile ]
        then
            echo "Vagrantfile: Ignored (file already exist)"
        else
            cp Vagrantfile.base Vagrantfile
            sed -i "s/chef\.add_role\s\"\"/chef.add_role \"${ROLE}\"/g" Vagrantfile
            echo "Vagrantfile: Created"
        fi

        # Create Berksfile
        if [ -a Berksfile ]
        then
            echo "Berksfile: Ignored (file already exist)"
        else
            cp "chef/berksfile/Berksfile.${ROLE}" Berksfile
            echo "Berksfile: Created"
        fi

        # Create role file
        if [ -a "chef/roles_enabled/${ROLE}.rb" ]
        then
            echo "${ROLE}.rb: Ignored (file already exist)"
        else
            cp "chef/roles/${ROLE}.rb" chef/roles_enabled/
            echo "${ROLE}.rb: Created"
        fi

    else
        echo "There is no configuration for '${ROLE}'"
    fi

fi

