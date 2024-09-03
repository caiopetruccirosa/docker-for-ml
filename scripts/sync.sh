#! /bin/bash
# original author: Leo Sampaio Ferraz Ribeiro
# adapted by: Caio Petrucci Rosa

##########################################################################
# SCRIPT DESCRIPTION: sync.sh
# this script is used to sync a local folder with a remote server.
# it uses rsync to sync the local folder with the server folder.
# it also uses a file to exclude files from the syncing process.
# the script accepts the following options:
#   -h, -?  display help information
#   -e      <gitignore-like_exclude_file>
# the script accepts the following arguments:
#   SERVER: a server hostname, which also defines the server username
#   LOCAL_FOLDER: the path to the local folder to be synced
#   SERVER_FOLDER: the path to the server folder to sync the local folder
##########################################################################


######################################################################
# initialize global variables
# variables:
#   local_folder: the local folder to be synced
#   server_username: the username to be used to connect to the server
#   server_hostname: the hostname of the server
#   server_folder: the folder in the server to sync the local folder
#   exclude_file: the file that contains the list of files to be 
#                 excluded in the syncing process
######################################################################
local_folder=""
server_username=""
server_user_group=""
server_hostname=""
server_folder=""
exclude_file=".gitignore"


################################################################
# `help` function that prints usage instructions and available
# options for the script. It provides a guide to how the script 
# should be used and what arguments it accepts.
################################################################
help () { 
   echo "usage: sync.sh [options] SERVER LOCAL_FOLDER SERVER_FOLDER"
   echo
   echo "   -h, -?  display help information"
   echo "   -e      <gitignore-like_exclude_file>"
}


#######################################################################
# `process_options` function processes arguments passed to the script.
#######################################################################
process_args () {

    # checks if the script was called with fewer than two arguments 
    # ($# gives the number of arguments). if so, it calls the help 
    # function to display usage information and exits the script 
    # with a status of 0 (successful exit).
    if test $# -lt 3
    then
        help
        exit 0
    fi

    # OPTIND:
    # a POSIX variable which resets in case getopts has been used 
    # previously in the shell.
    OPTIND=1
    
    # getopts is used to parse the options passed to the script.
    while getopts "h?u:s:p:d:l:f:e:" opt; do
        case "$opt" in
        h|\?)
            help
            exit 0
            ;;
        e)  
            exclude_file=$OPTARG
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
        esac
    done

    # adjusts the positional parameters, removing the options
    # that were parsed by getopts
    shift $((OPTIND-1))

    # checks if the first positional argument is --, which 
    # signals the end of options, and if so, shifts it out
    [ "$1" = "--" ] && shift

    # assigns positional arguments to proper variables
    server=$1
    local_folder=$2
    server_folder=$3

    # assigns server_username, server_user_group and server_hostname 
    # based on the server argument
    case "$server" in
        dl-*)
            server_username="caio.rosa"
            server_user_group="recod"
            server_hostname="$server"
            ;;
        :)
            echo "Invalid \"$server\" server argument" >&2
            exit 1
            ;;
    esac
}


################
# main function
################
main() {
    # processes the arguments passed to the script and defines
    # global variables such as: 
    # - local_folder
    # - server_username
    # - server_user_group
    # - server_hostname
    # - server_folder
    # - exclude_file
    process_args $@

    # define paths for exclude file, local and remote folders
    exclude_file_path=$local_folder/$exclude_file
    local_path=$local_folder
    remote_server_path=$server_username@$server_hostname:$server_folder

    # define chown opts
    chown_opts="$server_username:$server_user_group"

    # Options for rsync:
    # -r: recursive
    # -l: copy symlinks as symlinks
    # -t: preserve modification times
    # -D: preserve devices and special files
    # -v: verbose
    # -z: compress file data during the transfer
    # -h: human-readable output
    # --fuzzy: find similar file names during the syncing process
    sync_opts="-rltDvzh --fuzzy"

    # prints the syncing folders
    echo "Syncing $local_path to $remote_server_path"

    # checks if the exclude file exists and uses it to exclude files
    # from the syncing process. if the file does not exist, it syncs
    # the entire local folder.
    if [ -e $exclude_file_path ]; then
        /usr/bin/rsync $sync_opts --chown $chown_opts --exclude-from "$exclude_file_path" $local_folder $remote_server_path
    else
        /usr/bin/rsync $sync_opts --chown $chown_opts $local_folder $remote_server_path
    fi
}

main $@