# Rock Paper Scissors OOP. 
class Tool
  include Comparable
  attr_accessor :name, :target, :action

  def initialize(name, target, action)
    @name = name
    @target = target
    @action = action  
  end
   
  def <=>(other_tool)
    if self.name == other_tool.name
      0
    elsif self.target == other_tool.name
      1
    elsif other_tool.target == self.name
      -1
    end
  end
end  # Tool

class Player
  attr_accessor :name, :tool, :score
 
  def initialize(name = "Player")
    @name = name
    @score = 0
  end
  
  def select_tool()
    # does it makes sense to get input here? 
    # or shoud we do it in Game and pass the input here?
    begin 
      input = gets.chomp.downcase
      break if Game::TOOLS.keys.include?(input)
      puts "That's not valid choice"
    end while true
    self.tool = Game::TOOLS[input]
  end
end # Player

# AI player is 'automated'
class AIPlayer < Player
  # override select_tool to choose a random tool
  def select_tool
    self.tool = Game::TOOLS.values.sample
  end
end #AIPlayer

class Game
  TOOLS = {"r" => Tool.new("rock", "scissors", "crushes"),
           "p" => Tool.new("paper", "rock", "wraps"),
           "s" => Tool.new("scissors", "paper", "cuts")
          }
  attr_accessor :player, :computer, :tools
  
  def initialize
    @player = Player.new() # use default name until we get user input
    @computer = AIPlayer.new("Computer")
  end
  
  def run
    show_title
    self.player.name = get_player_name
    
    loop do
      show_title
      player_move
      sleep 1
      computer_move
      sleep 1
      check_winner
      sleep 1
      puts "\nPlay again? [Y]es or [N]o"
      break if gets.chomp.downcase != "y"
    end
  end
  
  def get_player_name
    # system('clear')
    puts "What's your name?"
    gets.chomp.capitalize
  end
  
  def show_title
    system('clear')
    puts "\n---------------------------"
    puts "Play Rock Paper Scissors!"
    puts "---------------------------" 
  end
  
  def player_move
    puts "Choose your weapon, #{player.name}:"
    puts "[r]ock, [p]aper or [s]cissors"
    player.select_tool
    print "\n#{player.name} picks #{player.tool.name.capitalize}"
  end
  
  def computer_move
    computer.select_tool
    print "  |  #{computer.name} picks #{computer.tool.name.capitalize}"
  end
  
  def check_winner
    puts "\n"
    if (player.tool == computer.tool)
      puts "It's a tie"
    elsif (player.tool > computer.tool)
      puts "#{player.tool.name.capitalize} #{player.tool.action} #{player.tool.target.capitalize}"
      puts "\n#{player.name} wins!!"
      player.score += 1
    else
      puts "#{computer.tool.name.capitalize} #{computer.tool.action} #{computer.tool.target.capitalize}"
      puts "\nComputer wins!!"
      computer.score += 1
    end
    puts
    puts "Score: #{player.name}: #{player.score}   #{computer.name}: #{computer.score}"
  end
end # Game

# ---------------
# GAME START
# ---------------
game = Game.new.run
