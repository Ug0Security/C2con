
tmux new-session -s C2con-sess -n C2con -d
tmux split-window -v
tmux split-window -h
tmux send-keys -t 1 "tail -f /var/www/html/res.txt" C-m
tmux send-keys -t 2 "while true; do cat /var/www/html/ping.txt; sleep 5; clear; done" C-m
tmux send-keys -t 0 "bash Run_Cmd.sh" C-m
tmux select-pane -t 0
tmux attach-session -t C2con-sess

