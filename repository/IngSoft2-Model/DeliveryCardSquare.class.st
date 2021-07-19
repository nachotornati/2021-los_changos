Class {
	#name : #DeliveryCardSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
DeliveryCardSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	aBoard giveCardFromDeckTo: aPlayer.
	
	
]

{ #category : #action }
DeliveryCardSquare >> makeReversedEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	aBoard removeCardFromDeckTo: aPlayer
]
