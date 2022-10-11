
tmux new-session -s ses-0 -n my-screen-name -d
tmux split-window -v
tmux split-window -h
#tmux select-pane -t:.0 -P "bg=#7A306C"
tmux send-keys -t 1 "tail -f /var/www/html/res.txt" C-m
tmux send-keys -t 2 "while true; do cat /var/www/html/ping.txt; sleep 5; clear; done" C-m
tmux send-keys -t 0 "bash Run_Cmd.sh" C-m
tmux attach-session -t ses-0
