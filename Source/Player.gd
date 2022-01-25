extends KinematicBody2D

export var speed = 75 #The speed of the player
export var friction = 1 #The friction the player will move at
export var acceleration = 0.25 #The acceleration the player will move at

var velocity = Vector2.ZERO #Creates the velocity variable

#This function runs every frame
func _physics_process(delta):
	var input_velocity = Vector2.ZERO #The input_velocity
	
	#These runs every time the move actions are called
	if Input.is_action_pressed("Move_Left"):
		input_velocity.x -= 1 #Moves the player
		$AnimatedSprite.flip_h = true #Flips the player texture
		$AnimatedSprite.play("Running") #Plays the "Running" animation
	elif Input.is_action_pressed("Move_Right"):
		input_velocity.x += 1 #Moves the player
		$AnimatedSprite.flip_h = false #Flips the player texture
		$AnimatedSprite.play("Running") #Plays the "Running" animation
	if Input.is_action_pressed("Move_Front"):
		input_velocity.y -= 1 #Moves the player
		$AnimatedSprite.play("Running") #Plays the "Running" animation
	elif Input.is_action_pressed("Move_Back"):
		input_velocity.y += 1 #Moves the player
		$AnimatedSprite.play("Running") #Plays the "Running" animation
	
	#If all of the move actions are released, play the "Idle" animation
	if Input.is_action_just_released("Move_Back") or Input.is_action_just_released("Move_Front") or Input.is_action_just_released("Move_Left") or Input.is_action_just_released("Move_Right"):
		$AnimatedSprite.play("Idle")
	
	velocity = move_and_slide(velocity)
	
	input_velocity = input_velocity.normalized() * speed
	
	if input_velocity.length() > 0:
		 velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)

#If the players hitbox touches the enemy, the player dies
func _on_PlayerHitbox_body_entered(body):
	queue_free()
