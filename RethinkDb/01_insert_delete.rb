require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl

deletes =r.table('authors').delete().run
puts "Removendo atores"
ap deletes

inserts = r.table('authors').insert([
	{
		'name' => 'Jim Parsons', 'born' => Time.local(1980, 8, 25),
		'series' => [
			{
				'name' => 'The Big Bang Theory', 'debut': 2006
			}
		]
	},
	{
		'name' => 'Grant Gustin', 'born' => Time.local(1990, 1, 25),
		'series' => [
			{'name' => 'Flash', 'debut': 2014},
			{'name' => 'Glee', 'debut': 2011}
		],
		'films': [
			{'name' => 'Pesadelo de Mãe', 'debut': 2012}
		]
	},
]).run

puts "Inserindo 2 atores"
ap inserts