#!/usr/bin/env sh

set -eu
printf '\n'

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
  printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

has() {
  command -v "$1" 1>/dev/null 2>&1
}

download() {
  file="$1"
  url="$2"

  if has curl; then
    cmd="curl --fail --silent --location --output $file $url"
  elif has wget; then
    cmd="wget --quiet --output-document=$file $url"
  elif has fetch; then
    cmd="fetch --quiet --output=$file $url"
  else
    error "No HTTP download program (curl, wget, fetch) found, exiting…"
    return 1
  fi

  $cmd && return 0 || rc=$?

  error "Command failed (exit code $rc): ${BLUE}${cmd}${NO_COLOR}"
  printf "\n" >&2
  return $rc
}

install_docker() {
	sudo apt-get update

	sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io

	sudo apt-get install -y docker-compose
}

install_dependencies() {
	install_docker
}

confirm_tea_id() {
    echo "please enter your tea id...(hex encoded, ie. 0x0000000000000000000000000000000000000000000000000000000000000000)"
    set +e
    read -r TEA_ID </dev/tty
    rc=$?
    set -e
    if [ $rc -ne 0 ]; then
      error "Error reading from prompt (please re-run to type tea id)"
      exit 1
    fi
}

confirm_ip_address() {
    echo "please enter your ip address...(ie. 192.168.1.1)"
    set +e
    read -r IP </dev/tty
    rc=$?
    set -e
    if [ $rc -ne 0 ]; then
      error "Error reading from prompt (please re-run to type ip address)"
      exit 1
    fi
}

confirm_machine_owner() {
    echo "please enter your machine owner layer1 account address...(ie. 5D2od84fg3GScGR139Li56raDWNQQhzgYbV7QsEJKS4KfTGv)"
    set +e
    read -r MACHINE_OWNER </dev/tty
    rc=$?
    set -e
    if [ $rc -ne 0 ]; then
      error "Error reading from prompt (please re-run to type machine owner)"
      exit 1
    fi
}

pre_settings() {
	sudo apt-get install -y git

  info "begin to git clone resources..."
  RESOURCE_DIR=$HOME/delegator-resources
  if [ ! -d "$RESOURCE_DIR" ]; then
  	git clone -b epoch10 https://github.com/tearust/delegator-resources
  	cd $RESOURCE_DIR
  else
  	cd $RESOURCE_DIR

    git fetch origin
  	git reset --hard origin/epoch10
  fi
  completed "clone resources completed"

  ENV_FILE=$RESOURCE_DIR/.env
  if [ ! -f "$ENV_FILE" ]; then
    confirm_tea_id
    echo "TEA_ID=$TEA_ID" > $ENV_FILE

    confirm_ip_address
    echo "IP_ADDRESS=$IP" >> $ENV_FILE

    confirm_machine_owner
    echo "MACHINE_OWNER=$MACHINE_OWNER" >> $ENV_FILE
  fi
}

MEM_SIZE=`grep MemTotal /proc/meminfo | awk '{printf "%.0f", ($2 / 1024)}'`
if [ "$MEM_SIZE" -lt 900 ]; then
  error "Machine memory size should larger equal than 1G"
  exit 1
fi

cd $HOME

info "begin to pre settings..."
pre_settings
completed "pre settings completed"

info "begin to install dependencies..."
install_dependencies
completed "install dependencies completed"

sudo docker-compose down -v
sudo docker-compose up -d

echo "Starting services .... please wait for 30 seconds..."
sleep 30s

completed "docker start completed"