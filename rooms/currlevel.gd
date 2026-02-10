extends Node3D


var next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var choose = randf_range(0,3)
	
	if int(choose) == 0:
		next = preload("res://rooms/nextworldleft.tscn")
	if int(choose) == 1:
		next = preload("res://rooms/nextworldstraight.tscn")
	if int(choose) == 2:
		next = preload("res://rooms/nextworldright.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
