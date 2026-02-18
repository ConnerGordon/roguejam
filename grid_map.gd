extends GridMap



@export var Encount := 30

@export var enemy : PackedScene


#func callspawn() -> void:
	#when (enemy != null)
		###while Encount > 0:
			#var inv = false
			#var en = enemy.instantiate()
			#add_child(en)
			###while inv:
			#var mappout = local_to_map(Vector3(randf_range(-80,80),0,randf_range(-75,75)))
			#print(get_cell_item(mappout))
			#if get_cell_item(mappout) == -1:
				#en.position =  map_to_local(mappout)
				#set_cell_item(mappout,1)
				#Encount = 0
				#
				#print("woh")
					#
