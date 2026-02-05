extends Node

@onready var weapon := 0

var upkeeps := 0


signal finalroom()
signal stillroom()
# sword upgrades

var judgement = false
var runthrough = false
var godwilled = false
var weakestlink = false
var falsebravado = false
var frenzy = false
var speedster = false

# gun upgrades

var coinman = false
var speedshot = false
var highvalue = false
var piercer = false
var nimblefingers= false
var dueler = false
var highcapacity = false


func gainUp(upName:String)-> void:
	#sword upgrades
	if weapon == 0:
		if upName == "judgement":
			judgement = true
		if upName == "runthrough":
			runthrough = true
		if upName == "godwilled":
			godwilled = true
		if upName == "weakestlink":
			weakestlink = true
		if upName == "falsebravado":
			falsebravado = true
		if upName == "frenzy":
			frenzy = true
		if upName == "speedster":
			speedster = true
		upkeeps+=1
	
	
	# gun upgrades
	
	elif weapon == 1:
		if upName == "coinman":
			coinman = true
		if upName == "speedshot":
			speedshot = true
		if upName == "highvalue":
			highvalue = true
		if upName == "piercer":
			piercer = true
		if upName == "nimblefingers":
			falsebravado = true
		if upName == "dueler":
			frenzy = true
		if upName == "highcapacity":
			speedster = true
		upkeeps+=1
	
	else:
		print("bad weapon upgrade: did you pass in the right phrase for the right weapon?")
	
	checkRunRoom()


func checkRunRoom()->void:
	if upkeeps > 3:
		finalroom.emit()
	else:
		stillroom.emit()
		
