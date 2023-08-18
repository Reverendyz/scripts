print_help(){
	echo """
Usage:\t\tadd-asdf-plugin <plugin-name> [version]
Description:\tInstall a plugin version using asdf. If second arg not specified, \"latest\" version is used.

Examples:
	add-asdf-plugin nodejs 20.5.1
	add-asdf-plugin terraform 1.5.0
	add-asdf-plugin kubectl [latest]
	"""
}
validate_args(){
	local arg
	arg=$1

	if [ -z $arg ]; then
	       echo "Required plugin needed as argument."
	       print_help
	       return 1
	fi
	return 0
}

install_plugin(){
	local plugin
	plugin=$1
	validate_args "$plugin"
	if [ $? != 0 ]; then
		return 1
	fi
	local version
	version=${2:-latest}
	asdf plugin-add $(asdf plugin-list-all | grep $1 | awk -F" " '{ print $1" "$2 }')
	asdf install "$plugin" "$version"
	asdf global "$plugin" "$version"

}

alias add-asdf-plugin='install_plugin'
