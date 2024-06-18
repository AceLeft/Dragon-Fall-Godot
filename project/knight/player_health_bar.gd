extends Node2D


const _MAX_BAR_LENGTH := 200

@onready var _bar = $HealthBar

func _ready() -> void:
	_bar.size.x = _MAX_BAR_LENGTH

func _on_player_health_lost(total_percentage: float) -> void:
	_bar.size.x = total_percentage * _MAX_BAR_LENGTH
