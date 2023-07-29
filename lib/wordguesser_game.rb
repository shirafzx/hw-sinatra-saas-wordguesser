class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)

    if letter.nil?
      raise ArgumentError
    end

    letter.downcase!

    unless letter.match?(/[a-z]/)
      raise ArgumentError
    end

    
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      false
    else
      if @word.include?(letter)
        @guesses += letter
        true
      else
        @wrong_guesses += letter
        true
      end
    end
  end

  def word_with_guesses
    displayed = ''
    @word.chars.each do |char|
      if @guesses.include?(char)
        displayed += char
      else
        displayed += '-'
      end
    end
    displayed
  end

  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length == 7
      :lose
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
