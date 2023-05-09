extends Camera3D

@export
var radius = 100

@export
var speed = 1000

var x = 0
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_user_input(delta):
	if (Input.is_action_pressed("A")):
		x += -1 * speed * delta
	elif (Input.is_action_pressed("D")):
		x += 1 * speed * delta
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_user_input(delta)
	
	var pos = Vector3(radius * cos(x / (2 * PI * radius)), 5.771, 
			radius * sin(x / (2 * PI * radius)))
	
	print(x)
	print(y)
	print(pos)
	
	self.position = pos
