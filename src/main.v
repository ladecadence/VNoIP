module main

import os

fn usage() {
	println('Usage: ')
	println('${os.args[0]} <config file>')
}

fn main() {
	if os.args.len < 2 {
		usage()
		exit(1)
	}
	config := get_config(os.args[1])

	for host in config.hosts {
		ok := update(host)
		println('Host: ${host.hostname} ${ok}')
	}
}
