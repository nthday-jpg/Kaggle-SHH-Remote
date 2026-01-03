# Step 1
import os
os.environ["NGROK_TOKEN"] = "secret"
os.environ["SSH_PASSWORD"] = "secret"

# Step 2
%cd Kaggle-SHH-Remote

# Make scripts executable
!chmod +x *.sh

# Run the scripts (they'll find ngrok in /kaggle/working/)
!bash install_ssh_server.sh {SSH_PASSWORD}
!bash add_ngrok_key.sh {NGROK_TOKEN}
!bash run_ssh_server.sh