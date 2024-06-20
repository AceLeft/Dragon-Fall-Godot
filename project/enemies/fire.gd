extends Node2D

@onready var _particle_effect: CPUParticles2D = $FireEffect
@onready var _collision : CollisionPolygon2D = $DamageArea/CollisionShape2D

func _ready() -> void:
	stop()


func stop() -> void:
	_particle_effect.emitting = false
	_collision.disabled = true


func start() -> void:
	_particle_effect.emitting = true
	_collision.disabled = false
