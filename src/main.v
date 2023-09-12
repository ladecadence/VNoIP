module main

import os

fn usage() {
	println('Usage: ')
	println('${os.args[0]} <config file>')
}

fn main() {
	// check args
	if os.args.len < 2 {
		usage()
		exit(1)
	}

	// get configuration
	config := get_config(os.args[1])

	// send update requests
	for host in config.hosts {
		ok := update(host)
		eprintln('Host: ${host.hostname} ${ok}')
	}
}
