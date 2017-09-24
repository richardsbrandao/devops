require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl
puts "conectado"
ap connect

drop_table = r.db('test').table_drop('authors').run
puts "removendo tabela authors"
ap drop_table

create_table = r.db('test').table_create('authors').run
puts "tabela criada"
ap create_table