class Player
    attr_reader :name, :token
    $player_count = 0
    $taken_token = ""
  
    def initialize(name, token)
      @name = name
      @token = token
      $taken_token = token
      $player_count += 1
    end
  
    def move
    end
  end
  #users abilities -move (check valid), forfeift
  class GameBoard
    @@turn_number = 0
    WIN_COMBINATIONS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2]
    ]
  
    def initialize
      @board = Array.new(9, " ")
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
  end
  #board abilities -check (winner? draw? over?)
  
  def token_choice
    valid_choice = false
      
    until valid_choice do
      puts "Do you want to be X's or O's?"
      token_choice = gets.chomp.downcase
      if token_choice == "x" || "o"
        valid_choice = true
      else
        puts "Invalid Option!"
      end
    end
  
    token_choice.upcase
  end
  
  def create_player
    if $player_count == 0
      puts "Player 1, what is your name?"
    else
      puts "Player 2, what is your name?"
    end
  
    name = gets.chomp.capitalize
  
    if $player_count == 0
      token = token_choice
    else 
      if $taken_token == "X"
        token = "O"
      else
        token = "X"
      end
    end
    
    player = Player.new(name, token)
    return player
  end
  
  def sort_players(play1, play2)
    if play1.token == "X"
      order = [play1, play2]
    else
      order = [play2, play1]
    end
    order
  end
  
  def game_play
    new_game = GameBoard.new
    new_game.display_board
    player_one = create_player
    player_two = create_player
    play_order = sort_players(player_one, player_two)
    puts "X's go first. #{play_order[0].name}, it's your turn."
  end
  
  game_play