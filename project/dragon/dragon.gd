extends Node2D

enum ATTACKS{
	BreatheFire,
	SlamGround
}

const _INIT_QUAKE_IMPULSE := Vector2(0, -100)
const _QUAKE_IMPULSE_INCREASE := Vector2(0,-29)
const _QUAKE_PIECE_WIDTH := 20

var _attacking := false
var _current_quake_impulse := _INIT_QUAKE_IMPULSE
var _quake_piece_displacement := Vector2(0,0)

@onready var _fire = $Fire
@onready var _attack_animator : AnimationPlayer = $AttackAnimations
@onready var _quake_piece_timer : Timer = $NewQuakePieceTimer
@onready var _quake_piece_scene = preload("res://enemies/quake_piece.tscn")



func _on_new_attack_timer_timeout() -> void:
	if not _attacking:
		var current_attack = ATTACKS.SlamGround
		if current_attack == ATTACKS.BreatheFire:
			_attack_animator.play("lower_jaw")
			_attacking = true
		elif current_attack == ATTACKS.SlamGround:
			_attacking = true
			_attack_animator.play("slam_ground")


func _on_fire_timer_timeout() -> void:
	_fire.stop()
	_attack_animator.play("raise_jaw")


func _on_attack_animations_animation_finished(anim_name):
	if anim_name == "lower_jaw":
		_fire.start()
		$FireTimer.start()
	if anim_name == "raise_jaw":
		_attacking = false
	if anim_name == "slam_ground":
		_quake_piece_timer.start()


func _on_new_quake_piece_timer_timeout() -> void:
	var newest_position : Vector2 =  $QuakeStartMarker.global_position + _quake_piece_displacement
	var quake_piece : RigidBody2D = _quake_piece_scene.instantiate()
	quake_piece.global_position = newest_position
	_quake_piece_displacement -= Vector2(_QUAKE_PIECE_WIDTH, 0)
	add_child(quake_piece)
	quake_piece.apply_impulse(_current_quake_impulse)
	_current_quake_impulse += _QUAKE_IMPULSE_INCREASE

	if newest_position.x <= 0:
		_quake_piece_timer.stop()
		_attacking = false
		# Reset values for the next quake
		_current_quake_impulse = _INIT_QUAKE_IMPULSE
		_quake_piece_displacement = Vector2.ZERO
