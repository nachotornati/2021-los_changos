Class {
	#name : #Square,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
Square >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	self subclassResponsibility.
]

{ #category : #action }
Square >> makeReversedEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	self subclassResponsibility.
]
