class_name Sword
extends CharacterBody2D

const _MAX_SWING_DEGREES := -135

var _attacking := false

var player : Player 
var facing_left := false
@onready var _animation_player : AnimationPlayer = $SwordAnimator


func _ready() -> void:
	_animation_player.play("RESET")


func _process(_delta) -> void:
	if not player:
		printerr("Player should be set!")
	if Input.is_action_pressed("attack") and not _attacking:
		_attacking = true
		if facing_left:
			_animation_player.play("swing_left")
		else:
			_animation_player.play("swing_right")


func _reset_swing() -> void:
	rotation_degrees = 0
	_attacking = false


func _on_sword_animator_animation_finished(anim_name: String) -> void:
	if anim_name.contains("swing"):
		_animation_player.play("RESET")
		_attacking = false
