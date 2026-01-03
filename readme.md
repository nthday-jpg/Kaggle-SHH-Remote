ssh_dir = "/kaggle/working/remote-ssh-kaggle-vscode"

!chmod +x {ssh_dir}/*.sh

!bash {ssh_dir}/install_ssh_server.sh $SSH_PASSWORD
!bash {ssh_dir}/add_ngrok_token.sh $NGROK_TOKEN
!bash {ssh_dir}/run_ssh_server.sh
