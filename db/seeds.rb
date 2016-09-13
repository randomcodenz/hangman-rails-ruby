# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
WORD_LIST = 'word_list.txt'
MIN_WORD_LENGTH = 3

directory = File.dirname(__FILE__)
all_words = File.open(File.join(directory, WORD_LIST)) do |dictionary|
  dictionary
    .readlines
end
words =
  all_words.select { |word| word.length > MIN_WORD_LENGTH }
    .map { |word| Word.new(:word => word.chomp) }
    .each { |word| word.validate }

Word.transaction do
  words.each(&:save)
end
