extends VisibleOnScreenNotifier2D

var parent

func _on_screen_exited() -> void:
	parent.queue_free()
