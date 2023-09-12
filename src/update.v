module main

import net.http
import encoding.base64

pub enum NoIPCode as u8 {
	good
	nochg
	nohost
	badauth
	badagent
	donator
	abuse
	c911
	unknown
}

const (
	user_agent_str = 'Ladecadence.net NoIP/0.1 zako@ladecadence.net'
)

fn update(host Host) NoIPCode {
	// create base64 encoded auth header
	auth_str := 'Basic ' + base64.encode_str('${host.username}:${host.password}')

	// create request and add header and params
	mut request := http.Request{
		version: http.Version.v1_0
		method: http.Method.get
		url: host.update_url + '?hostname=${host.hostname}&offline=${host.offline}'
		user_agent: user_agent_str
	}
	// add headers and send request
	request.add_header(http.CommonHeader.authorization, auth_str)
	resp := request.do() or {
		eprintln('Problem sending HTTP request:')
		panic(err)
	}

	// check response
	code := resp.body.trim_space().split_any(' \n')

	return match code[0] {
		'good' { NoIPCode.good }
		'nochg' { NoIPCode.nochg }
		'nohost' { NoIPCode.nohost }
		'badauth' { NoIPCode.badauth }
		'badagent' { NoIPCode.badagent }
		'!donator' { NoIPCode.donator }
		'abuse' { NoIPCode.abuse }
		'911' { NoIPCode.c911 }
		else { NoIPCode.unknown }
	}
}
