extends Node3D

@export
var new_color = Color(1, 1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance3D.get_active_material(0)
	var mat = StandardMaterial3D.new()
	mat.set_albedo(new_color)
	$MeshInstance3D.set_surface_override_material(0, mat)
