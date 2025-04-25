CUR_DIR=$(pwd)
mkdir -p ~/.config
current_file_path=$(realpath "$0")
root_path=$(dirname "$current_file_path")
ln -sf ${root_path}/.tmux.conf ~/.tmux.conf
