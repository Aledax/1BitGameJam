extends Node2D

var character_body

var current_items = []
var current_collision

var finished = false
var finished_stopwatch = 0
var finished_stopwatch_prev = 0

var rocket
var camera
var top
var bottom

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames("player")
	
	rocket = get_tree().get_root().get_node("World/Rocket")
	camera = $CharacterBody/Camera2D
	top = $CharacterBody/Camera2D/Top
	bottom = $CharacterBody/Camera2D/Bottom

func _physics_process(delta):
	
	# Dev time change
#	if Input.is_action_just_pressed("speed_up"):
#		Engine.time_scale += 4
#	if Input.is_action_just_pressed("regular"):
#		Engine.time_scale = 1
	
	# Horizontal input
	var horizontal_movement = 0
	if Input.is_action_pressed("move_left"):
		horizontal_movement -= 1
	if Input.is_action_pressed("move_right"):
		horizontal_movement += 1
	character_body.horizontal_movement = horizontal_movement
	
	# Vertical input
	character_body.just_pressed_jump = Input.is_action_just_pressed("jump")
	character_body.pressing_jump = Input.is_action_pressed("jump")
	
	if finished:
		finished_stopwatch += delta
	
#	# Drop item
#	if Input.is_action_just_pressed("drop_item") && !character_body.is_airborne:
#		drop_item()

	# End cutscene
	if finished:
		if finished_stopwatch < 2:
			top.position.y = lerpf(top.position.y, 168, 0.1)
			bottom.position.y = lerpf(bottom.position.y, -168, 0.1)
		elif finished_stopwatch < 13:
			top.position.y = lerpf(top.position.y, 0, 0.1)
			bottom.position.y = lerpf(bottom.position.y, 0, 0.1)
		elif finished_stopwatch < 14:
			bottom.position.y = lerpf(bottom.position.y, -350, 0.1)
		else:
			get_tree().change_scene_to_file("res://scenes/postgame_text.tscn")
		
		if finished_stopwatch_prev < 1.5 and finished_stopwatch >= 1.5:
			var camera = $CharacterBody/Camera2D
			camera.position_smoothing_enabled = false
			character_body.remove_child(camera)
			$CharacterBody.position.y -= 9999
			$CharacterBody.alive = false
			rocket.add_child(camera)
			get_tree().get_root().get_node("World/NPCs").queue_free()
		if finished_stopwatch_prev < 5 and finished_stopwatch >= 5:
			rocket.get_node("AnimatedSprite2D").animation = "takeoff"
			rocket.get_node("AnimatedSprite2D").play()
			rocket.get_node("AudioPlayer").play()
		if finished_stopwatch_prev < 7 and finished_stopwatch >= 7:
			rocket.get_node("AnimatedSprite2D").animation = "fly"
			rocket.get_node("AnimatedSprite2D").play()
		if finished_stopwatch >= 7:
			rocket.velocity.y -= 1
			rocket.move_and_slide()
			
		finished_stopwatch_prev = finished_stopwatch

func add_item(item):
	character_body.add_child(item)
	current_items.append(item)
	
func delete_item(item):
	current_items.erase(item)
	item.queue_free()
	update_item_positions()
	
#func drop_item():
#	if current_items.size() <= 0: return
#	var dropped = current_items[0]
#	current_items.pop_front()
#	update_item_positions()
#	dropped.drop_item()
	
	
func update_item_positions():
	for i in current_items.size():
		current_items[i].position = Vector2(0, (1+i)*-26)
	
func get_item_count():
	return current_items.size()
	
func finish():
	rocket.get_node("item/InteractSymbol").hide()
	finished = true
	top.show()
	bottom.show()
