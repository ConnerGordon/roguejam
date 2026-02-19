extends CharacterBody3D
class_name Player


@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var camera_3d: Camera3D = $Camera3D

var camerabase

const SPEED = 20.0
const JUMP_VELOCITY = 4.5

var sword = true
var gun = false




func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	
	#if camerabase != null:
		#camera_3d.global_position = camerabase
	#camera_3d.look_at(global_position)
	
	
	
	
	
	
	
	
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	
		
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (camera_3d.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if sword:
		if Input.is_action_just_pressed("attack"):
			animation_player.play("swingbase")
			
	
	
	
			
	move_and_slide()
	
