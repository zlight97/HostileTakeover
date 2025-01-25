extends Area2D
class_name EnemyHurtbox

signal apply_damage

func hurt(damage, knockback):
	apply_damage.emit(damage,knockback)
