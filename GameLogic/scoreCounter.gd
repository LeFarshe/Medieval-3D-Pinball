extends Node

var score = 0

enum Components {BUMPER, ROLLOVER, TARGET, KICKER, DROP_TARGET}
const defaultScore = {Components.BUMPER: 200, Components.ROLLOVER: 15, Components.TARGET: 50,
Components.KICKER: 150, Components.DROP_TARGET: 100}

func addScore(type: Components):
	match type:
		Components.BUMPER:
			score += defaultScore[Components.BUMPER]
		Components.ROLLOVER:
			score += defaultScore[Components.ROLLOVER]
		Components.TARGET:
			score += defaultScore[Components.TARGET]
		Components.KICKER:
			score += defaultScore[Components.KICKER]
		Components.DROP_TARGET:
			score += defaultScore[Components.DROP_TARGET]
