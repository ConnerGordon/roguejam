extends Node3D


var next

@onready var player: CharacterBody3D = $player
@onready var rotatebase: Node3D = $rotatebase
@onready var props: Node3D = $rotatebase/props
@onready var camerapos: Node3D = $camerapos
@onready var camerapos_2: Node3D = $camerapos2


@export var door : PackedScene = preload("res://gameobjects/door.tscn")
@onready var grid_map: GridMap = $rotatebase/GridMap

var leavable := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	##grid_map.callspawn()
	
	grid_map.visible = false
	player.camerabase = camerapos.global_position
	
	var gen = door.instantiate()
	gen.rotation = rotatebase.rotation + props.rotation
	gen.position = props.global_position
	add_child(gen)
	gen.leave.connect(change)
	
	
	var choose = randf_range(0,3)
	
	if int(choose) == 0:
		next = "res://rooms/nextworldright.tscn"
	if int(choose) == 1:
		next = "res://rooms/nextworldstraight.tscn"
	if int(choose) == 2:
		next = "res://rooms/nextworldright.tscn"
	


func change(g:bool)->void:
	leavable = g


func _physics_process(delta: float) -> void:
	if camerapos != null:
		##print(camerapos.global_position.distance_to(player.global_position))
		if camerapos.global_position.distance_to(player.global_position) > 70:
			
			player.camerabase = camerapos_2.position
		elif camerapos.global_position.distance_to(player.global_position) < 70:
			player.camerabase = camerapos.position

func _process(delta: float) -> void:
	
	
	
	if Input.is_action_just_pressed("interact") && leavable:
		get_tree().change_scene_to_file(next)
