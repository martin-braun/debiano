#!/bin/bash

dirname="$(dirname "$(readlink -f "$0")")"

# Alias definitions.
# You may want to put all your additions into a separate file like
# .bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $dirname/.bash_aliases ]; then
	source $dirname/.bash_aliases
fi

$PATH="$PATH:$dirname"
