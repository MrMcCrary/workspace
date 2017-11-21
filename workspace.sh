HELP="
#########################################################################
#                                                                       #
#                           WORKSPACE.sh                                #
#                                                                       #
#   A command line utility that sets a directory as your 'workspace'    #
#   This 'workspace' can be cd'ed to quickly                            #
#                                                                       #
#   USAGE:                                                              #
#                                                                       #
#          work [-s [/path/to/new/workspace] | -h]                      #
#                                                                       #
#   OPTIONS:                                                            #
#                                                                       #
#   -s     Sets new workspace. If no path is specified,                 #
#          current directory is set as new workspace                    #
#                                                                       #
#   -h     Displays help page                                           #
#                                                                       #
#   -g     Goes to your 'workspace'                                     #
#                                                                       #                                                                  #
#########################################################################
"

DEFAULT=~/Desktop/
WORKPATH=~/Desktop/code/workspace/workpath.txt

args=("$@") # set args to command line args

if [[ -r $WORKPATH ]] && [[ -f $WORKPATH ]]; then # if workpath.txt is readable and exists
    WORKSPACE=$(<$WORKPATH) # Set WORKSPACE to workpath.txt

    if [[ ! -d $WORKSPACE ]]; then # if WORKSPACE is not a directory
        WORKSPACE=$DEFAULT # Set the WORKSPACE to fall-back
    
    fi

else
    WORKSPACE=$DEFAULT

fi




if [[ ! $# -eq 0 ]]; then # if there are not zero command line args
    if [[ ${args[0]} = "-s" ]]; then # if the -s flag is the 1st arg
        
        if [[ $# -eq 1 ]]; then # If this is true, 'work -s' was passed, so current directory will be set as workspace
            echo $PWD > $WORKPATH
        elif [[ -d ${args[1]} ]]; then # if 2nd arg is a directory
            echo ${args[1]} > $WORKPATH     

        else
            echo "ERROR: No directory named " ${args[1]}
        fi

    elif [[ ${args[0]} = "-c" ]]; then
        echo 'Current workspace: '$WORKSPACE

    elif [[ ${args[0]} = "-h" ]]; then
        echo "$HELP"

    elif [[ ${args[0]} = "-g" ]]; then
        cd $WORKSPACE

    fi

else # if no command line args are passed, go to workspace
    echo "$HELP"
    
fi
