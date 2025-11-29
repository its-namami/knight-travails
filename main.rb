# frozen_string_literal: true

require 'pp'
require 'debug'

# add #legal? method to check for legal position on board
class Array
  def legal?
    case self
    in [0...8, 0...8] then true
    else false
    end
  end
end

# manages the 8x8 board
class Board
  attr_accessor :board, :position, :knight

  KNIGHT_MOVES = [
    [1, 2], # Start
    [2, -1],   # Bottom Right
    [1, -2],   # Bottom Right
    [-1, -2],  # Bottom Left
    [-2, -1],  # Bottom Left
    [-1, 2],   # Top Left
    [-2, 1],   # Top Left
    [2, 1]     # End
  ].freeze

  def initialize
    self.board = Array.new(8) { Array.new(8) { |one| one } }.map.with_index do |row, index|
      [index, row]
    end.to_h
  end

  def get(y, x)
    board.dig(y, x)
  end

  def generate_level(position = self.position)
    possible_moves = []

    KNIGHT_MOVES.each do |move|
      result = position.zip(move).map { |x, y| x + y }

      possible_moves << result if result.legal?
    end

    possible_moves
  end
end

board = Board.new
pp(board.board)

board.position = [0, 7]
board.knight = [7, 7]

board.position.legal? && board.knight.legal? || raise

puts "Pos: #{board.position.inspect}"
puts "Kni: #{board.knight.inspect}"

puts board.generate_level.inspect

current_level = [board.position]
queue = []

until current_level.last == board.knight
  board.generate_level(current_level.last).each do |level|
    queue << current_level + [level]
  end

  current_level = queue.shift
end

puts "It took #{current_level.size} steps to move the knight from #{board.position} to #{board.knight}"
current_level.each { |position| pp position }
