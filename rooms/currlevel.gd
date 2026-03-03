extends Node3D

@onready var node: Node = $Node

var next




## change of plans. we making beyblade








@onready var player: CharacterBody3D = $player
@onready var rotatebase: Node3D = $rotatebase
@onready var props: Node3D = $rotatebase/props
@onready var camerapos: Node3D = $camerapos
@onready var camerapos_2: Node3D = $camerapos2
@onready var grid_map: GridMap = $rotatebase/GridMap


@export var door : PackedScene = preload("res://gameobjects/door.tscn")



var leavable := false

var read := true




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
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
		
	player.camerabase = camerapos.global_position
	player.var_health = 10000


func change(g:bool)->void:
	leavable = g

	


func _physics_process(delta: float) -> void:
	if grid_map != null && read:
		grid_map.enhealth = node.get_health()
		grid_map.Encount = node.get_count()
		print(grid_map.enhealth)
		print(grid_map.Encount)
		grid_map.callspawn()
		read = false
	
	
	player.var_health -= delta

func _process(delta: float) -> void:
	
	if camerapos != null:
		if camerapos.global_position.distance_to(player.global_position) > 50:
			
			player.camerabase = camerapos_2.position
		elif camerapos.global_position.distance_to(player.global_position) < 50:
			player.camerabase = camerapos.position
	
	if Input.is_action_just_pressed("interact") && leavable:
		read=true
		get_tree().change_scene_to_file(next)
		


func player_damage(numb: int)->void:
	player.var_health -= numb
