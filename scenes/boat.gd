extends RigidBody2D

var player_body_name = "PlayerBody"
var interface_off_texture = load("res://art/environment/boat/interface_off.png")
var interface_on_texture = load("res://art/environment/boat/interface_on.png")
var interface_left_sprite
var interface_right_sprite

var left_activated = false
var right_activated = false

var horizontal_max_speed = 50.0
var horizontal_acceleration = 5.0

func _ready():
	interface_left_sprite = get_node("InterfaceLeft/Sprite2D")
	interface_right_sprite = get_node("InterfaceRight/Sprite2D")

func _process(delta):
	linear_velocity.y = -position.y
	
	var moving = false
	if Input.is_action_pressed("interact"):
		if left_activated:
			linear_velocity.x = max(-horizontal_max_speed, linear_velocity.x - horizontal_acceleration)
			moving = true
		if right_activated:
			linear_velocity.x = min(horizontal_max_speed, linear_velocity.x + horizontal_acceleration)
			moving = true
	if not moving:
		linear_velocity.x *= 0.95

func _on_interface_left_body_entered(body):
	if body.name == player_body_name:
		interface_left_sprite.texture = interface_on_texture
		left_activated = true

func _on_interface_left_body_exited(body):
	if body.name == player_body_name:
		interface_left_sprite.texture = interface_off_texture
		left_activated = false

func _on_interface_right_body_entered(body):
	if body.name == player_body_name:
		interface_right_sprite.texture = interface_on_texture
		right_activated = true

func _on_interface_right_body_exited(body):
	if body.name == player_body_name:
		interface_right_sprite.texture = interface_off_texture
		right_activated = false
