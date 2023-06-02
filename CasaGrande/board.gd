extends Node3D

@export
var positions = []
@export
var bonus_positions = []

var blocks = [[[]]]
var width = 8
var height = 4
var length = 8

func get_pos(id):
	return get_node(positions[id]).position

func get_bonus_pos(id):
	return get_node(bonus_positions[id]).position

func lay_block(x, y, z):
	if (x >= width || y >= length || z >= height):
		return false
	if(!blocks[x][y][z].available):
		return false
	
	var block = load("res://block.tscn").instantiate()
	
	get_tree().get_root().add_child(block)
	blocks[x][y][z].block = block
	blocks[x][y][z].available = false
	blocks[x][y][z].platform = false
	
	block.new_color = get_node("../GameManager").curr_player.new_color
	block.player = get_node("../GameManager").curr_player
	block.x = x
	block.y = y
	block.z = z
	
	var pos:Vector3 = Vector3((5 * x), (5 * z) + 3.11, -88.5 + (6 * y))
	block.position = pos
	
	get_node("../GameManager").curr_player.tokens_left -= 1
	
	# if(lay_platform(x,y,z)):
	#	get_node("../GameManager").curr_player.money += 3
	
	return true

func platform(x_1, y_1, z_1, x_2, y_2, z_2):
	if (x_1 >= width || y_1 >= length || z_1 >= height || x_2 >= width || y_2 >= length || z_2 >= height):
		return -1	
	if (z_1 != z_2):
		return -1
	elif (x_1 == x_2 && y_1 == y_2):
		return -1
	elif (blocks[x_1][y_1][z_1].platform || blocks[x_2][y_2][z_2].platform):
		return -1
	elif (blocks[x_1][y_1][z_1].block == null || blocks[x_2][y_2][z_2].block == null):
		return -1
	else:
		# NOTE: No absolute value because range can and should go negative
		if (x_1 == x_2):
			# iterate through between the two x values and set all to unavailable
			# instantiate platform, return length
			# make sure to check for length (3,4,5)
			var size = abs(y_2 - y_1)
			if (size == 2 || size == 3 || size == 4):
				# will never be zero due to other checks
				var dir_of_num = (y_2 - y_1) / abs(y_2 - y_1)
				for i in range(y_1 + dir_of_num, y_2, dir_of_num):
					if (blocks[x_1][i][z_1].block != null):
						# undo it all
						for j in range(y_2, i, 1):
							unclaim(blocks[x_1][i][z_1])
							if (z_1 != height - 1):
								blocks[x_1][i][z_1 + 1].available = false
						return -1
					else:
						claim(blocks[x_1][i][z_1], x_1, i, z_1)
					#TODO: make it so that everything is an empty space
					#TODO: enable the multilayer stacking
				claim(blocks[x_1][y_1][z_1], x_1, y_1, z_1)
				claim(blocks[x_2][y_2][z_2], x_2, y_2, z_2)
				return (size + 1) * (z_1 + 1)
			else:
				return -1
		elif (y_1 == y_2):
			# iterate through between the two y values and set all to unavailable
			# instantiate platform, return length
			# make sure to check for length (3,4,5)
			var size = abs(x_2 - x_1)
			if (size == 2 || size == 3 || size == 4):
				var dir_of_num = (x_2-x_1) / abs(x_2-x_1)
				for i in range(x_1 + dir_of_num, x_2, dir_of_num):
					if (blocks[i][y_1][z_1].block != null):
						# undo it all
						for j in range(y_1, i, 1):
							unclaim(blocks[i][y_1][z_1])
							if (z_1 != height - 1):
								blocks[x_1][i][z_1 + 1].available = false
						return -1
					else:
						claim(blocks[i][y_1][z_1], i, y_1, z_1)
					#TODO: make it so that everything is an empty space
					#TODO: enable the multilayer stacking
				claim(blocks[x_1][y_1][z_1], x_1, y_1, z_1)
				claim(blocks[x_2][y_2][z_2], x_2, y_2, z_2)
				return (size + 1) * (z_1 + 1)
			else:
				return -1

func claim(space, x, y, z):
	space.platform = true
	space.available = false
	
	var plat = load("res://platform.tscn").instantiate()
	space.platform_obj = plat
	get_tree().get_root().add_child(plat)
	
	if (z != height - 1):
		blocks[x][y][z + 1].available = true
	
	plat.position = Vector3((5 * x) + 2.5, (5 * z) + 5.61, -86 + (6 * y))

func unclaim(space):
	space.platform = false
	space.available = true
	
	if(space.platform_obj != null):
		space.platform_obj.queue_free()

func next_available_z(x, y):
	for z in range(height):
		if z == 0:
			if blocks[x][y][z].available:
				return z
		else:
			if (blocks[x][y][z].available && blocks[x][y][z-1].platform):
				return z
	return -1

	
func compare(x, y):
	if(x == null || y == null):
		return false
	elif (!x.platform && !y.platform && (x.player == y.player)):
		x.platform = true
		y.platform = true
		return true
	return false

func _ready():
	for i in width:
		blocks.append([])
		for j in length:
			blocks[i].append([])
			for k in height:
				blocks[i][j].append(Space.new())
				if (k == 0):
					blocks[i][j][k].available = true
	# Hardcoded for default initializations
	blocks[0].remove_at(8)
	blocks.remove_at(8)
