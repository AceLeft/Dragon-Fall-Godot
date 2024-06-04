extends RigidBody2D

@onready var _player : Player = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _player.velocity.y != 0:
		linear_velocity.y = _player.velocity.y - .10
	else:
		linear_velocity.y = _player.velocity.y
	
	if _player.velocity.x != 0:
		linear_velocity.x = _player.velocity.x - .10
	else:
		linear_velocity.x = _player.velocity.x
