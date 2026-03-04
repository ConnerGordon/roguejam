extends Node

static var room := 0




@export var health_curve : Curve
@export var num_curve: Curve


func roomrate()->float:
	
	return 1-room/50.0

func get_health()-> float:
	return health_curve.sample(roomrate())
	
func get_count()->float:
	return num_curve.sample(roomrate())

func inc():
	room+=1
