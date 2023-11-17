extends CharacterBody2D

var wave_horizontal_speed = 10

func _physics_process(delta):
	$LeftWaves.region_rect.position.x += wave_horizontal_speed * delta
	$RightWaves.region_rect.position.x -= wave_horizontal_speed * delta
	
	move_and_slide()

func _ocean_rise_event(speed):
	print("RISE!")
	velocity.y = -speed

func _on_death_box_body_entered(body):
	if body.name == "CharacterBody":
		body.kill()
