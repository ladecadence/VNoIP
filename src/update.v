module main

import net.http
import encoding.base64

const (
	user_agent_str = 'Ladecadence.net NoIP/0.1 zako@ladecadence.net'
)

fn update(host Host) bool {
	// create base64 encoded auth header
	auth_str := 'Basic ' + base64.encode_str('${host.username}:${host.password}')

	// create request and add header and params
	mut request := http.Request{
		version: http.Version.v1_0
		method: http.Method.get
		url: host.update_url + '?hostname=${host.hostname}&offline=${host.offline}'
		user_agent: user_agent_str
	}
	request.add_header(http.CommonHeader.authorization, auth_str)
	resp := request.do() or { panic(err) }

	return resp.body.contains('good') || resp.body.contains('nochg')
}
