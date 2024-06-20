extends Node2D

var _attacking := false

@onready var _fire = $Fire
@onready var _attack_animator : AnimationPlayer = $AttackAnimations



func _on_choose_new_attack_timer_timeout() -> void:
	if not _attacking:
		_attack_animator.play("lower_jaw")
		_attacking = true


func _on_fire_timer_timeout() -> void:
	_fire.stop()
	_attack_animator.play("raise_jaw")


func _on_attack_animations_animation_finished(anim_name):
	if anim_name == "lower_jaw":
		_fire.start()
		$FireTimer.start()
	if anim_name == "raise_jaw":
		_attacking = false
