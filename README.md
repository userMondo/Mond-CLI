# Mond Manager

## Overview
Simplify: FOR SOMEONE WHOSE WOULD SOMEHOW PREFER TERMINAL TO OPEN YOUR APPs, GAMEs, ETC... WHICH IS .EXE FILE. STEPS: ADD YOUR .EXE, SET SHORT NAME, RUN IT VIA TERMINAL(cmd i'm not sure this could work on mac)

This batch script provides a simple command-line interface (CLI) for managing executable aliases on Windows. It allows users to easily add, list, run, and delete executable paths using custom aliases. The script maintains a configuration file to store these aliases and their associated paths.

## Features

- **Add Alias**: Associate a new executable path with a custom alias. The user is prompted to provide an alias name.
- **List Aliases**: Display all existing aliases and their corresponding executable paths.
- **Run Alias**: Launch an executable using its alias.
- **Delete Alias**: Remove an alias and its associated path from the configuration file.

## Commands

- **`mond add <path\to\file.exe>`**  
  Adds a new executable path to the configuration file. You will be prompted to enter an alias name for the executable.

- **`mond list`**  
  Lists all aliases and their corresponding executable paths from the configuration file.

- **`mond run <alias>`**  
  Launches the executable associated with the specified alias.

- **`mond delete <alias>`**  
  Removes the alias and its associated executable path from the configuration file.

- **`mond rename <old_alias> <new_alias>`**  
  Renames an existing alias to a new name.

## Configuration

The script uses a configuration file named `aliases.cfg` to store aliases and their paths. This file is created in the same directory as the script. A temporary file `temp.cfg` is used for alias deletion operations.

## Requirements

- Windows operating system
- Batch script execution environment

## Installation

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/userMondo/Mond-CLI.git
   ```

2. **Set Environment variable**:
  *you can do something like*:
  ```sh
  set PATH=%PATH%;C:\path\to\mond-CLI
  ```
  or set menually
   
3. **Run the Script**:
   ```cmd
   mond [command] [parameters]
   ```
   *Example: add(once) your first Epic game*:
    ```cmd
    mond add C:\Your DISK\Epic Games\Launcher\Engine\Binaries\Win64\EpicGamesLauncher.exe
    ```
    *set your short name of .exe, i'll do "ep"*
   ```cmd
   mond run ep
   ```
   There you have it.
## Tips to find your .exe
1. On your stream: Steam Library:
  Open the Steam client on your computer.
  Navigate to your Library where all your games are listed.
  Right-click on the game for which you want to find the installation path.
  Select Properties from the dropdown menu.
  Go to the LOCAL FILES tab.
  Click on Browse Local Files.... This will open File Explorer directly to the folder where the game is installed, allowing you to view the path in the address bar.
2. Using a Shortcut:
    If there is a shortcut to the software or game on the desktop or Start Menu:
    Right-click on the shortcut and select Properties.
    In the Shortcut tab, look for the Target field, which will show the full path to the executable.
## Contributing

Feel free to open issues or submit pull requests if you have suggestions or improvements for the script.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
