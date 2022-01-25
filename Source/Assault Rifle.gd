extends Sprite

#Creates a firerate variable
var shoot_timer 

#When the game starts, asign a timer to the shoot_timer variable
func _ready():
	shoot_timer = get_tree().create_timer(0.0)

#Checks if the RayCast2D (A line that points out the muzzle of the gun) hits an enemy, if so, delete (kill) the enemy
func check_collision():
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("Enemy"):
			collider.queue_free() #Deletes the enemy

#Everytime the user left clicks, this function will run, the function will play a recoil animation and run the check_collision() function
func shoot():
	$AnimationPlayer.play("Recoil")
	check_collision()

#This function runs every frame
func _process(delta):
	
	#Rotates the gun to point to the mouse
	look_at(get_global_mouse_position())
	
	#This if statement forces the rotation degrees to stay inbetween 270 and -90 degrees, because Godot doesn't already do that
	if rotation_degrees > 270:
		rotation_degrees = -90
	elif rotation_degrees < -90:
		rotation_degrees = 270
	
	#This if statement flips the gun whenever it reaches a certain rotation degree, this is so the gun doesn't look upsidedown
	if rotation_degrees > 90:
		flip_v = true
	elif rotation_degrees < 90:
		flip_v = false
	
	#Whenever the user presses any control in the "Shoot" action, (the controls can be seen in the project settings) it resets the firerate and runs the shoot() function
	if Input.is_action_pressed("Shoot") and shoot_timer.time_left <= 0.0:
		shoot_timer = get_tree().create_timer(0.15)
		yield(shoot_timer, "timeout")
		shoot()

