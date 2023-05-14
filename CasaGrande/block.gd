class_name Block extends Node

var player

func _process(delta):
	$MeshInstance3D.get_active_material(0)
	var mat = StandardMaterial3D.new()
	mat.set_albedo(player.new_color)
	$MeshInstance3D.set_surface_override_material(0, mat)	
