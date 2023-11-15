extends CharacterBody2D

var body_parent_name = "Player"
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

func _physics_process(_delta):
	if position.y > 0:
		velocity.y = -position.y
	else:
		velocity.y = -position.y * 10
	
	var moving = false
	if Input.is_action_pressed("interact"):
		if left_activated:
			velocity.x = max(-horizontal_max_speed, velocity.x - horizontal_acceleration)
			moving = true
		if right_activated:
			velocity.x = min(horizontal_max_speed, velocity.x + horizontal_acceleration)
			moving = true
	if not moving:
		velocity.x *= 0.95
	
	move_and_slide()
	for i in get_slide_collision_count():
		
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()
		
		if collision.get_collider().has_method("pushed_by_boat") and abs(normal.x) > abs(normal.y):
			collision.get_collider().pushed_by_boat(normal.x < 0)

func _on_interface_left_body_entered(body):
	if body.get_parent().name == body_parent_name:
		interface_left_sprite.texture = interface_on_texture
		left_activated = true

func _on_interface_left_body_exited(body):
	if body.get_parent().name == body_parent_name:
		interface_left_sprite.texture = interface_off_texture
		left_activated = false

func _on_interface_right_body_entered(body):
	if body.get_parent().name == body_parent_name:
		interface_right_sprite.texture = interface_on_texture
		right_activated = true

func _on_interface_right_body_exited(body):
	if body.get_parent().name == body_parent_name:
		interface_right_sprite.texture = interface_off_texture
		right_activated = false
