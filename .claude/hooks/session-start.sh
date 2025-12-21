#!/bin/bash
set -euo pipefail

echo Session start hook is running

if uname -s | grep Linux
then
	echo Linux system detected. OK.
else
	exit 0
	# early exit if we are not running on Linux
fi

echo "Setting up CFEngine tutorial environment..."

# Install system dependencies required for softcover gem
# libcurl4-openssl-dev is needed because:
#   - softcover depends on the 'curb' gem
#   - curb has native C extensions that wrap libcurl
#   - compiling these extensions requires libcurl development headers
echo "Installing system dependencies..."
apt-get update -qq
apt-get install -y -qq libcurl4-openssl-dev > /dev/null 2>&1

# Check if softcover is already installed
if ! command -v softcover &> /dev/null; then
  echo "Installing softcover gem..."
  gem install softcover --no-document
else
  echo "Softcover gem already installed"
fi

# Add Ruby gem bin directory to PATH for the session
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  GEM_BIN_DIR="$(ruby -e 'puts Gem.bindir')"
  echo "export PATH=\"${GEM_BIN_DIR}:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi

echo "Environment setup complete!"
echo "You can now build the book with: cd source && bash build_softcover.sh"
