# Connect Kaggle to VS Code via SSH using bore

This guide shows you how to access your Kaggle notebook remotely through VS Code using SSH over bore.pub (free, no credit card required, simple and reliable).

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
Starting SSH Tunnel via bore...
==========================================
Connecting to bore.pub...
[INFO] listening at bore.pub:12345
```

You'll see a port number like `12345`. Your SSH command will be:
```bash
ssh root@bore.pub -p 12345
```

**Copy this command with your port number** - this is what you'll use to connect!

### Step 3: Connect from VS Code

1. **Open VS Code** on your local machine
2. **Press** `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. **Type and select**: `Remote-SSH: Connect to Host...`
4. **Select**: `Add New SSH Host...`
5. **Enter the SSH command** using the port from Kaggle output:
   ```bash
   ssh root@bore.pub -p 12345
   ```
   Replace `12345` with the EXACT port number shown in your Kaggle notebook output

6. **Select the config file** to save to (usually the first option)
7. **Click** `Connect` when prompted
8. **Select**: `Linux` as the platform
9. **Enter your password** when prompted (the one you set in Step 1)
10. **Success!** You're now connected to your Kaggle notebook via VS Code

## 📁 File Descriptions

### install_ssh_server.sh
- Sets up SSH server in Kaggle environment
- Installs bore for tunneling
- Configures SSH with password authentication
- Non-interactive installation (no prompts)

### run_ssh_server.sh
- Creates a tunnel to bore.pub
- Exposes SSH on a public port at bore.pub
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

### Tunnel not showing port
- Wait a few seconds for bore to establish the tunnel
- Look for text like: `[INFO] listening at bore.pub:PORT`
- The port number will be shown in the output
- Try re-running the `run_ssh_server.sh` cell if needed

### VS Code can't connect
- Ensure you're using `root` as the username
- Check your local firewall settings
- Try using the full SSH command format

## 🆓 Why bore.pub?

- **100% Free** - No credit card required
- **Lightweight** - Small binary, quick installation
- **No Account Needed** - Works instantly
- **Reliable** - Simple and stable
- **Open Source** - Rust-based, auditable code
- **Works Like ngrok** - Direct SSH connection with port forwarding
- **Secure** - Encrypted tunnel

## ⚠️ Important Notes

- Kaggle notebport changess and may shut down after inactivity
- Your tunnel hostname and port change each time you start `run_ssh_server.sh`
- For persistent connections, consider using Kaggle's longer-running notebook sessions
- Remember to stop your notebook session when done to save resources

---

**Happy Coding!** 🎉
