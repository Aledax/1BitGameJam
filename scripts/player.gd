extends CharacterBody2D

@export var speed = 10000
@export var gravity_d = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed * delta
	if Input.is_action_pressed("move_right"):
		velocity.x = speed * delta
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -250
	
	velocity.y += gravity_d
	
	move_and_slide()
	for i in get_slide_collision_count():
		
		var collision = get_slide_collision(i)
		
		if collision.get_collider().has_method("collide_player"):
			collision.get_collider().collide_player()

