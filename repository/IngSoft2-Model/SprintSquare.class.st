Class {
	#name : #SprintSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SprintSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	| quantityOfSquaresToMove |
	quantityOfSquaresToMove:= board quantityOfCardsOf: aPlayer.
	(board isReversed: self)
	ifTrue: [board move: aPlayer backwards: quantityOfSquaresToMove ]
	ifFalse: [board move: aPlayer forward: quantityOfSquaresToMove].
]
