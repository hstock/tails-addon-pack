#!/bin/bash

packages_file="$1"
exclude_file="$2"
packages=""
NL=$'\n'

while read -r package; do
	packages="${packages}${NL}${package}${NL}$(apt-rdepends "$package" | grep -P -o '(?<=Depends: )\S+')"
done < "$packages_file"

packages=$(echo "$packages" | sed -E s/:[a-z0-9]+// | sort | uniq)
exclude_packages=$(sed -E s/:[a-z0-9]+// < "$exclude_file" | sort | uniq)
comm -2 -3 <(echo "$packages") <(echo "$exclude_packages")
