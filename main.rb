# frozen_string_literal: true

require_relative 'lib/board'

board = Board.new
board.position = [0, 7]
board.knight = [7, 7]
board.position.legal? && board.knight.legal? || raise

puts "Starting point: #{board.position.inspect}"
puts "Knight: #{board.knight.inspect}"

steps = [board.position]
queue = []

until steps.last == board.knight
  board.generate_level(steps.last).each do |level|
    queue << steps + [level]
  end

  steps = queue.shift
end

puts "It took #{steps.size} steps to move the knight from #{board.position} to #{board.knight}"
steps.each { |position| pp position }
