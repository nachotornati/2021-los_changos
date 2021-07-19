Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
WormHoleSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	board move: aPlayer backwards: 4.
]

{ #category : #action }
WormHoleSquare >> makeReversedEffectOn: aPlayer thatHasItsPositionIn: board [
	board move: aPlayer withoutEffectTo: 4.
]
