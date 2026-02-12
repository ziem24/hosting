# Minecraft Server Utility for Linux
#### Ziemcorp INTERACTIVE COPYRIGHT 2026

---

### 1. What it does
This is a CLI tool for managing self-hosted servers more easily. Has little use for anyone who is not [me](https://github.com/ziem24). Technologies:
- DuckDNS: DNS resolution
- zip: file compression
- Bourne shell (sh) and its supersets

### 2. Usage
#### Initializing a server
- Servers are created by executing a server.jar file provided by Minecraft, PaperMC, etc., or by installing a server version with a mod loader like Fabric, Forge, or others.
- Each server firectory must contain an executable 'run.sh' or 'start.sh' script (chmod +x). This script will be later used to run the server (if, for some reason, both scripts are present, then 'run.sh' will take priority).
- It is important to agree to EULA after installing a server, the easiest way to do this is by typing `sed -i s/false/true/g eula.txt`
#### Running the script
Doing `./main.sh` is the easiest way to handle it. Some prompts may use a text editor (Vim by default). If that editor is not present or you want to use something else, you can start the program using this command: `edit=[editor of your choice] ./main.sh`

### 3. Files and directories
- Backups directory: where the backups are saved by default
- Jarfiles directory: will be used for holding server.jar files (OOO)
- Servers directory: holds all the servers
- DNS configuration file (dns.conf): this is where the domain name (without the duckdns.org suffix) and your token are stored

All directories and files mentioned above are automatically generated upon the first startup of the script.
