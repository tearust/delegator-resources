#!/usr/bin/env sh

MY_TEA_ID=$1
MY_LAYER1_ACCOUNT=$2

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

set_tea_id() {
  sed -ri "s@^(\s*)(TEA_ID:\s*.*$)@\1TEA_ID: ${MY_TEA_ID}@" docker-compose.yaml
}

set_account_phrase() {
  sed -ri "s@^(\s*)(LAYER1_ACCOUNT:\s*.*$)@\1LAYER1_ACCOUNT: ${MY_LAYER1_ACCOUNT}@" docker-compose.yaml
}

pre_settings() {
  if [ -z "$MY_TEA_ID" ]; then
    error "please input \"Machine Id\""
    exit 1
  fi

  if [ -z "$MY_LAYER1_ACCOUNT" ]; then
    error "please input \"Account Phrase\""
    exit 1
  fi

	sudo apt-get install -y git

  info "begin to git clone resources..."
  RESOURCE_DIR=delegator-resources
  if [ ! -d "$RESOURCE_DIR" ]; then
  	git clone -b epoch6 https://github.com/tearust/delegator-resources
  	cd $RESOURCE_DIR
  else
  	cd $RESOURCE_DIR
  	git fetch origin
  	git reset --hard origin/epoch6
  fi
  completed "clone resources completed"

  set_tea_id
  set_account_phrase
}

MEM_SIZE=`grep MemTotal /proc/meminfo | awk '{printf "%.0f", ($2 / 1024)}'`
if [ "$MEM_SIZE" -lt 1800 ]; then
  error "Machine memory size should larger equal than 2G"
  exit 1
fi

info "begin to pre settings..."
pre_settings
completed "pre settings completed"

info "begin to install dependencies..."
install_dependencies
completed "install dependencies completed"

sudo docker-compose up -d

completed "docker start completed"