extends Area2D


signal collected()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.coins += 1 # Replace with function body.
		emit_signal("collected")
		queue_free()
