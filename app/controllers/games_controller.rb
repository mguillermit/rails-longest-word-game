require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    alphabet = ('A'..'Z').to_a
    10.times do
      @letters << alphabet[rand(0..25)]
    end
    @letters
  end

  def score
    @word = params[:proposed_word]
    @letters = params[:grid]
    @letters_array = @word.split('')

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    api_answer = JSON.parse(open(url).read)
    @correct_word = api_answer["found"]

    @letters_check = []
    @grid_check = []

    @letters_array.each do |letter|
      @letters_check << (@letters_array.count(letter) <= @letters.count(letter))
    end
    @grid_validation = @letters_check.all? { |item| item == true }

    if @grid_validation == false
      @answer = "The letters are not included in the grid"
    elsif @correct_word == false
      @answer = "The letters are in the grid but the word does not exist"
    else
      @answer = "Good job!"
    end
  end

end
