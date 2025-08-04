PLUGIN_REPO_URL=$(git remote get-url origin)
BIN_PATH="$HOME/.local/bin"
PLUGIN_PATH="$HOME/.config/omarchy/plugins"
PLUGIN_NAME=$(basename -s .git "$PLUGIN_REPO_URL")
HYPRLAND_CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

if [ -d "$PLUGIN_PATH/$PLUGIN_NAME" ]; then
  if [ ! -d $BIN_PATH ]; then
    mkdir -p $BIN_PATH
  fi
  echo "PLUGIN $PLUGIN_PATH/$PLUGIN_NAME/bin/*"
  # Installing scripts for plugin
  for file in "$PLUGIN_PATH"/"$PLUGIN_NAME"/bin/*; do
    if [ -f "$file" ]; then
      echo "Installing $file"
      ln -snf "$file" "$BIN_PATH/$(basename "$file")"
    fi
  done
  # Installing hyperland configs for plugin
  for file in "$PLUGIN_PATH"/"$PLUGIN_NAME"/hypr/*; do
    if [ -f "$file" ]; then
      echo "source = $file" >>"$HYPRLAND_CONFIG_FILE"
    fi
  done
fi
