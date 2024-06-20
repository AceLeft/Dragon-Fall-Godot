extends Node2D

enum ATTACKS{
	BreatheFire,
	SlamGround
}


var _attacking := false

@onready var _fire = $Fire
@onready var _attack_animator : AnimationPlayer = $AttackAnimations



func _on_choose_new_attack_timer_timeout() -> void:
	if not _attacking:
		var current_attack = ATTACKS.SlamGround
		if current_attack == ATTACKS.BreatheFire:
			_attack_animator.play("lower_jaw")
			_attacking = true
		elif current_attack == ATTACKS.SlamGround:
			pass


func _on_fire_timer_timeout() -> void:
	_fire.stop()
	_attack_animator.play("raise_jaw")


func _on_attack_animations_animation_finished(anim_name):
	if anim_name == "lower_jaw":
		_fire.start()
		$FireTimer.start()
	if anim_name == "raise_jaw":
		_attacking = false
