extends CharacterBody3D


const SPEED = 10.0

@onready var detec: Area3D = $detec

enum State{ IDLE, WAITMOVE,MOVE, PLAYERTARG, PLAYERREACH}
var state : State = State.IDLE

var idle_wait: float = 1.5 # default wait time
var idle_timer: float = 0 # internal countdown timer
var found := false
@onready var movetimer: Timer = $movetimer

@onready var soundy: AudioStreamPlayer3D = $soundy



@onready var lungin: Timer = $lungin

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var lungecd: Timer = $lungecd



var playpos
var lung = false



@export var damage : int = 10
@export var health : int = 1
@onready var lunge: Area3D = $lunge

var var_health : float :
	set(new_health):
		var_health = new_health
		if var_health <= 0:
			roomtracker.score += health*1.5
			queue_free()


func _ready() -> void:
	var_health = health*20
	print(var_health)
	

func damag(taken:int)->void:
	soundy.play()
	var_health -= taken







func _physics_process(delta: float) -> void:
	if get_tree().get_first_node_in_group("Player") != null:
		playpos = get_tree().get_first_node_in_group("Player").global_position
	
	rotation_degrees += Vector3(0,20,0)
	
	velocity.y = 0
	match state:
		State.IDLE:
			
			on_idle()
		State.WAITMOVE:
			
			on_wait(delta)
		State.MOVE:
			
			on_move()
		State.PLAYERTARG:
			on_targ()
			
		State.PLAYERREACH:
			p_reach()
			
			
	move_and_slide()
	


func on_idle():
	velocity.clampf(-4,4)
	idle_timer = idle_wait
	state= State.WAITMOVE
	
func on_wait(delta: float):
	idle_timer -= delta
	
	if idle_timer <= 0:
		var target = get_new_target()
		var nav_map = navigation_agent_3d.get_navigation_map()
		var safe = NavigationServer3D.map_get_closest_point(nav_map,target)
		navigation_agent_3d.target_position = safe
		if found:
			state = State.PLAYERTARG
		else:
			state = State.MOVE


func get_new_target():
	if found:
		return playpos
	else:
		var off_x = randf_range(-15,15)
		var off_z = randf_range(-15,15)
		
		
		return global_transform.origin + Vector3(off_x,0,off_z)



func on_move():
	var current_pos = global_transform.origin
	var next_position = navigation_agent_3d.get_next_path_position()
	var direc = (next_position - current_pos).normalized()
	velocity = direc * SPEED



func on_targ():
	var target = get_new_target()
	var nav_map = navigation_agent_3d.get_navigation_map()
	var safe = NavigationServer3D.map_get_closest_point(nav_map,target)
	navigation_agent_3d.target_position = safe
	var current_pos = global_transform.origin
	var next_position = navigation_agent_3d.get_next_path_position()
	var direc = (next_position - current_pos).normalized()
	
	
	velocity = direc * SPEED
	
	
func p_reach():
	if movetimer.is_stopped():
		
		
		velocity = Vector3.ZERO
		lungin.start(.75)
		lungecd.start(1.5)
		movetimer.start(2.5)
	
	
	
	
func _on_navigation_agent_3d_target_reached() -> void:
	if found:
		state = State.PLAYERREACH
	else:
		state = State.IDLE


func _on_detec_area_entered(area: Area3D) -> void:
	
	if area.get_parent().is_in_group("Player") && found != true:
		
		found = true
		state = State.WAITMOVE
		idle_timer = 0
		navigation_agent_3d.target_desired_distance = 15

	










func reverse(speed:Vector3):
	
	idle_timer = 1.5
	state= State.WAITMOVE
	if speed.abs().distance_to(Vector3.ZERO) == 0:
		var current_pos = global_transform.origin
		var next_position = playpos
		var direc = (next_position - current_pos).normalized()
		speed = -direc
	while speed.abs().distance_to(Vector3.ZERO)< 5:
		speed*=1.1
	velocity = speed
	lungin.stop()
	lungecd.stop()
	movetimer.stop()
	















func _on_lungin_timeout() -> void:
	
	if lung == false:
		
		var current_pos = global_transform.origin
		var next_position = playpos
		var direc = (next_position - current_pos).normalized()
		velocity = direc * SPEED * 4
		lunge.monitoring = true
		lung = true


func _on_lungecd_timeout() -> void:
	
	velocity = velocity.clampf(-6,6)
	lunge.monitoring= false
	

func _on_movetimer_timeout() -> void:
	
	lung = false
	state = State.PLAYERTARG
	
	
func _on_lunge_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Player"):
		soundy.play()
		area.get_parent().take_damage(damage)
		velocity*=-0.5
		
		lungecd.stop()
		lungin.stop()
		movetimer.start(0.5)
		
