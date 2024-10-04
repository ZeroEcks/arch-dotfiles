#!/usr/bin/env bash

if ! [ -x "$(command -v shfmt)" ]; then
	echo 'Error: shfmt is not installed.' >&2
	exit 1
fi

shfmt .
