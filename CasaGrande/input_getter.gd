extends Node3D

# Input value x and y
var x = 0
var y = 0

# Bounded value x and y
var mov_x
var mov_y

@export
var slowness = 0.1

var paused = false

func get_input():
	if(paused):
		return
	
	paused = true
	await get_tree().create_timer(slowness).timeout
	paused = false
	
	if Input.is_action_pressed("D"):
		x += 1
	elif Input.is_action_pressed("A"):
		x -= 1
	if Input.is_action_pressed("W"):
		y -= 1
	elif Input.is_action_pressed("S"):
		y += 1
	

func _process(_delta):
	get_input()
	
	mov_x = x
	mov_y = y
	
	var bounds = get_node("../GameManager").get_x_y_bound()
	var x_left_bound = bounds[0]
	var x_right_bound = bounds[1]
	var y_left_bound = bounds[2]
	var y_right_bound = bounds[3]
	
	var check_x = x_left_bound != -1 && x_right_bound != -1
	var check_y = y_left_bound != -1 && y_right_bound != -1
	
	if check_x:
		mov_x = ((mov_x - x_left_bound) % (x_right_bound - x_left_bound)) + x_left_bound
		mov_y = loop_around(mov_y)
	elif check_y:
		mov_y = ((mov_y - y_left_bound) % (y_right_bound - y_left_bound)) + y_left_bound
		mov_x = loop_around(mov_x)
	else:
		mov_x = loop_around(mov_x)
		mov_y = loop_around(mov_y)
	print(mov_x)
	print(mov_y)
	display_input_box()
		
func loop_around(val):
	if (val < 0):
		val = 8
	else:
		val = abs(val) % 8
	return val
	
func display_input_box():
	# Each box is width five and height 5
	# Means position of display starts at 2.5 and increases by 5
	# x starts at 0, z starts at -88
	var z_amt = -88.5
	var x_amt = 0
	var pos:Vector3 = Vector3(x_amt + (5 * mov_x), 0.61, z_amt + (6 * mov_y))
	
	get_node("Highlighterinput").position = pos

func reset():
	x = 0
	y = 0
