Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
SpeedUpSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	(aBoard isReversed: self)
	ifTrue:[aBoard move: aPlayer backwards:4 ]
	ifFalse:[aBoard move: aPlayer withoutEffectTo: 4].
	
]
