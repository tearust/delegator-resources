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

	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io

	sudo apt-get install -y docker-compose
}

install_dependencies() {
	install_docker

	sudo apt-get install -y git
}

info "begin to install dependencies..."
install_dependencies
completed "install dependencies completed"

info "begin to git clone resources..."
RESOURCE_DIR=delegator-resources
if [ ! -d "$RESOURCE_DIR" ]; then
	git clone https://github.com/tearust/delegator-resources
	cd $RESOURCE_DIR
else
	cd $RESOURCE_DIR
	git fetch origin
	git reset --hard origin/master
fi
info "clone resources completed"

sudo docker-compose up -d

completed "docker start completed"