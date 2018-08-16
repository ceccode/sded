#!/usr/bin/env bash
# Mini superset of the docker command that help to cleanup disk space eat by docker

# Traps any error (see https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)
set -e -o pipefail -u

dkrshelp () {
  cat <<EOT
  Usage: $(basename "$0") [h] [l,i,od,du] -- cleanup disk space eat by docker

  where:
    h:   show this help text
    l:   see list of running containers
    i:   see list of stored images
    od:  delete orphaned and dangling volumes
    du:  delete dangling and untagged images
EOT
exit 0
}

argc=${#}
if [[ ${argc} -eq 0 ]]; then
  dkrshelp
fi

cmd=${1}

case ${cmd} in
  h)
    dkrshelp
    ;;
  -h)
    dkrshelp
    ;;    
  l)
    docker ps
    ;;
  i)
    docker images
    ;;    
  od)
    docker volume rm $(docker volume ls -qf dangling=true)
    ;;
  du)
    docker rmi $(docker images -q -f dangling=true)
    ;;    
  *)
    dkrshelp
    ;;
esac
