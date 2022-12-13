end=$((SECONDS+3))
echo "Loading..."
while [ $SECONDS -lt $end ];

do for X in "[==D     8]" "[]8===D  []" "[] 8===D []" "[]  8===D[]" "[]   8===[]" "[D     8==]" "[=D     8=]" ; do echo -en "\b\b\b\b\b\b\b\b\b\b\b\b$X"; sleep 0.1; done; 

done

tmux new-session -s C2con-sess -n C2con -d
tmux split-window -v
tmux split-window -h
tmux split-window -v
tmux send-keys -t 1 "while true;echo \"\"\"
+-+-+ +-+-+-+-+-+
 |Z|e| |J|u|i|c|e|
 +-+-+ +-+-+-+-+-+
\"\"\"; do tail '/tmp/C2CON-res.txt' 2>/dev/null; sleep 1; clear; done" C-m
tmux send-keys -t 2 "clear;while true;echo \"\"\"
 +-+-+-+-+
 |p|i|n|g|
 +-+-+-+-+
\"\"\"; do cat '/tmp/C2CON-ping.txt'; sleep 3; clear; done" C-m
tmux send-keys -t 3 "clear;while true;echo \"\"\"
+-+-+-+-+-+
 |T|a|s|k|s|
 +-+-+-+-+-+
\"\"\"; do tail  '/tmp/C2CON-cmds.txt' 2>/dev/null; sleep 1; clear; done" C-m
tmux send-keys -t 0 "clear;bash Run_Cmd.sh" C-m
tmux select-pane -t 0
tmux attach-session -t C2con-sess
