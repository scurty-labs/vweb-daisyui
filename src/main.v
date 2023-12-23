module main

import x.vweb

const (
	port = 8082
)

pub struct Context {
	vweb.Context
}

pub struct App {
	vweb.StaticHandler
pub mut:
	dev_mode bool @[vweb_global]
}

fn main() {

	mut app := &App{}

	$if dev ? {
		app.dev_mode = true
		app.mount_static_folder_at('dev', '/dev')!
		println("Live develop mode is active!")
	}$else{
		app.mount_static_folder_at('static', '/static')!
	}

	vweb.run[App, Context](mut app, port)
}

pub fn (mut app App) index(mut ctx Context) vweb.Result {
	return ctx.html($tmpl('templates/index.html'))
}
