extends Area2D
 
@export var item_name = ""
@export var item_sprite : Texture = null
var in_collision = false
var picked_up = false
var player_node : Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	in_collision = false
	picked_up = false
	$Sprite2D.texture = item_sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("interact") && in_collision && !picked_up:
		print("Interacted with " + item_name + "!")
		pick_up()
	if Input.is_action_just_pressed("drop_item") && picked_up:
		drop_item()

func _on_body_entered(body):
	if body.get_parent().name == "Player":
		print("entered")
		in_collision = true
		player_node = body.get_parent()

func _on_body_exited(body):
	if body.get_parent().name == "Player":
		in_collision = false

func pick_up():
	get_parent().remove_child(self)
	player_node.get_children()[0].add_child(self)
	player_node.holding_item = true
	player_node.current_item = self
	picked_up = true
	self.position = Vector2(0, -26)
	
func drop_item():
	picked_up = false
	var temp = global_position
	var root = get_tree().get_root()
	get_parent().remove_child(self)
	root.add_child(self)
	player_node.holding_item = false
	player_node.current_item = null
	global_position = temp
	
	
