extends Camera3D

@export
var cam_look_pos:Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(cam_look_pos.position, Vector3.UP)
	look_at(cam_look_pos.position, Vector3.LEFT)
	var dir:Vector3 = position
	
	if Input.is_action_pressed("UP"):
		dir.y += 1
	elif Input.is_action_pressed("DOWN"):
		dir.y += -1
	
	if Input.is_action_pressed("LEFT"):
		dir.x += 1
	elif Input.is_action_pressed("RIGHT"):
		dir.x += -1
	
	position = dir
