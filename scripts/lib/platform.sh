detect_platform() {
	local kernel os_release key value id="" id_like=""
	kernel="$(uname -s)" || return 1

	case "$kernel" in
		Darwin)
			echo macos
			return
			;;
		Linux)
			os_release="${1:-/etc/os-release}"
			if [[ -r "$os_release" ]]; then
				while IFS='=' read -r key value; do
					case "$value" in
						\"*\") value="${value:1:${#value}-2}" ;;
						\'*\') value="${value:1:${#value}-2}" ;;
					esac
					case "$key" in
						ID) id="$value" ;;
						ID_LIKE) id_like="$value" ;;
					esac
				done < "$os_release"
			fi
			if [[ "$id" == arch || "$id_like" =~ (^|[[:space:]])arch($|[[:space:]]) ]]; then
				echo arch
				return
			fi
			;;
	esac

	echo unsupported
}

require_platform() {
	if [[ "$PLATFORM" != "$1" ]]; then
		echo "[error] $2 requires $1 (detected: $PLATFORM)" >&2
		return 1
	fi
}
