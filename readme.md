# ⚠️ DEPRECATED - DO NOT USE

## 🚨 WARNING: THIS METHOD IS NO LONGER SUPPORTED

**Kaggle has banned SSH tunneling and remote access methods.** Using this approach may result in your Kaggle account being banned or suspended according to Kaggle's Terms of Service and acceptable use policies.

**This repository is archived for educational purposes only.**

---

## Why This No Longer Works

Kaggle has implemented measures to detect and block SSH tunneling and similar remote access methods. This includes:
- Blocking tunneling services like bore.pub, ngrok, etc.
- Detecting SSH server installations
- Monitoring for policy violations

## ❌ Risks of Using This Method

- **Account Ban**: Your Kaggle account may be permanently banned
- **Loss of Access**: You may lose access to all Kaggle resources, competitions, and datasets
- **Policy Violation**: This violates Kaggle's Terms of Service
- **Detection**: Kaggle actively monitors for these practices

## ✅ Recommended Alternatives

Instead of trying to bypass Kaggle's restrictions, use these legitimate alternatives:

1. **Use Kaggle Notebooks Directly**: Work within the Kaggle web interface
2. **Google Colab**: Free GPU/TPU access with similar capabilities
3. **Local Development**: Download datasets and work on your own machine
4. **Cloud Platforms**: AWS SageMaker, Azure ML, GCP AI Platform (paid options)
5. **Paperspace Gradient**: Free tier available for remote development

---

## Original Documentation (For Historical Reference Only)

~~This guide shows you how to access your Kaggle notebook remotely through VS Code using SSH over bore.pub (free, no credit card required, simple and reliable).~~

### ~~Prerequisites~~

- ~~Active Kaggle notebook~~
- ~~VS Code installed on your local machine~~
- ~~VS Code Remote-SSH extension installed~~

### ~~Quick Start~~ (DEPRECATED - DO NOT USE)

<details>
<summary>⚠️ Click to view original instructions (for reference only)</summary>

#### Step 1: Setup in Kaggle Notebook

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

</details>

---

## 📁 File Descriptions (Historical)

### install_ssh_server.sh
- Sets up SSH server in Kaggle environment
- Installs bore for tunneling
- Configures SSH with password authentication
- Non-interactive installation (no prompts)

### run_ssh_server.sh
- Creates a tunnel to bore.pub
- Exposes SSH on a public port at bore.pub
- **Must keep running while you want to stay connected**

---

## 🚫 Why This Repository Remains Public

This repository is kept public for:
- **Educational purposes** - Understanding how SSH tunneling works
- **Historical reference** - Documenting what was once possible
- **Warning others** - Preventing account bans by informing users

**Do not attempt to use these scripts on Kaggle or similar platforms that prohibit remote access.**

---

## Legal Disclaimer

The scripts and information in this repository are provided for educational purposes only. The authors and contributors:
- Do not encourage violation of any platform's Terms of Service
- Are not responsible for any account suspensions or bans
- Recommend following all platform policies and guidelines
- Advise using only approved and legitimate access methods

**By using these scripts, you acknowledge that you do so at your own risk and accept full responsibility for any consequences.**

---

**Stay safe and use legitimate alternatives!** 🛡️
