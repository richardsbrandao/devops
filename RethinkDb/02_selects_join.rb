require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl

a = r.table('records').eq_join('artist_id', r.table('artists')).run

a.each {
	|b|
	ap b
}

