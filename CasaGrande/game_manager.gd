extends Node3D

enum States {PLAYER_1_TURN, PLAYER_2_TURN, PLAYER_3_TURN, PLAYER_4_TURN, GAME_OVER}

var curstate = States.PLAYER_4_TURN
var game_ending = false

var players = []

func switch_turn():
	var text = ""
	
	if curstate == States.PLAYER_1_TURN:
		curstate = States.PLAYER_2_TURN
		text = "Player 2: Play"
	elif curstate == States.PLAYER_2_TURN:
		curstate = States.PLAYER_3_TURN
		text = "Player 3: Play"
	elif curstate == States.PLAYER_3_TURN:
		curstate = States.PLAYER_4_TURN
		text = "Player 4: Play"
	elif curstate == States.PLAYER_4_TURN:
		curstate = States.PLAYER_1_TURN
		text = "Player 1: Play"
	
	$UI/RichTextLabel.text = text
	
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
	# Get the current player's token
	
	# If negative, burn bonus tokens
	
	# Move in the corresponding direction
	pass

func lay_block():
	pass

func lay_platforms():
	# Lay it	
	
	# earn money
	
	# Need some sort of recursion w/ question to lay another
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	switch_turn()
	roll_dice()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
