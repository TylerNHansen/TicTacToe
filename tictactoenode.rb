# Helper class for SuperComputerPlayer
# Builds a tree of successor game states in order to classify moves
# as either winning or losing
class TicTacToeNode
  attr_accessor :turn, :board_state, :last_move, :children

  def initialize(board_state = Board.new, turn = :x)
    @board_state = board_state
    @children = []
    @turn = turn
  end

  def get_move(other_board)
    # return index of move that is nil in other_board
    self.board_state.rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        return [i, j] if other_board.empty?([i, j]) unless el.nil?
      end
    end
  end

  def children
    other_player = ((self.turn == :x) ? :o : :x)
    # For each position in the board state, place a mark there
    # then make a child for that mark and push him into children
    (0...3).each do |i|
      (0...3).each do |j|
        if @board_state.empty?([i, j])
          child_board = make_board([i, j], self.turn)
          child = TicTacToeNode.new(child_board, other_player)
          @children << child
        end
      end
    end
    @children
  end

  #player is :x or :o
  def losing_node?(player)
    if self.board_state.over?
      return false if self.board_state.tied?
      return self.board_state.winner != player
    end

    if player == self.turn
      self.children.each do |child_node|
        return false unless child_node.losing_node?(player)
      end
      return true
    end

    self.children.each do |child_node|
      return true if child_node.losing_node?(player)
    end
    false
  end

  def winning_node?(player)
    if self.board_state.over?
      return false if self.board_state.tied?
      return self.board_state.winner == player
    end

    if player == self.turn
      self.children.each do |child_node|
        return true if child_node.winning_node?(player)
      end
      false
    end

    self.children.each do |child_node|
      return false unless child_node.winning_node?(player)
    end
    true
  end

  def make_board(pos, mark)
    new_board_state = @board_state.dup
    new_board_state[pos] = mark
    new_board_state
  end
end
