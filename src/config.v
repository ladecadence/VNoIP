module main

import toml
import toml.to
import json

pub struct Host {
	update_url string
	username   string
	password   string
	hostname   string
	offline    string
}

pub struct Config {
	hosts []Host
}

fn get_config(config_file string) Config {
	// TOML decoder does not work with arrays of tables, so convert it to JSON and decode the JSON
	doc := toml.parse_file(config_file) or { panic(err) }
	jsondata := to.json(doc)
	config := json.decode(Config, jsondata) or { panic(err) }

	return config
}
