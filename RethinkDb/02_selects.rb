require 'rethinkdb'
require "awesome_print"
include RethinkDB::Shortcuts

connect = r.connect(:host=>'localhost', :port=>28015).repl

all_authors = r.table('authors').run

puts 'ALL_AUTHORS'
i = 0
all_authors.each{
	|author|
	puts "Document: #{i}"	
	ap author
	i=i+1
}

puts '#########################'

puts 'AUTHORS_BORN_AFTER_1990'

authors_born_after_1990 = r.table('authors').filter{|row|
	row['born'] > Time.new(1990, 1, 1)
}.run

authors_born_after_1990.each {
	|author|
	ap author
}

puts '#########################'

puts "AUTHORS_WITH_MORE_THAN_ONE_SERIES"

authors_with_more_than_one_series = r.table('authors').filter {
	|author|

	author['series'].count() > 1
}.run

authors_with_more_than_one_series.each {
	|author|
	ap author
}
