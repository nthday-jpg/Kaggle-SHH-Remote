# Connect Kaggle to VS Code via SSH using Cloudflare Tunnel

This guide shows you how to access your Kaggle notebook remotely through VS Code using SSH over Cloudflare Tunnel (free, no credit card required).

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
Starting Cloudflare Tunnel...
==========================================
INF |  Your quick Tunnel has been created! Visit it at:
INF |  https://abc-def-123.trycloudflare.com
```

The tunnel will show you a hostname like `abc-def-123.trycloudflare.com` and automatically map to port 22.

### Step 3: Connect from VS Code

1. **Open VS Code** on your local machine
2. **Press** `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. **Type and select**: `Remote-SSH: Connect to Host...`
4. **Select**: `Add New SSH Host...`
5. **Enter the SSH command**:
   ```bash
   ssh root@abc-def-123.trycloudflare.com
   ```
   Replace `abc-def-123.trycloudflare.com` with your actual Cloudflare hostname

6. **Select the config file** to save to (usually the first option)
7. **Click** `Connect` when prompted
8. **Select**: `Linux` as the platform
9. **Enter your password** when prompted (the one you set in Step 1)
10. **Success!** You're now connected to your Kaggle notebook via VS Code

## 📁 File Descriptions

### install_ssh_server.sh
- Sets up SSH server in Kaggle environment
- Installs Cloudflare Tunnel (cloudflared)
- Configures SSH with password authentication
- Non-interactive installation (no prompts)

### run_ssh_server.sh
- Starts the Cloudflare Tunnel
- Creates a public URL to access your Kaggle SSH server
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
3. Note the new URL (it changes each time)
4. Update your VS Code SSH config with the new hostname

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
- Wait a few seconds for cloudflared to establish the tunnel
- Check the cell output carefully for the connection details
- Try re-running the `run_ssh_server.sh` cell

### VS Code can't connect
- Ensure you're using `root` as the username
- Check your local firewall settings
- Try using the full SSH command format

## 🆓 Why Cloudflare Tunnel?

- **100% Free** - No credit card required
- **No Account Needed** - Quick tunnels work instantly
- **Reliable** - Backed by Cloudflare's infrastructure
- **No Time Limits** - Unlike ngrok's free tier
- **Secure** - Encrypted connection

## ⚠️ Important Notes

- Kaggle notebooks have resource limits and may shut down after inactivity
- Your tunnel URL changes each time you start `run_ssh_server.sh`
- For persistent connections, consider using Kaggle's longer-running notebook sessions
- Remember to stop your notebook session when done to save resources

---

**Happy Coding!** 🎉
