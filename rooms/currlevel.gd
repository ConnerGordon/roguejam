extends Node3D


var next

@onready var player: CharacterBody3D = $player





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var choose = randf_range(0,3)
	
	if int(choose) == 0:
		next = preload("res://rooms/nextworldleft.tscn")
	if int(choose) == 1:
		next = preload("res://rooms/nextworldstraight.tscn")
	if int(choose) == 2:
		next = preload("res://rooms/nextworldright.tscn")
	



func _on_player_getout() -> void:
	get_tree().change_scene_to_file(next)
