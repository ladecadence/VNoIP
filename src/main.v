module main

import os
import os.cmdline

fn usage() {
	println('Usage: ')
	println('${os.args[0]} -c <config file> [-t]')
	println("    -t : test mode, don't send the updates.")
}

fn main() {
	// test mode
	mut test := false

	// check args
	config_file := cmdline.option(os.args, '-c', '')
	if config_file == '' {
		usage()
		exit(1)
	}

	if '-t' in cmdline.only_options(os.args) {
		test = true
	}

	// read configuration
	config := get_config(config_file)

	// send update requests
	if !test {
		for host in config.hosts {
			ok := update(host)
			eprintln('Host: ${host.hostname} ${ok}')
		}
	} else {
		eprintln('Config ok')
	}
}
