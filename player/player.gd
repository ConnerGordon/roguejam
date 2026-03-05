extends CharacterBody3D
class_name Player

@export var gameover : PackedScene = preload("res://game_over.tscn")


@onready var ui: CanvasLayer = $UI
@onready var label: Label = $UI/VBoxContainer/Label
@onready var rotpiv: Node3D = $rotpiv
@onready var rotspd = 15

@onready var camera_3d: Camera3D = $Camera3D



@onready var swingabl: Timer = $swingabl
@onready var dashing: Timer = $dashing

@onready var hitbox: Area3D = $hitbox
@onready var cooldown: Timer = $cooldown



@export var spincurve : Curve

var camerabase : Vector3
var last := Vector3.BACK


@onready var starthp = 10000.0

const SPEED = 15.0
const accel = SPEED * 20.0/8.0
const JUMP_VELOCITY = 4.5


var sword = true
var gun = false


var var_health : float :
	set(new_health):
		var_health = new_health
		label.text = "velocity: " + str(int(var_health))
		if var_health <1:
			get_tree().change_scene_to_file("res://game_over.tscn")



func _ready() -> void:
	var_health = starthp
	

func _physics_process(delta: float) -> void:
	if camerabase != null:
		camera_3d.global_position = camera_3d.global_position.lerp(camerabase,delta*8)
			
	camera_3d.look_at(global_position)
	

	
	var_health -= delta * 50
	if not is_on_floor():
		velocity.y += -9.8 * delta
		

	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	var forward := camera_3d.global_basis.z
	var right := camera_3d.global_basis.x
	
	var movedir := forward * input_dir.y + right * input_dir.x
	movedir.y = 0.0
	movedir = movedir.normalized()
	
	velocity = velocity.move_toward(movedir * SPEED * var_health/1000, accel*delta )
	if Input.is_action_just_pressed("dash") && dashing.is_stopped():
		var_health -= 100
		velocity = velocity.move_toward(last * SPEED * 3, accel*2)
		dashing.start()
	
	
	if movedir.length() > 0.2:
		last = movedir
	
	rotpiv.rotation_degrees +=Vector3(0, spincurve.sample(var_health/starthp),0)
	
	if sword:
		
		if Input.is_action_just_pressed("die"):
			var_health = 0
		
		if Input.is_action_just_pressed("attack") && swingabl.is_stopped()&& cooldown.is_stopped():
			
			hitbox.monitoring = true
			swingabl.start()
			
	move_and_slide()
	
	
	

func _on_dashing_timeout() -> void:
	velocity.clampf(-5,5)




func _on_swingabl_timeout() -> void:
	
	hitbox.monitoring = false
	cooldown.start()


func _on_hitbox_area_entered(area: Area3D) -> void:
	
	if area.is_in_group("enemy"):
		print("player damaging")
		area.get_parent().damag(velocity.distance_to(Vector3.ZERO))
		area.get_parent().reverse(velocity)
		print(velocity.distance_to(Vector3.ZERO))
		var_health += velocity.distance_to(Vector3.ZERO)
		velocity*=-0.5

func take_damage(g:int):
	var_health -= g
