Class {
	#name : #SprintSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SprintSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	| quantityOfSquaresToMove |
	quantityOfSquaresToMove:= board quantityOfCardsOf: aPlayer.
	board move: aPlayer forwardWithEffect: quantityOfSquaresToMove
]

{ #category : #action }
SprintSquare >> makeReversedEffectOn: aPlayer thatHasItsPositionIn: aBoard [
		| quantityOfSquaresToMove |
	quantityOfSquaresToMove:= aBoard quantityOfCardsOf: aPlayer.
	aBoard move: aPlayer backwards: quantityOfSquaresToMove
]
