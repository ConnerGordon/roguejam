extends Area3D


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		if Input.is_action_just_pressed("interact"):
			


func _on_area_exited(area: Area3D) -> void:
	pass # Replace with function body.
