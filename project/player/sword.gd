class_name Sword
extends RigidBody2D

var _attacking := false

@onready var _player : Player = $".."
@onready var _animation_player : AnimationPlayer = $SwordAnimator

func _ready() -> void:
	_animation_player.play("reset")

func _process(_delta) -> void:
	if Input.is_action_pressed("attack") and not _attacking:
		_attacking = true
		_animation_player.play("swing_sword")
	
	#Follow the player
	if _player.velocity.y != 0:
		linear_velocity.y = _player.velocity.y - .10
	else:
		linear_velocity.y = _player.velocity.y
	
	if _player.velocity.x != 0:
		linear_velocity.x = _player.velocity.x - .10
	else:
		linear_velocity.x = _player.velocity.x


func _on_sword_animator_animation_finished(anim_name):
	if anim_name == "swing_sword":
		_animation_player.play("reset")
		_attacking = false
