extends RigidBody2D

func pushed_by_player(normal):
	print(normal)
	apply_impulse(Vector2(normal.x, 0))
