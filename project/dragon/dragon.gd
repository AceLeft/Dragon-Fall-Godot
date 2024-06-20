extends Node2D

var _attacking := false

@onready var _fire = $Fire




func _on_choose_new_attack_timer_timeout() -> void:
	if not _attacking:
		_fire.start()
		$FireTimer.start()
		_attacking = true


func _on_fire_timer_timeout() -> void:
	_fire.stop()
	_attacking = false
