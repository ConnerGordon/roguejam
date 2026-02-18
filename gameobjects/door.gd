extends Area3D

signal leave(bool)

func _on_area_entered(area: Area3D) -> void:
	
	if area.get_parent_node_3d().is_in_group("Player"):
		leave.emit(true)


func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("Player"):
		leave.emit(false)
