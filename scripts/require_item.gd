extends Area2D

@export var _name = ""
@export var _sprite : Texture = null
@export var required_item : Node2D = null
var in_collision = false
var player_node : Node2D = null
var interact_symbol

signal correct_item_brought

# Called when the node enters the scene tree for the first time.
func _ready():
	in_collision = false
	$Sprite2D.texture = _sprite
	interact_symbol = $InteractSymbol
	interact_symbol.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && in_collision:
		check_for_item()

func _on_body_entered(body):
	if body.get_parent().name == "Player":
		in_collision = true
		player_node = body.get_parent()
		interact_symbol.show()

func _on_body_exited(body):
	if body.get_parent().name == "Player":
		in_collision = false
		interact_symbol.hide()
		
func check_for_item():
	if required_item in player_node.current_items:
		print("You have the item~")
		$UnlockPlayer.play()
		correct_item_brought.emit()
		player_node.delete_item(required_item)
	else:
		print("You don't have the right item!")

func delete_self():
	queue_free() # THIS ONLY REMOVES THE CHILD FROM THE TREE, IT DOES NOT DELETE IT
