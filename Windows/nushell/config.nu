# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# CARAPACE -- AUTOCOMPLETE
source ~/.cache/carapace/init.nu

# Prevents weird new line for every keystroke
$env.config.shell_integration.osc133 = false

# Theme
source "~/.config/themes/catppuccin_latte.nu"

# EZA
alias l = ls
alias ls = eza --icons
alias ll = eza -l --icons
alias la = eza -la --icons
alias lt = eza -lT --icons
alias lt1 = eza -lT --level=1 --icons
alias lt2 = eza -lT --level=2 --icons
alias lt3 = eza -lT --level=3 --icons
alias lta = eza -lTa --icons
alias lta1 = eza -lTa --level=1 --icons
alias lta2 = eza -lTa --level=2 --icons
alias lta3 = eza -lTa --level=3 --icons

# Zoxide
source ~/.config/.zoxide.nu
$env._ZO_FZF_OPTS = "--scheme=path --read0 --height=40% --reverse --walker=dir,follow,hidden --preview 'eza --tree --color=always --level=1 {2..}' +m"
alias cd = z
alias cds = zi

# NVIM
alias v = nvim
alias vi = nvim
alias vim = nvim

# YAZI
def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# FZF
$env.FZF_DEFAULT_OPTS = "--preview \'bat -n --color=always --line-range :500 {}\'"

# CTRL+R - FZF
$env.config.keybindings = [
{
  name: fuzzy_history
  modifier: control
  keycode: char_r
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: ExecuteHostCommand
      cmd: "do {
        $env.SHELL = 'nu'
        commandline edit --insert (
          history
          | get command
          | reverse
          | uniq
          | str join (char -i 0)
          | fzf --scheme=history 
              --read0
              --layout=reverse
              --height=40%
              --bind 'ctrl-/:change-preview-window(right,70%|right)'
              --preview='echo {1..} | bat --color=always -pl sh'
              --preview-window 'wrap,up,7'
              # Run without existing commandline query for now to test composability
              # -q (commandline)
          | decode utf-8
          | str trim
        )
      }"
    }
  ]
}

{
  name: fuzzy_cd
  modifier: control
  keycode: char_y
  mode: [emacs, vi_normal, vi_insert]
  event: [
    {
      send: ExecuteHostCommand
      cmd: "cd (
        fzf --scheme=path
          --read0
          --height=40%
          --reverse
          --walker=dir,follow,hidden
          --preview \'eza --tree --color=always --level=1 {}\'
          +m
      )"
    }
  ]
}
]
