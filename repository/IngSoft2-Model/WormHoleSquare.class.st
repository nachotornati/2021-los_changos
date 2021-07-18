Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
WormHoleSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	(board isReversed: self)
	ifTrue: [ board move: aPlayer withoutEffectTo: 4.]
	ifFalse: [board move: aPlayer backwards: 4.]
]
