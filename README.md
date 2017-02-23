# SteamForwarder
steam_api.dll implementation for wine. Your windows games now can interact with your linux steam!

# !DISCLAMER!
**The author is not liable for any damage resulting from the use of this software. User might broke his games, steam, OS or even computer. User account might to be banned by Valve. EVERYTHING THAT YOU'RE DOING, YOU'RE DOING ON YOUR OWN RISK!**

## Usage dependences
* steamcmd
* python3
* wine

## Usage
This is common scenario of usage SteamForwarder for users.
Some hints for experts can be found in section below.
1. Download latest release of SteamForwarder from releases page
2. Unpack it to the folder you want
3. Open the terminal in the folder SteamForwarder was unpacked
4. Type `python3 app_install.py --help` to learn command line options of installer tool.
5. Use app\_install.py to install your windows game. E.g. for Paladins it command will be `python3 app_install.py 444090`. The steam appid of the game can be found in url of the game page in steam store site.
6. Launch your linux **steam** (don't allow it to update your windows games if they support MacOS either)
7. Run installed game via runscript generated. (Its location will be printed after app\_install.py will install the game.)

## Compilation dependences
General:
* Wine headers with winegcc

Fedora:
* glibc-devel.i686
* wine-devel.i686

Arch:
* wine

## Compilation
1. Obtain [somewhere](https://partner.steamgames.com/home) latest steam api headers and put them into the **steam** folder. (They cannot be included to this repo due to licensing issues.)
2. Obtain libsteam_api.so from any of your linux games or from the sdk obtained in p.1, then put it to the repo root.
3. Open the terminal in the repo root and type `make`.
4. If something went wrong - go to the **Hard way** section.
5. When compilation will be completed you will see **steam_api.dll.so** in the repo root.

## Usage (for experts)
1. Put your **libsteam_api.so** into LD_LIBRARY_PATH accessable location.
2. Put created **steam_api.dll.so** into WINEDLLPATH accessable location.
3. Once per WINEPREFIX set "*steam_api" as buildin via winecfg
4. Run the **steam**
5. Run your windows game through the wine.

## Hard way
1. Install the [Nim compiler](https://nim-lang.org/download.html) of version 0.15+ (probably, it can be found in your distro repo). PS: Yes, I know, that code generator could be implemented in some popular language like python, but I wanted to write it in Nim just because I like this language and want to make it popular =P
2. Put **steam_api.dll** from your game or steam sdk into repo root.
3. Regenerate code by `make generate-code`.
4. Compile SteamForwarder using `make` command.
