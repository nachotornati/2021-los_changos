Class {
	#name : #DeliveryCardSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
DeliveryCardSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	(aBoard isReversed: self)
	ifTrue: [ aBoard removeCardFromDeckTo: aPlayer]
	ifFalse: [aBoard giveCardFromDeckTo: aPlayer.].
	
	
]
