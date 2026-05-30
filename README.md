# Minecraft server utility for Linux
#### Ziemcorp INTERACTIVE COPYRIGHT 2026

---

## 1. What it does
This is a CLI tool for managing self-hosted Minecraft servers more easily. Has little use for anyone who is not [me](https://github.com/ziem24). Dependencies:
- DuckDNS: DNS resolution
- zip: file compression
- Bourne shell (sh) or its supersets

### 1.1 Functionalities
- Listing servers,
- Starting a server,
- Creating server backups,
- Showing your public IP address,
- Configuring your DNS resolution (requires a DuckDNS domain and `domain` and `token` config fields),
- Editing the configuration file (requires an `edit` config field),
- Resetting the configuration file,
- Fetching all archived versions from https://mcversions.net into a text file,
- Downloading something from https://mcversions.net (requires a `download_dir` config field). Note: this will fetch all versions only if the text file does not exist, which means you should fetch these versions manually after a new version appears.

### 1.2 Upcoming/future functionalities
- Initializing a new server
- Loading a server from a backup
- Downloading a server from a Google drive

## 2. Usage
### 2.1. Initializing a server
- Servers are created by executing a server.jar file provided by Minecraft, PaperMC, etc., or by installing a server version with a mod loader like Fabric, Forge, or others.
- Each server firectory must contain an executable 'run.sh' or 'start.sh' script (use chmod +x to grant executable permissions). This script will be later used to run the server (if, for some reason, both scripts are present, then 'run.sh' will take priority).
- It is important to agree to EULA after installing a server, the easiest way to do this is by typing `sed -i s/false/true/g eula.txt`

### 2.2. Running the script
Doing `./main.sh` is the easiest way to handle it. Some scripts may require editing the `main.conf` file which you can also do through the CLI.

## 3. Files and directories
- Backups directory: where the backups are saved by default
- Servers directory: holds all the servers
- Configuration file: this is where the config options are stored

All directories and files mentioned above are automatically generated upon the first startup of the script.

![banger](assets/banger.png)
