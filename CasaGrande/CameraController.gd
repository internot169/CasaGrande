extends Camera3D

@export
var radius = 100

var x = 0
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_user_input():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_user_input()
	
	var pos = Vector3(radius * cos(x / (2 * PI * radius)), 5.771, 
			radius * sin(x / (2 * PI * radius)))
	
	print(x)
	print(y)
	print(pos)
	
	self.position = pos
