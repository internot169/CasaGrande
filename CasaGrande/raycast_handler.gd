extends Node3D

const RAY_LENGTH = 1000

var is_clicking = false
var click_count = 0
var first_block = null
var second_block = null

func handle_block(block:Block):
	if(is_clicking):
		if(click_count == 0):
			first_block = block
			click_count += 1
		elif(click_count == 1):
			second_block = block
			
			if(first_block.player == second_block.player):
				var worked = get_node("..").get_node("../Board").platform(first_block.x, first_block.y, first_block.z, second_block.x, second_block.y, second_block.z)
				if worked != -1:
					pass
			
			# Turns off the clicking and terminates UI as well
			get_node("../UI")._on_end_platform_pressed()
		
		
func _physics_process(delta):
	if Input.is_action_just_pressed("click") and is_clicking:
		var space_state = get_world_3d().direct_space_state
		
		var cam = get_node("..").get_node("../Camera3D")
		var mousepos = get_viewport().get_mouse_position()
		
		var origin = cam.project_ray_origin(mousepos)
		var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
		
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		var output = space_state.intersect_ray(query)
		
		if output != null:
			if output != {} and output["collider"].is_in_group("Block"):
				handle_block(output["collider"].get_node(".."))
			

func start_clicking():
	is_clicking = true
	first_block = null
	second_block = null
	click_count = 0
	
func stop_clicking():
	is_clicking = false
	first_block = null
	second_block = null
	click_count = 0
