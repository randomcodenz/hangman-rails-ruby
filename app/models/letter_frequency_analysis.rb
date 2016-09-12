class LetterFrequencyAnalysis
  class << self
    def letters_by_frequency
      letters_ordered_by_frequency(relative_letter_frequency)
    end

    def letter_ranking_map
      letters_by_frequency
        .each_with_index
        .map { |value, index| [value, index + 1] }
        .to_h
    end

    def following_letters_by_frequency(letter)
      return [] unless letter =~ /^[A-Za-z]{1}$/

      following_letter_frequencies = bigram_frequency[letter.downcase]
      letters_ordered_by_frequency(following_letter_frequencies)
    end

    def preceeding_letters_by_frequency(letter)
      return [] unless letter =~ /^[A-Za-z]{1}$/

      letters_ordered_by_frequency(preceeding_letter_frequency(letter))
    end

    private

    def preceeding_letter_frequency(letter)
      preceeding_letter_frequencies = bigram_frequency
        .collect { |first_letter, bigram_row| [first_letter, bigram_row[letter.downcase]] }
        .to_h
      remove_keys_with_default_value(preceeding_letter_frequencies, 0)
    end

    def letters_ordered_by_frequency(letter_frequencies)
      letter_frequencies
        .sort_by { |letter, frequency| [-frequency, letter] }
        .collect { |letter, frequency| letter }
    end

    def relative_letter_frequency
      @@relative_letter_frequency ||= build_relative_letter_frequency
      @@relative_letter_frequency
    end

    def bigram_frequency
      @@bigram_frequency ||= build_bigram_frequency
      @@bigram_frequency
    end

    def build_relative_letter_frequency
      # From https://en.wikipedia.org/wiki/Letter_frequency
      relative_letter_frequency_list = [8.167, 1.492, 2.782, 4.253, 12.702, 2.228, 2.015,
        6.094, 6.966, 0.153, 0.772, 4.025, 2.406, 6.749, 7.507, 1.929, 0.095, 5.987,
        6.327, 9.056, 2.758, 0.978, 2.360, 0.150, 1.974, 0.074]
      convert_to_letter_indexed_hash(relative_letter_frequency_list)
    end

    def build_bigram_frequency
      # From http://homepages.math.uic.edu/~leon/mcs425-s08/handouts/char_freq2.pdf
      bigram_frequency_table = [
        [1, 20, 33, 52, 0, 12, 18, 5, 39, 1, 12, 57, 26, 181, 1, 20, 1, 75, 95, 104, 9, 20, 13, 1, 26, 1],
        [11, 1, 0, 0, 47, 0, 0, 0, 6, 1, 0, 17, 0, 0, 19, 0, 0, 11, 2, 1, 21, 0, 0, 0, 11, 0],
        [31, 0, 4, 0, 38, 0, 0, 38, 10, 0, 18, 9, 0, 0, 45, 0, 1, 11, 1, 15, 7, 0, 0, 0, 1, 0],
        [48, 20, 9, 13, 57, 11, 7, 25, 50, 3, 1, 11, 14, 16, 41, 6, 0, 14, 35, 56, 10, 2, 19, 0, 10, 0],
        [110, 23, 45, 126, 48, 30, 15, 33, 41, 3, 5, 55, 47, 111, 33, 28, 2, 169, 115, 83, 6, 24, 50, 9, 26, 0],
        [25, 2, 3, 2, 20, 11, 1, 8, 23, 1, 0, 8, 5, 1, 40, 2, 0, 16, 5, 37, 8, 0, 3, 0, 2, 0],
        [24, 3, 2, 2, 28, 3, 4, 35, 18, 1, 0, 7, 3, 4, 23, 1, 0, 12, 9, 16, 7, 0, 5, 0, 1, 0],
        [114, 2, 2, 1, 302, 2, 1, 6, 97, 0, 0, 2, 3, 1, 49, 1, 0, 8, 5, 32, 8, 0, 4, 0, 4, 0],
        [10, 5, 32, 33, 23, 17, 25, 6, 1, 1, 8, 37, 37, 179, 24, 6, 0, 27, 86, 93, 1, 14, 7, 2, 0, 2],
        [2, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0],
        [6, 1, 1, 1, 29, 1, 0, 2, 14, 0, 0, 2, 1, 9, 4, 0, 0, 0, 5, 4, 1, 0, 2, 0, 2, 0],
        [40, 3, 2, 36, 64, 10, 1, 4, 47, 0, 3, 56, 4, 2, 41, 3, 0, 2, 11, 15, 8, 3, 5, 0, 31, 0],
        [44, 7, 1, 1, 68, 2, 1, 3, 25, 0, 0, 1, 5, 2, 29, 11, 0, 3, 10, 9, 8, 0, 4, 0, 18, 0],
        [40, 7, 25, 146, 66, 8, 92, 16, 33, 2, 8, 9, 7, 8, 60, 4, 1, 3, 33, 106, 6, 2, 12, 0, 11, 0],
        [16, 12, 13, 18, 5, 80, 7, 11, 12, 1, 13, 26, 48, 106, 36, 15, 0, 84, 28, 57, 115, 12, 46, 0, 5, 1],
        [23, 1, 0, 0, 30, 1, 0, 3, 12, 0, 0, 15, 1, 0, 21, 10, 0, 18, 5, 11, 6, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0],
        [50, 7, 10, 20, 133, 8, 10, 12, 50, 1, 8, 10, 14, 16, 55, 6, 0, 14, 37, 42, 12, 4, 11, 0, 21, 0],
        [67, 11, 17, 7, 74, 11, 4, 50, 49, 2, 6, 13, 12, 10, 57, 20, 2, 4, 43, 109, 20, 2, 24, 0, 4, 0],
        [59, 10, 11, 7, 75, 9, 3, 330, 76, 1, 2, 17, 11, 7, 115, 4, 0, 28, 34, 56, 17, 1, 31, 0, 16, 0],
        [7, 5, 12, 7, 7, 2, 14, 2, 8, 0, 1, 34, 8, 36, 1, 16, 0, 44, 35, 48, 0, 0, 2, 0, 1, 0],
        [5, 0, 0, 0, 65, 0, 0, 0, 11, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
        [66, 1, 1, 2, 39, 1, 0, 44, 39, 0, 0, 2, 1, 12, 29, 0, 0, 3, 4, 4, 1, 0, 2, 0, 1, 0],
        [1, 0, 2, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0],
        [18, 7, 6, 6, 14, 7, 3, 10, 11, 1, 1, 4, 6, 3, 36, 4, 0, 3, 19, 20, 1, 1, 12, 0, 2, 0],
        [1, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      ]
      bigram_row_hashes = bigram_frequency_table.map do |bigram_row|
        row_hash = convert_to_letter_indexed_hash(bigram_row)
        remove_keys_with_default_value(row_hash, 0)
      end
      convert_to_letter_indexed_hash(bigram_row_hashes)
    end

    def convert_to_letter_indexed_hash(array)
      ('a'..'z').to_a.zip(array).to_h
    end

    def remove_keys_with_default_value(hash, default_value)
      compacted_hash = hash.delete_if { |key, value| value == default_value }
      compacted_hash.default = default_value
      compacted_hash
    end
  end
end
