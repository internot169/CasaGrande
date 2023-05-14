extends Node3D

@export
var positions = []

func get_pos(id):
	return get_node(positions[id]).position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
