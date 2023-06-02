class_name Player extends Node3D

@export
var new_color = Color(1, 1, 1, 1)

@export
var player_num:int

var money = 0
# Start with 26 tokens, CG rules
var tokens_left = 26

var board_position = 1
# Bonus position defaults to 5 as per CG rules
var bonus_position = 5

@export
var bonus_token:Bonus

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance3D.get_active_material(0)
	var mat = StandardMaterial3D.new()
	mat.set_albedo(new_color)
	$MeshInstance3D.set_surface_override_material(0, mat)

func check_corner():
	if(board_position == 0 || board_position == 5 || board_position == 10 || board_position == 15):
		bonus_position += 3
		if (bonus_position >= 9):
			money += 9
			bonus_position = 0
		else:
			bonus_token.move_bonus()
		
		return true
	return false

func _process(delta):
	if (bonus_position >= 9):
		money += 9
		bonus_position = 0
