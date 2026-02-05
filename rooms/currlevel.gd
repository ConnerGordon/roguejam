extends Node3D


var next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var choose = randf_range(0,3)
	
	if (int)choose == 0:
		next = preload()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
