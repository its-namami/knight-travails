# frozen_string_literal: true

# adds #legal? method to see if board position is allowed
class Array
  def legal?
    case self
    in [0...8, 0...8] then true
    else false
    end
  end
end

# manages a board and moves
class Board
  attr_accessor :position, :knight

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

  def generate_level(position = self.position)
    possible_moves = []

    KNIGHT_MOVES.each do |move|
      result = position.zip(move).map { |x, y| x + y }

      possible_moves << result if result.legal?
    end

    possible_moves
  end
end
