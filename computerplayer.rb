class ComputerPlayer
  attr_reader :name

  def initialize(name = "Tandy 400")
    @name = name
  end

  def move(game, mark)
    winner_move(game, mark) || random_move(game)
  end

  private

  def winner_move(game, mark)
    (0..2).each do |x|
      (0..2).each do |y|
        board = game.board.dup
        pos = [x, y]

        next unless board.empty?(pos)
        board[pos] = mark

        return pos if board.winner == mark
      end
    end

    # no winning move
    nil
  end

  def random_move(game)
    board = game.board
    loop do
      range = (0..2).to_a
      pos = [range.sample, range.sample]

      return pos if board.empty?(pos)
    end
  end
end
