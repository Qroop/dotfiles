n() {
	local file="/tmp/nvim-cwd"

	if [[ -d "$1" ]]; then
		cd "$1" || return
		nvim .
	else
		nvim "$@"
	fi

	if [ -f "$file" ]; then
		cd "$(cat "$file")" || echo "Failed to cd to saved path"
		rm "$file"
	fi
}

md-to-pdf() {
	curl --data-urlencode "markdown=$(cat $1)" --output $2 https://md-to-pdf.fly.dev/
}
