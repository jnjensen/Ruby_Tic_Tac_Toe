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
  
    def valid_move(move, board)
      valid = false
  
      until valid
        move -= 1
  
        if move < 0 || move > 8
          puts "Invalid move!"
          puts "where would you like to play (1 - 9)?"
          move = gets.chomp.to_i
        elsif @board[move] != " "
          puts "Invalid move! That space is already taken!"
          puts "where would you like to play (1 - 9)?"
          move = gets.chomp.to_i
        else
          valid = true      
        end
      end
  
      move
    end
  
    def winner(board)
      winner = false
      WIN_COMBINATIONS.each do |combo|
        slots = [@board[combo[0]], @board[combo[1]], @board[combo[2]]]
  
        if !slots.include?(" ")
          if slots[0] == slots[1] && slots[1] == slots [2] && slots[0] == slots[2]
            return true
          end
        end
      end
      winner
    end
  
    def check_game(name, board)
      if !@board.include?(" ")
        puts "Cat's game"
        return true
      elsif winner(board)
        puts " "
        puts "Congratulations! #{name} wins!"
        return true
      end
    end
  
    def move(players, board)
      game_over = false
      puts " 1 | 2 | 3 "
      puts "-----------"
      puts " 4 | 5 | 6 "
      puts "-----------"
      puts " 7 | 8 | 9 "
      puts " "
  
      until game_over do
        @@turn_number += 1
        @@turn_number % 2 == 0 ? current_player = players[1] : current_player = players[0]
  
        puts "#{current_player.name}, where would you like to play (1 - 9)?"
        move = gets.chomp.to_i
        move = valid_move(move, board)
        @board[move] = current_player.token.to_s
        board.display_board
        puts " "
        game_over = check_game(current_player.name, board)
      end
    end
  
  end
  #board abilities -check (winner? draw? over?)
  
  def token_choice
    valid_choice = false
      
    until valid_choice do
      puts "Do you want to be X's or O's?"
      token_choice = gets.chomp.downcase
      if token_choice == "x" || token_choice == "o"
        valid_choice = true
      else
        puts "Invalid Option!"
      end
      puts " "
    end
  
    token_choice.upcase
  end
  
  def create_player
    puts $player_count == 0 ? "Player 1, what is your name?" : "Player 2, what is your name?"
  
    name = gets.chomp.capitalize
    puts " "
  
    if $player_count == 0
      token = token_choice
    else 
      $taken_token == "X" ? token = "O" : token = "X"
    end
    
    player = Player.new(name, token)
    return player
  end
  
  def sort_players(play1, play2)
    play1.token == "X" ? order = [play1, play2] : order = [play2, play1]
    order
  end
  
  def play_new_game
    answered = false
    puts " "
    puts " "
  
    until answered do
      puts "Would you like to play again? (Y or N)"
      answer = gets.chomp.upcase
  
      if answer == "Y"
        puts " "
        puts " "
        game_play
      elsif answer == "N"
        $player_count = 0
        answered = true
      else
        puts "Invalid response."
      end
    end
  end
  
  def game_play
    new_game = GameBoard.new
    new_game.display_board
    player_one = create_player
    player_two = create_player
    play_order = sort_players(player_one, player_two)
    puts "X's go first. #{play_order[0].name}, it's your turn."
    new_game.move(play_order, new_game)
    play_new_game
  
  
  end
  
  game_play