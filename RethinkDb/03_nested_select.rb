require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl

puts "AUTHORS_WITH_SERIES_DEBUTTED_BEFORE_2010"

authors_with_series_debutted_before_2010 = r.table('authors')
	.get('c1fae39e-4005-4b43-9fd7-2e8dc01903ea')
	.pluck( { 'series' => ['name'] } )
	.run
	
ap authors_with_series_debutted_before_2010

puts '#########################'

a = r.table('authors').filter {
	|author|
	author.has_fields(:films).not
}.pluck( { 'series' => ['name'] } ).run

a.each {
	|author|
	ap author
}

puts '#########################'
#filter in nested field did not work
puts 'Nao consegui listar todas as séries com estreias depois de 2010'