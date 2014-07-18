require './tictactoenode.rb'
require './computerplayer.rb'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    tree = TicTacToeNode.new(game.board, mark)

    our_children = tree.children.each

    our_children.each do |child|
      if child.winning_node?(mark)
        p "#{self.name.upcase} IS GOING TO WIN!"
        return child.get_move(game.board)
      end
    end

    our_children = our_children.reject { |child| child.losing_node?(mark) }

    our_children.to_a.sample.get_move(game.board)
  end
end
