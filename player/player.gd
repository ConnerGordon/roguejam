extends CharacterBody3D
class_name Player

@onready var ui: CanvasLayer = $UI
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $UI/VBoxContainer/Label
@onready var rotpiv: Node3D = $rotpiv
@onready var rotspd = 15

@onready var camera_3d: Camera3D = $Camera3D



@onready var swingabl: Timer = $swingabl
@onready var dashing: Timer = $dashing

@onready var hitbox: Area3D = $hitbox
@onready var cooldown: Timer = $cooldown



@export var spincurve : Curve

var camerabase
var last := Vector3.BACK


@onready var starthp = 10000.0

const SPEED = 15.0
const accel = SPEED * 20.0/8.0
const JUMP_VELOCITY = 4.5


var sword = true
var gun = false

signal byebye

var var_health : float :
	set(new_health):
		var_health = new_health
		label.text = "velocity: " + str(int(var_health))
		if var_health <1:
			byebye.emit()
			Engine.time_scale = 0.0



func _ready() -> void:
	var_health = starthp
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	
	
	if camerabase != null:
		camera_3d.global_position = camerabase
	camera_3d.look_at(global_position)
	
	
	
	
	
	
	
	
	
	var_health -= delta * 50
	if not is_on_floor():
		velocity.y += -9.8 * delta
		

	##if Input.is_anything_pressed() == false:
		##velocity= velocity.clampf(-7.5,7.5)
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	var forward := camera_3d.global_basis.z
	var right := camera_3d.global_basis.x
	
	var movedir := forward * input_dir.y + right * input_dir.x
	movedir.y = 0.0
	movedir = movedir.normalized()
	
	velocity = velocity.move_toward(movedir * SPEED * var_health/1000, accel*delta )
	if Input.is_action_just_pressed("dash") && dashing.is_stopped():
		var_health -= 100
		velocity = velocity.move_toward(last * SPEED * 2, accel)
		dashing.start()
	
	
	if movedir.length() > 0.2:
		last = movedir
	
	rotpiv.rotation_degrees +=Vector3(0, spincurve.sample(var_health/starthp),0)
	
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if sword:
		if Input.is_action_just_pressed("attack") && swingabl.is_stopped()&& cooldown.is_stopped():
			hitbox.monitoring = true
			swingabl.start()
			
			
			
			
			
		
			
	
	
	
			
	move_and_slide()
	
	
	
	
	
	
	
	
	
func _on_dashing_timeout() -> void:
	velocity.clampf(-5,5)



##
##
##
##
##
##
##							UI SECTION
##
##
##
##
##
##
##
##
##


func _on_swingabl_timeout() -> void:
	hitbox.monitoring = false
	cooldown.start()


func _on_hitbox_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy"):
		area.damag()
		var_health += 200
