extends Node3D

enum States {PLAYER_1_TURN, PLAYER_2_TURN, PLAYER_3_TURN, PLAYER_4_TURN, GAME_OVER}

# For testing purposes, start with player 4 to loop back to player 1
var curstate = States.PLAYER_4_TURN
var game_ending = false

@export
var players = []
var curr_player

func switch_turn():
	var text = ""
	var player_path = ""
	
	if curstate == States.PLAYER_1_TURN:
		curstate = States.PLAYER_2_TURN
		text = "Player 2: Play"
		player_path = players[1]
	elif curstate == States.PLAYER_2_TURN:
		curstate = States.PLAYER_3_TURN
		text = "Player 3: Play"
		player_path = players[2]
	elif curstate == States.PLAYER_3_TURN:
		curstate = States.PLAYER_4_TURN
		text = "Player 4: Play"
		player_path = players[3]
	elif curstate == States.PLAYER_4_TURN:
		curstate = States.PLAYER_1_TURN
		text = "Player 1: Play"
		player_path = players[0]
	
	curr_player = get_node(player_path)
	
	$UI.display_player(curr_player, text)
	turn()

func turn():
	move_token(roll_dice())
	
func roll_dice():
	# Random logic here
	var rand = RandomNumberGenerator.new()
	var num = int((rand.randf_range(0, 1) * 6) + 1)
	
	# Display the visual
	$UI.display_dice(num)
	
	return num
	
func move_token(spaces):
	curr_player.board_position = (curr_player.board_position + spaces) % 20
	curr_player.position = get_node("../Board").get_pos(curr_player.board_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_turn()
	turn()

func lay_block(x, y, z):
	get_node("../Board").lay_block(x, y, z)
