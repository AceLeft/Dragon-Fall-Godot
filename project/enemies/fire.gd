extends Node2D

@onready var _particle_effect: CPUParticles2D = $FireEffect
@onready var _area : Area2D = $DamageArea

func _ready() -> void:
	stop()


func stop() -> void:
	_particle_effect.emitting = false
	_area.monitorable = false


func start() -> void:
	_particle_effect.emitting = true
	_area.monitorable = true
