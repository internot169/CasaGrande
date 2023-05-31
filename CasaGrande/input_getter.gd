extends Node3D

var x = 0
var y = 0

@export
var slowness = 0.1

var paused = false

func get_input():
	if(paused):
		return false
	
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
	
	if Input.is_action_pressed("SPACE"):
		return true
		
	return false

func _process(_delta):
	get_node("Highlighterinput").visible = get_node("..").can_lay_block
	
	if(!get_node("..").can_lay_block):
		return
	
	var lay = await get_input()
		
	var bounds = get_node("..").get_x_y_bound()
	var x_left_bound = bounds[0]
	var x_right_bound = bounds[1]
	var y_left_bound = bounds[2]
	var y_right_bound = bounds[3]
	
	var check_x = (x_left_bound != -1 && x_right_bound != -1)
	var check_y = (y_left_bound != -1 && y_right_bound != -1)
	
	if check_x:
		x = (abs(x - x_left_bound) % (x_right_bound - x_left_bound)) + x_left_bound
		y %= 8
	elif check_y:
		y = (abs(y - y_left_bound) % (y_right_bound - y_left_bound)) + y_left_bound
		x %= 8
	else:
		x %= 8
		y %= 8
	
	if x < 0:
		x = 0
	if y < 0:
		y = 0
	
	var z = get_node("..").get_node("../Board").next_available_z(x, y)
	print(z)
	
	if(lay):
		if (z != -1):
			get_node("..").lay_block(x, y, z)
	
	display_input_box(z)

func display_input_box(z):
	# Each box is width five and height 5
	# Means position of display starts at 2.5 and increases by 5
	# x starts at 0, z starts at -88
	var z_amt = -88.5
	var x_amt = 0
	var pos:Vector3 = Vector3(x_amt + (5 * x), 0.61 + (3 * z), z_amt + (6 * y))
	
	$Highlighterinput.position = pos
