# Dotfiles for Arch Linux
These dotfiles configure an Arch Linux desktop, including the terminal, editor, and a small set of core tools. The repo also contains a reproducible package set and an installation script that bootstraps a new machine.

## Usage
- **Full installation:** Install all packages (including AUR) and create symbolic links  
    ```bash
    ./install.sh --yay
    ```
- **Dry run:** Display what the scrip would do without actually doing anything  
    ```bash
    ./install.sh -d
    ```
- **Setup symlinks:** Symbolic links can be set up on their own without also installing all the packages. This script can also be run dry  
    ```bash
    ./setup_symlinks.sh [-d]
    ```
    
 
