# Step 1
import os
os.environ["NGROK_TOKEN"] = "secret"
os.environ["SSH_PASSWORD"] = "secret"

# Step 2
ssh_dir = "/kaggle/working/Kaggle-SHH-Remote"

!chmod +x {ssh_dir}/*.sh

!bash {ssh_dir}/install_ssh_server.sh $SSH_PASSWORD
!bash {ssh_dir}/add_ngrok_token.sh $NGROK_TOKEN
!bash {ssh_dir}/run_ssh_server.sh
