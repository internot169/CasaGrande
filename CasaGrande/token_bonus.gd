class_name Bonus extends Node3D

@export
var player:Player

func _ready():
	$MeshInstance3D.get_active_material(0)
	var mat = StandardMaterial3D.new()
	mat.set_albedo(player.new_color)
	$MeshInstance3D.set_surface_override_material(0, mat)
	
	move_bonus()
	
func move_bonus():
	print(player.bonus_position - 1)
	position = get_node("../Board").get_bonus_pos(player.bonus_position - 1)
