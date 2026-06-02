###########################
#  zsh configuration
###########################
# Symlinked to ~/.zshrc (see README). Ported from the fish setup.

# --- environment ---
export LANG=en_US.UTF-8
export EDITOR=nvim

# PATH: homebrew, brew git, ~/.local/bin
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/git/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# libpq (needed to build the pg gem)
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# webpacker dev server
export WEBPACKER_DEV_SERVER_HOST=0.0.0.0

# gpg, for signing commits
export GPG_TTY=$(tty)

# aws-vault
export AWS_VAULT_KEYCHAIN_NAME=login

# --- asdf (before oh-my-zsh so compinit picks up completions) ---
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"
fpath=(${ASDF_DIR:-$HOME/.asdf}/completions $fpath)

# --- oh-my-zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jbergantine"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# --- functions & aliases ---
# Note: the gp/gP abbreviations use oh-my-zsh's git_current_branch helper.

# ls -la  (override oh-my-zsh's `l` alias)
alias l='ls -la'

# interactively kill processes with fzf (port of the fish kp)
kp() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --header='[kill:process]' | awk '{print $2}')
  if [[ -n $pid ]]; then
    echo $pid | xargs kill -${1:-9}
    kp
  fi
}

# --- fzf key bindings (Ctrl-R history, Ctrl-T files, Alt-C cd) ---
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh 2>/dev/null
  source /opt/homebrew/opt/fzf/shell/completion.zsh 2>/dev/null
fi

# --- aliases ---
# Shopify Hydrogen -> local project bin
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# --- cmux workspace launcher (replaces tmuxinator `mux <project>`) ---
# Each `cmux workspace create` is one project context; --command auto-starts
# its dev server. Adjust the per-project commands below as your setup changes.
start() {
  case "$1" in
    smile) _start_smile ;;
    ""|-h|--help) print -- "usage: start <project>   (projects: smile)" ;;
    *) print -u2 -- "start: unknown project '$1' (try: smile)"; return 1 ;;
  esac
}

_start_smile() {
  local root="$HOME/Projects/smile"
  # Frontends + services auto-start; core/web open as plain shells.
  cmux workspace create --name smile-ui  --cwd "$root/smile-ui"                        --command "smile-cli run pnpm start" --focus false
  cmux workspace create --name admin     --cwd "$root/smile-admin"                     --command "smile-cli run pnpm start" --focus false
  cmux workspace create --name internal  --cwd "$root/smile-internal"                  --command "smile-cli run pnpm start" --focus false
  cmux workspace create --name dev-env   --cwd "$root/dev-env-services"                --command "smile-cli dc up -d --wait" --focus false
  cmux workspace create --name endpoints --cwd "$root/smile-data-ingestion-endpoints" --command "smile-cli run bin/dev"     --focus false
  cmux workspace create --name extensions --cwd "$root/smile-shopify-app-extensions"   --focus false
  cmux workspace create --name web       --cwd "$root/smile-core"                      --focus false
  cmux workspace create --name core      --cwd "$root/smile-core"                      --focus true
}

# --- zsh-abbr: fish-style abbreviations (reads ~/.config/zsh-abbr/user-abbreviations) ---
source $ZSH/custom/plugins/zsh-abbr/zsh-abbr.zsh

# --- autosuggestions: gray history hints, right-arrow to accept ---
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- secrets (never committed -- see ~/.secret.zsh) ---
[[ -f ~/.secret.zsh ]] && source ~/.secret.zsh

# --- syntax highlighting MUST be sourced last ---
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
