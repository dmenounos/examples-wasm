#!/bin/bash

# Custom build directory - e.g., emscripten
if [ "$#" -eq "1" ]; then
	OUTPUT_PATH="${1%/}"

	if [ ! -d "$OUTPUT_PATH" ]; then
		echo "Could not resolve build directory." >&2
		exit 1
	fi

# Default build directories
else
	INVOKE_PATH="$(pwd)"
	SCRIPT_PATH="$(dirname "${BASH_SOURCE}")"
	SCRIPT_PATH="$(cd "$SCRIPT_PATH" && pwd)"

	echo "INVOKE_PATH: $INVOKE_PATH"
	echo "SCRIPT_PATH: $SCRIPT_PATH"

	# Resolve output path (cmake, make)

	if [ -d "$INVOKE_PATH/build" ]; then
		OUTPUT_PATH="$INVOKE_PATH/build"
	elif [ -d "$INVOKE_PATH/out" ]; then
		OUTPUT_PATH="$INVOKE_PATH/out"
	fi

	# Are we running from cmake root path?

	if [ "$INVOKE_PATH" != "$SCRIPT_PATH" ]; then
		PROJECT_DIR="$(basename ${SCRIPT_PATH})"
		OUTPUT_PATH="$OUTPUT_PATH/$PROJECT_DIR"
	fi

	echo "OUTPUT_PATH: $OUTPUT_PATH"

	if [ ! -d "$OUTPUT_PATH" ]; then
		echo "Could not resolve build directory." >&2
		exit 1
	fi

	# Populate output path with web resources

	if [ -d "$SCRIPT_PATH/web" ]; then

		# Copy our files as web root
		cp -rf "$SCRIPT_PATH/web" "$OUTPUT_PATH"

		# Copy generated files to web root
		find "$OUTPUT_PATH" -maxdepth 1 -type f -name "*.js"   | xargs -L 1 -I {} cp -f {} "$OUTPUT_PATH/web"
		find "$OUTPUT_PATH" -maxdepth 1 -type f -name "*.wasm" | xargs -L 1 -I {} cp -f {} "$OUTPUT_PATH/web"

		# Set output path to web root
		OUTPUT_PATH="$OUTPUT_PATH/web"
	fi
fi

emrun --no_browser --port 8080 "$OUTPUT_PATH"
