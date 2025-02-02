Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'player',
		'cardsInHand',
		'cardsThatAffect'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
CardHandler class >> with: aPlayer [ 
	^ self new initializeWith: aPlayer
]

{ #category : #action }
CardHandler >> addEffectOf: aCard [ 
	cardsThatAffect add: aCard.
]

{ #category : #action }
CardHandler >> addToHand: aCard [ 
	cardsInHand add: aCard.
]

{ #category : #boolean }
CardHandler >> affectsPlayer: aCard [
	^ cardsThatAffect includes: aCard.
]

{ #category : #accessing }
CardHandler >> cardsInHand [
	^ cardsInHand copy.
]

{ #category : #boolean }
CardHandler >> hasInHand: aCard [ 
	^ cardsInHand includes: aCard
]

{ #category : #initialization }
CardHandler >> initializeWith: aPlayer [ 
	player := aPlayer.
	cardsInHand := OrderedCollection new.
	cardsThatAffect := OrderedCollection new.
]

{ #category : #accessing }
CardHandler >> player [
	^ player copy
]

{ #category : #accessing }
CardHandler >> quantityOfCardsInHand [
	^ cardsInHand size
]

{ #category : #action }
CardHandler >> removeACardFromHand [
	cardsInHand isEmpty
	ifFalse:[cardsInHand removeFirst].
]

{ #category : #action }
CardHandler >> removeEffectOf: aCard [
	cardsThatAffect := cardsThatAffect select: [:card | (card class = aCard class)not].
]

{ #category : #action }
CardHandler >> removeFromHand: aCard [
	cardsInHand remove:aCard.
]

{ #category : #action }
CardHandler >> totalEffectsOnPlayer [
	cardsThatAffect isEmpty ifTrue:[^0].
	^cardsThatAffect sum:[:card| card effect ].
]
