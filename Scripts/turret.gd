#
#  This file is subject to the terms and conditions defined in
#  file 'LICENSE.txt', which is part of this source code package.
#  Copyright (c) 2017 Arknoid / Olivier Malige
#
extends "_enemy.gd"


func _ready():
	add_to_group("turret")
	._ready()
	shooting()

func shooting():
	var dir = 0
	var shot =[]
	var i = 0
	while (true):
		$sound_Shooting.playing = true
		shot.append(preload("res://Prefabs/turretShot.tscn").instance())
		shot[i].position = get_node("shootPos").global_position
		get_node("../").add_child(shot[i])
		dir = rand_range(-150,150)
		shot[i].speedX = dir
		get_node("ShotDelay").start()
		#get_node("../enemySfx").play("interceptorShot")
		i += 1
		yield(get_node("ShotDelay"),"timeout")
