extends GridMap


@export var enhealth := 5
@export var Encount := 30

@export var enemy : PackedScene

func _ready():
	pass



func callspawn() -> void:
	print(Encount)
	if enemy != null:
		for i in range(Encount):
			print("spawned enemy")
			#var inv = false
			
			var en = enemy.instantiate()
			en.health = enhealth
			en.damage = enhealth*75
			get_tree().get_root().get_child(1).add_child(en)
			
			
			#while inv == false:
				#var mappout = local_to_map(Vector3(randf_range(-80,80),0,randf_range(-75,75)))
				#if get_cell_item(mappout) == 0:
			var rand_empty = get_used_cells_by_item(0).pick_random()
			en.global_position = to_global(map_to_local(rand_empty))
			
			
					#en.global_position =  map_to_local(mappout)
					#print(en.position)
			set_cell_item(rand_empty,1)
			#Encount -= 1
					#inv = true
					
	#print(get_used_cells_by_item(1))
	visible = false
