n() {
  local file="/tmp/nvim-cwd"
  nvim "$@"
  if [ -f "$file" ]; then
    cd "$(cat "$file")" || echo "Failed to cd to saved path"
    rm "$file"
  fi
}
