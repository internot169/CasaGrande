class_name Block extends Node

var new_color
var player

var x
var y
var z

func _process(delta):
	$MeshInstance3D.get_active_material(0)
	var mat = StandardMaterial3D.new()
	mat.set_albedo(new_color)
	$MeshInstance3D.set_surface_override_material(0, mat)
