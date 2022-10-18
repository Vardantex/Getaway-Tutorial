extends VehicleBody

const MAX_STEER_ANGLE = .35
const STEER_SPEED = .5

const MAX_ENGINE_FORCE = 110
const MAX_BRAKE_FORCE = 10

var steer_target = 0.0 #Where do I want the wheels to go
var steer_angle = 0.0 #Where are the wheels now

func _process(delta: float) -> void:
	drive(delta)
	engine_force = apply_throttle()
	brake = apply_brakes()

func _ready() -> void:
	pass

#Method to make car drive
func drive(delta):
	steering = apply_steering(delta)
	engine_force = apply_throttle()

#apply driving controls
func apply_steering(delta):
	var steer_val = 0
	var left = Input.get_action_strength("WASD_LEFT")
	var right = Input.get_action_strength("WASD_RIGHT")
	
	if left:
		steer_val = left
	elif right:
		steer_val = -right
	
	steer_target = steer_val * MAX_STEER_ANGLE
	
	if steer_target < steer_angle:
		steer_angle -= STEER_SPEED * delta
	elif steer_target > steer_angle:
		steer_angle += STEER_SPEED * delta 
	
	return steer_angle


#Create the function to move forward
func apply_throttle():
	var throttle_val = 0 
	var forward = Input.get_action_strength("WASD_FORWARD")
	var back = Input.get_action_strength("WASD_BACKWARD")
	
	if back:
		throttle_val = -back
	elif forward:
		throttle_val = forward 
		
	return throttle_val * MAX_ENGINE_FORCE

func apply_brakes():
	#brake is sef off by default
	var brake_val = 0 
	var brake_strength = Input.get_action_strength("BRAKE")
	
	#When user wants to brake, apply brake force
	if brake_strength:
		brake_val = brake_strength 
	
	#return user input wtih max brake force
	return brake_val * MAX_BRAKE_FORCE
	







