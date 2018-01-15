extends Area2D
const SPEED = 100  
const BONUS_SPEED_PLAYER = 5       #speedUp
const BONUS_SHOT_POWER = 0.25      #damage
const BONUS_SIDE_SHOT_POWER = 0.20 #damage
const BONUS_SHOOTING_SPEED = 0.006 #Seconde

func _ready():
	var rndPowers = randi()%100 +1
#	var rndPowers =6   #debug
	set_process(true)
	add_to_group("powersUp")
	if (rndPowers <= 100):
		get_node("anim").play("speedUp")
	if (rndPowers <= 50):
		get_node("anim").play("laserUp")
	if (rndPowers <= 25 ):
		get_node("anim").play("lateralShot")
	if (rndPowers <= 10):
		get_node("anim").play("shieldUp")
	if (rndPowers <= 2):
		get_node("anim").play("energieUp")

func _process(delta):
	translate(Vector2(0,SPEED)*delta)

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()

func _on_powerUp_area_enter( area ):
	if (area.is_in_group("player")):
		if (get_node("anim").get_current_animation() == "speedUp"):
			area.bonusSpeed += BONUS_SPEED_PLAYER
			area.shoot_Delay -= BONUS_SHOOTING_SPEED
			area.setShootingDelay()
			$speed_Up.playing = true
		elif (get_node("anim").get_current_animation() == "energieUp"):
			area.energy += 1
			area.update_energy()
			$energy_Up.playing = true
		elif (get_node("anim").get_current_animation() == "lateralShot"):
			area.shotSide = true
			area.bonusPowerSideShot += BONUS_SIDE_SHOT_POWER
			$lateral_Shot.playing = true
		elif (get_node("anim").get_current_animation() == "laserUp"):
			area.shotPowerBonus += BONUS_SHOT_POWER
			$shot_Up.playing = true
		elif (get_node("anim").get_current_animation() == "shieldUp"):
			area.get_node("shield").power = 1    #+1 to  getset function

		$anim.queue_free()
		$Sprite.queue_free()
		$CollisionShape2D.queue_free()


func _on_audio_finished():
	queue_free()


