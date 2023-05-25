extends Node3D

var x = 0
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_action_pressed("D"):
		x += 1
	elif Input.is_action_pressed("A"):
		x -= 1
	if Input.is_action_pressed("W"):
		y -= 1
	elif Input.is_action_pressed("S"):
		y += 1
	

func _process(_delta):
	var bounds = get_node("..").get_node("../GameManager").get_x_y_bound()
	var x_left_bound = bounds[0]
	var x_right_bound = bounds[1]
	var y_left_bound = bounds[2]
	var y_right_bound = bounds[3]
	
	var check_x = !(x_left_bound == -1 || x_right_bound == -1)
	var check_y = !(y_left_bound == -1 || y_right_bound == -1)
	
	if check_x:
		x = ((x - x_left_bound) % (x_right_bound - x_left_bound)) + x_left_bound
	elif check_y:
		y = ((y - y_left_bound) % (y_right_bound - y_left_bound)) + y_left_bound
	
	display_input_box()
		
func display_input_box():
	pass

func reset():
	x = 0
	y = 0
