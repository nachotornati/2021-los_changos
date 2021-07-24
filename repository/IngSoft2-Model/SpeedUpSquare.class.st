Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
SpeedUpSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [

	aBoard move: aPlayer forwardWithoutEffectTo: 4.
	
]

{ #category : #action }
SpeedUpSquare >> makeReversedEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	aBoard move: aPlayer backwards:4.
]
