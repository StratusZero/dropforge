# 🔨 Dropforge
## by [Stratus Zero 🌫️](http://discord.szro.xyz)
#### An Arma Reforger Server Auto-installer and Auto-updater Script (for Windows)
Dropforge is a way to get an Arma Reforger server up and running in no time at all - this script has been designed to make it as simple as possible to run a dedicated server; even without any prior experience!

## 🏗️ Installation
1. Simply drop the .bat into the folder where you want to run the server from.
2. When you run the .bat, it will use SteamCMD to download the latest server files, and then run the server.
3. In the game, either search for the server name or use the "Direct Connect" function to navigate to [your public IP]:[gameserver port] i.e. `127.0.0.1:2001`

### Notes
* Dropforge will auto-generate default config for you in a `configs` folder inside wherever you choose to install the server. Feel free to edit!
* If Dropforge detects pre-existing config (i.e. one you already created) inside the `configs` folder it will attempt to use this instead of auto-generating.
* You can also specify explicitly what config file to use by editing the `configname=` variable near the top of the .bat script.
* Default gameserver port is 2001 (UDP); this may need port forwarding on your router.

## 📋 Requirements
* Windows OS with Powershell
* (ArmA server may need Visual C++ redistributable i.e. errors about MSVCR140.dll)
* (ArmA server may need ports forwarding)

## ✨ Features
* Simple one-click server install
* No need to have ArmA Reforger installed (can run on a separate PC)
* Server auto-starting
* No need to run with a Steam account
* Auto-restarts in the event of a crash

## 🙋 Need help?
Feel free to join the [Discord](http://discord.szro.xyz) if you're having trouble setting up your server :)
For more information on editing the config file, please see [the BI Studios wiki](https://community.bistudio.com/wiki/Arma_Reforger:Server_Hosting#Configuration_File).

## 📄 Changelog

#### 20 May 22 - v1.0.0
* Initial Release