extends CanvasLayer


# Called when the node enters the scene tree for the first time.
@onready var label: Label = %Label
@onready var boom: AudioStreamPlayer = $boom

func _ready() -> void:
	boom.play()
	roomtracker.room=0
	label.text = str( roomtracker.score)

func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://rooms/base_world.tscn")
