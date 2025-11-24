#! /bin/bash
# Exit immediately if a command exits with a non-zero status.
# Also, pipefail ensures that a pipeline's return status is the last
# command that failed, not just the last one that ran.
set -e
set -o pipefail


packages_to_install=(
    "curl"
    "fzf"
    "gcc"
    "git"
    "grep"
    "jq"
    "neovim"
    "ripgrep"
    "tmux"
    "tree"
    "unzip"
    "wget"
    "zsh"
)


add_repos_commands=(
    # Add your repository commands here.
    "sudo add-apt-repository -y ppa:neovim-ppa/unstable"
)

extra_install_commands=(
    "uv tool install \"vectorcode<1.0.0\""
    "curl -fsSL https://opencode.ai/install | bash"
)

install_bazelisk() {
    # install bazelisk if it is not already installed
    if command -v bazel &> /dev/null; then
        echo "bazelisk is already installed"
        return
    fi
    sudo curl -L https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64 -o /usr/local/bin/bazel
    sudo chmod +x /usr/local/bin/bazel
}

install_nvm() {
    # install nvm if it is not already installed
    if command -v nvm &> /dev/null; then
        echo "nvm is already installed"
        return
    fi
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
}

install_uv() {
    # install uv if it ist not already installed
    if command -v uv &> /dev/null; then
        echo "uv is already installed"
        return
    fi
    curl -LsSf https://astral.sh/uv/install.sh | sh
}

# Function to detect the system's package manager.
detect_package_manager() {
    if command -v apt-get &> /dev/null; then
        echo "apt-get"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    else
        echo "unknown"
    fi
}

# Function to install a list of packages.
install_packages() {
    local pm=$1
    shift
    local packages=("$@")

    echo "Using package manager: $pm"
    echo "Installing the following packages: ${packages_to_install[@]}"

    case "$pm" in
        "apt-get")
            sudo apt-get update
            sudo apt-get install -y "${packages_to_install[@]}"
            ;;
        "dnf")
            sudo dnf install -y "${packages_to_install[@]}"
            ;;
        "yum")
            sudo yum install -y "${packages_to_install[@]}"
            ;;
        "pacman")
            sudo pacman -Syu --noconfirm "${packages_to_install[@]}"
            ;;
        "unknown")
            echo "Error: No supported package manager found (apt-get, dnf, yum, pacman)."
            exit 1
            ;;
    esac
}

# --- Main Script Execution ---

echo "Starting dependency installation script."
read -p "Do you want to proceed with the installation? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # 1. Add custom repositories first.
    if [ ${#add_repos_commands[@]} -gt 0 ]; then
        echo "Adding custom repositories..."
        for cmd in "${add_repos_commands[@]}"; do
            echo "-> Executing: $cmd"
            eval "$cmd"
        done
        echo "Custom repositories added."
    fi

    # 2. Run any extra install commands
    if [ ${#extra_install_commands[@]} -gt 0 ]; then
        echo "Running extra install commands"
        for cmd in "${extra_install_commands[@]}"; do
            echo "-> Executing: $cmd"
            eval "$cmd"
        done
        echo "Extra install commands run"
    fi

    install_nvm


    # 3. Get the package manager and install packages.
    PM=$(detect_package_manager)
    install_packages "$PM" "${packages_to_install[@]}"

    echo "Dependency installation complete."
else
    echo "Installation aborted."
fi
