extends CharacterBody3D
class_name Player

@onready var ui: CanvasLayer = $UI
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $UI/VBoxContainer/Label
@onready var rotpiv: Node3D = $rotpiv
@onready var rotspd = 15

@onready var camera_3d: Camera3D = $Camera3D
@onready var timer_1: Timer = $Timer1
@onready var timer_2: Timer = $Timer2
@onready var swingabl: Timer = $swingabl
@onready var dashing: Timer = $dashing

var camerabase
var last := Vector3.BACK


const SPEED = 15.0
const accel = SPEED * 20.0/8.0
const JUMP_VELOCITY = 4.5


var sword = true
var gun = false

signal byebye

var var_health : int :
	set(new_health):
		var_health = new_health
		label.text = "Health: " + str(var_health)
		if var_health <1:
			byebye.emit()
			Engine.time_scale = 0.0




func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	
	if camerabase != null:
		camera_3d.global_position = camerabase
	camera_3d.look_at(global_position)
	
	
	
	
	
	
	
	
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	##if Input.is_anything_pressed() == false:
		##velocity= velocity.clampf(-7.5,7.5)
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	var forward := camera_3d.global_basis.z
	var right := camera_3d.global_basis.x
	
	var movedir := forward * input_dir.y + right * input_dir.x
	movedir.y = 0.0
	movedir = movedir.normalized()
	
	velocity = velocity.move_toward(movedir * SPEED, accel*delta )
	if Input.is_action_just_pressed("dash") && dashing.is_stopped():
		
		velocity = velocity.move_toward(last * SPEED * 2, accel)
		dashing.start()
	
	
	
	if movedir.length() > 0.2:
		last = movedir
	var target = Vector3.BACK.signed_angle_to(last,Vector3.UP)
	rotpiv.global_rotation.y = lerp_angle(rotpiv.rotation.y, target, rotspd * delta)
	
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if sword:
		if Input.is_action_just_pressed("attack") && swingabl.is_stopped():
			if timer_2.is_stopped() == false:
				animation_player.play("chopodoom")
				timer_2.stop()
			
			elif timer_1.is_stopped() == false:
				animation_player.play("swingbase2")
				timer_2.start()
				timer_1.stop()
			
			else:
				timer_1.start()
				animation_player.play("swingbase")
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
