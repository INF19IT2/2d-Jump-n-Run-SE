extends Sprite

const VELOCITY = Vector2(200, 0)

const maxLifeTime = 2
var lifeTime = 0


func _process(delta):
	move(delta)
	removeAfterTimeLimit()

func move(delta):
	global_position += VELOCITY * delta
	lifeTime += delta

func removeAfterTimeLimit():
	if lifeTime > maxLifeTime :
		queue_free()
