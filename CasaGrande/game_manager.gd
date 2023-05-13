extends Node3D

enum States {PLAYER_1_TURN, PLAYER_2_TURN, PLAYER_3_TURN, PLAYER_4_TURN, GAME_OVER}

var curstate = States.PLAYER_1_TURN
var game_ending = false

var players = []

func switch_turn():
	if curstate == States.PLAYER_1_TURN:
		curstate = States.PLAYER_2_TURN
	elif curstate == States.PLAYER_2_TURN:
		curstate = States.PLAYER_3_TURN
	elif curstate == States.PLAYER_3_TURN:
		curstate = States.PLAYER_4_TURN
	elif curstate == States.PLAYER_4_TURN:
		curstate = States.PLAYER_1_TURN
	
	turn()

func turn():
	move_token(roll_dice())
	
func roll_dice():
	# Random logic here
	var rand = RandomNumberGenerator.new()
	var num = int((rand.randf_range(0, 1) * 6) + 1)
	
	# Display the visual
	var dice = $UI/Dice2
	var img = Image.new()
	print(num)
	img.load("res://dice" + str(num) + ".jpg")
	print(img)
	
	var tex = ImageTexture.create_from_image(img)
	print(tex)
	dice.texture = tex
	
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
	roll_dice()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
