extends VisibleOnScreenNotifier2D


func _on_screen_exited() -> void:
	print("kileld it")
	$"./.".queue_free()
