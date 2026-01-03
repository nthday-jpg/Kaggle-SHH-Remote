# Connect Kaggle to VS Code via SSH using localhost.run

This guide shows you how to access your Kaggle notebook remotely through VS Code using SSH over localhost.run (free, no credit card required, no installation needed).

## 📋 Prerequisites

- Active Kaggle notebook
- VS Code installed on your local machine
- VS Code Remote-SSH extension installed

## 🚀 Quick Start

### Step 1: Setup in Kaggle Notebook

```python
import os
os.environ["SSH_PASSWORD"] = "your_secure_password"  # Change this!

# Navigate to your working directory
%cd /kaggle/working

# Make scripts executable
!chmod +x *.sh

# Run the installation script
!bash install_ssh_server.sh $SSH_PASSWORD
```

### Step 2: Start the Cloudflare Tunnel

```python
# Run this in a new cell - keep this cell running!
!bash run_ssh_server.sh
```

**Look for the connection details** in the output:
```
Starting SSH Tunnel via localhost.run...
==========================================
Connect to serveo.net at following address:
ssh root@abc-def-123.lhr.life -p 12345
```

You'll see a command like: `ssh root@abc-def-123.lhr.life -p 12345`

**Copy this entire command** - this is what you'll use to connect!

### Step 3: Connect from VS Code

1. **Open VS Code** on your local machine
2. **Press** `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. **Type and select**: `Remote-SSH: Connect to Host...`
4. **Select**: `Add New SSH Host...`
5. **Paste the SSH command** from the Kaggle output (example):
   ```bash
   ssh root@abc-def-123.lhr.life -p 12345
   ```
   Use the EXACT command shown in your Kaggle notebook output

6. **Select the config file** to save to (usually the first option)
7. **Click** `Connect` when prompted
8. **Select**: `Linux` as the platform
9. **Enter your password** when prompted (the one you set in Step 1)
10. **Success!** You're now connected to your Kaggle notebook via VS Code

## 📁 File Descriptions

### install_ssh_server.sh
- Sets up SSH server in Kaggle environment
- Configures SSH with password authentication
- Non-interactive installation (no prompts)
- No additional tools needed (uses built-in SSH)

### run_ssh_server.sh
- Creates an SSH reverse tunnel via localhost.run
- Gives you a public hostname and port to connect to
- **Must keep running while you want to stay connected**

## 💡 Tips & Tricks

### Keep the Tunnel Running
- **Important**: The cell running `run_ssh_server.sh` must stay running
- Don't stop this cell or your connection will drop
- The tunnel stays active as long as the notebook session is alive

### Reconnecting
If your connection drops:
1. Check if the tunnel cell is still running in Kaggle
2. If not, re-run the `run_ssh_server.sh` cell
3. Note the new hostname and port (they change each time)
4. Update your VS Code SSH config with the new connection details

### Security Notes
- Change the default password to something secure
- The tunnel URL is temporary and changes each session
- Only you have the password to access the SSH server

### Accessing Files
Once connected via VS Code:
- Your Kaggle workspace is at: `/kaggle/working/`
- Your Kaggle input data is at: `/kaggle/input/`
- You can browse and edit all files directly in VS Code

### Using with Git
After connecting, you can:
- Clone repositories directly in the Kaggle environment
- Use VS Code's built-in Git features
- Push/pull changes as needed

## 🔧 Troubleshooting

### "Connection refused"
- Make sure the `run_ssh_server.sh` cell is still running
- Verify you're using the correct hostname
- Check that SSH is running: In Kaggle, run `!ps aux | grep sshd`

### "Permission denied"
- Double-check your password
- Make sure you used `root` as the username
- Re-run the installation script if needed

### Tunnel URL not showing
- Wait up to 30 seconds for localhost.run to establish the tunnel
- Look for the SSH command in the format: `ssh root@xyz.lhr.life -p PORT`
- Check the cell output carefully for the connection details
- Try re-running the `run_ssh_server.sh` cell

### VS Code can't connect
- Ensure you're using `root` as the username
- Check your local firewall settings
- Try using the full SSH command format

## 🆓 Why localhost.run?

- **100% Free** - No credit card required
- **Zero Installation** - Uses built-in SSH, no extra tools needed
- **No Account Needed** - Works instantly
- **Simple Setup** - Just one command
- **Works Like ngrok** - Direct SSH connection with hostname:port
- **Secure** - Encrypted SSH tunnel

## ⚠️ Important Notes

- Kaggle notebooks have resource limits and may shut down after inactivity
- Your tunnel hostname and port change each time you start `run_ssh_server.sh`
- For persistent connections, consider using Kaggle's longer-running notebook sessions
- Remember to stop your notebook session when done to save resources

---

**Happy Coding!** 🎉
