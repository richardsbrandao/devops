require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl

drop_table = r.db('test').table_drop('records').run
puts "removendo tabela records"
ap drop_table

drop_table = r.db('test').table_drop('artists').run
puts "removendo tabela artists"
ap drop_table


create_table = r.db('test').table_create('records').run
puts "tabela criada"
ap create_table

create_table = r.db('test').table_create('artists').run
puts "tabela criada"
ap create_table