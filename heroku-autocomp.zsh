# heroku autocomplete setup
export HEROKU_AC_ANALYTICS_DIR=~/.cache/heroku/autocomplete/completion_analytics;
export HEROKU_AC_COMMANDS_PATH=~/.cache/heroku/autocomplete/commands;
HEROKU_AC_ZSH_SETTERS_PATH=${HEROKU_AC_COMMANDS_PATH}_setters && test -f $HEROKU_AC_ZSH_SETTERS_PATH && source $HEROKU_AC_ZSH_SETTERS_PATH;

fpath+=~/.local/share/heroku/node_modules/@heroku-cli/plugin-autocomplete/autocomplete/zsh
