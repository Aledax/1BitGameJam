extends Node2D

var character_body

var current_items = []
var current_collision

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames("player")

func _physics_process(_delta):
	
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
	
#	# Drop item
#	if Input.is_action_just_pressed("drop_item") && !character_body.is_airborne:
#		drop_item()

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
	
	
