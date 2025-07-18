# ╭────────────────────────────────────────────────────────────────────────────╮
# │ ██████╗░░█████╗░                                                           │
# │ ██╔══██╗██╔══██╗                                                           │
# │ ██████╔╝██║░░╚═╝                                                           │
# │ ██╔═══╝░██║░░██╗                                                           │
# │ ██║░░░░░╚█████╔╝                                                           │
# │ ╚═╝░░░░░░╚════╝░                                                           │
# ╰────────────────────────────────────────────────────────────────────────────╯
# ╭────────────────────────────────────────────────────────────────────────────╮
# │ Author: Pete Cruz                                                          │
# │ Description: Nushell Configuration                                         │
# ╰────────────────────────────────────────────────────────────────────────────╯

$env.config = {
  error_style: "fancy"

  history: {
    max_size: 100_000
    sync_on_enter: true
  }

  rm: {
    always_trash = false
  }

  use_ansi_coloring: true
  use_kitty_protocol: true
}

# ╭────────────────────────────────────────────────────────────────────────────╮
# │ Aliases                                                                    │
# ╰────────────────────────────────────────────────────────────────────────────╯

alias nu-open = open
alias open = ^open

# ╭────────────────────────────────────────────────────────────────────────────╮
# │ Functions                                                                  │
# ╰────────────────────────────────────────────────────────────────────────────╯

# Retrieve output of previous command.
def _ []: nothing -> any {
  $env.last
}

def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}

# mkdir and cd into directory.
def --env mc [path: path]: nothing -> nothing {
  mkdir $path
  cd $path
}

def today []: nothing -> string {
  date now | format date "%Y-%m-%d"
}
