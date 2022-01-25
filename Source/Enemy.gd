extends KinematicBody2D

#Creates a run_speed variable with the speed of the enemy
export var run_speed = 25

#Creates a velocity variable
var velocity = Vector2.ZERO
var player = null #Creates the player variable, this will be used to track the player to chase them

#This runs every frame
func _physics_process(delta):
	velocity = Vector2.ZERO #Defines velocity
	
	#This checks if the player is in range
	if player:
		velocity = position.direction_to(player.global_position) * run_speed #If the player is in range, the enemy will run towards the player
	velocity = move_and_slide(velocity)

#If the user enters the line of sight of the enemy, the player variable will be defined as the user
func _on_Area2D_area_entered(area):
	player = area

#If the user exits the line of sight of the enemy, the player variable will be defined as null, so the enemy won't know where is player is
func _on_Area2D_area_exited(area):
	player = null
