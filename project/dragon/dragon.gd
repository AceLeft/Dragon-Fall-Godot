extends Node2D

enum ATTACKS{
	BreatheFire,
	SlamGround,
	HitCeiling
}

const _INIT_QUAKE_IMPULSE := Vector2(0, -100)
const _QUAKE_IMPULSE_INCREASE := Vector2(0,-29)
const _QUAKE_PIECE_WIDTH := 20

var _attacking := false
var _current_quake_impulse := _INIT_QUAKE_IMPULSE
var _quake_piece_displacement := Vector2(0,0)
var _attacks_list := []

@onready var _fire = $Fire
@onready var _attack_animator : AnimationPlayer = $AttackAnimations
@onready var _quake_piece_timer : Timer = $NewQuakePieceTimer
@onready var _quake_piece_scene = preload("res://enemies/quake_piece.tscn")


func _ready() -> void:
	_attack_animator.play("RESET")
	for attack in ATTACKS.values():
		_attacks_list.append(attack)
	

func _on_new_attack_timer_timeout() -> void:
	if not _attacking:
		var current_attack = _attacks_list.pick_random()
		_attacking = true
		if current_attack == ATTACKS.BreatheFire:
			_attack_animator.play("lower_jaw")
		elif current_attack == ATTACKS.SlamGround:
			_attack_animator.play("slam_ground")
		elif current_attack == ATTACKS.HitCeiling:
			_attack_animator.play("hit_head")


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
	if anim_name == "hit_head":
		_attack_animator.play("recover_head")
	if anim_name == "recover_head":
		_attacking = false
	


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
