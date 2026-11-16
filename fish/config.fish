source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# opencode
fish_add_path /home/naidra/.opencode/bin


# Added by Antigravity CLI installer
set -gx PATH "/home/naidra/.local/bin" $PATH

# QODER_DISPATCHER_PATH v1
fish_add_path -p -m $HOME/.qoder/entry
# END QODER_DISPATCHER_PATH v1

# starship prompt (Material You colours in ~/.config/starship.toml)
if type -q starship
    starship init fish | source
end
