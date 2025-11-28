# frozen_string_literal: true

require 'pp'
require 'debug'

# manages the board
class Board
  attr_accessor :board, :position, :knight

  MOVES = [
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
    MOVES.inject([]) do |possible_moves, move|
      result = position.zip(move).map { |x, y| x + y }

      if (0...8).include?(result[0]) && (0...8).include?(result[1])
        possible_moves << result
      else
        possible_moves
      end
    end
  end
end

board = Board.new
pp(board.board)

board.position = [0, 0]
board.knight = [7, 7]
puts "Pos: #{board.position.inspect}"
puts "Kni: #{board.knight.inspect}"

levels = [board.generate_level]
steps = 1

until levels.any? { |level| level.any? { |pos| pos.eql?(board.knight) } }
  levels_clone = levels.clone
  new_level = []
  steps += 1

  levels_clone.each do |level|
    level.each { |pos| new_level << board.generate_level(pos) }
  end

  levels += new_level
end

puts "It took #{steps} steps to got from p#{board.position} to k#{board.knight}"
