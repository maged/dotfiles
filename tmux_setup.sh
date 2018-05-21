#/bin/bash

SESSIONNAME=$1

tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]
then
  tmux new-session -s $SESSIONNAME -n $SESSIONNAME -d
  tmux send-keys -t $SESSIONNAME $2 C-m
fi

tmux attach -t $SESSIONNAME
