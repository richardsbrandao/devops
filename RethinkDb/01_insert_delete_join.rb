require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl

deletes =r.table('artists').delete().run
puts "Removendo artistas"
ap deletes

deletes =r.table('records').delete().run
puts "Removendo cds"
ap deletes

inserts = r.table('artists').insert([
	{
		'id': 1,
		'name' => 'Muse',
		'debut' => 1994,
		'gender' => 'Rock'
	},
	{
		'id': 2,
		'name' => 'OneRepublic',
		'debut' => 2002,
		'gender' => 'Pop Rock'
	},
	{
		'id': 3,
		'name' => 'Maroon V',
		'debut' => 1994,
		'gender' => 'Pop Rock'
	},
	{
		'id': 4,
		'name' => 'Coldplay',
		'debut' => 1996,
		'gender' => 'Rock'
	},
]).run

puts "Inserindo artistas"
ap inserts

inserts = r.table('records').insert([
	{
		'id' => '1',
		'artist_id' => 1,
		'name' => 'Drones',
		'tracks' => 12
	},
	{
		'id' => '2',
		'artist_id' => 1,
		'name' => 'The 2nd Law',
		'tracks' => 13
	},
	{
		'id' => '3',
		'artist_id' => 2,
		'name' => 'Native',
		'tracks' => 14
	},
	{
		'id' => '4',
		'artist_id' => 3,
		'name' => 'V',
		'tracks' => 14
	},
	{
		'id' => '5',
		'artist_id' => 4,
		'name' => 'Ghost Stories',
		'tracks' => 12
	},
	{
		'id' => '6',
		'artist_id' => 4,
		'name' => 'A Head Full Of Dreams',
		'tracks' => 11
	}
]).run

puts "Inserindo cds"
ap inserts
