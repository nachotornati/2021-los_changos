Class {
	#name : #SquareHandler,
	#superclass : #Object,
	#instVars : [
		'square',
		'affectCards'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
SquareHandler class >> noCardMatchErrorMessage [
	^'hola'.
]

{ #category : #'instance creation' }
SquareHandler class >> with: square [
	^self new initializeWith: square.
]

{ #category : #accesing }
SquareHandler >> affectsSquare: aCard [
	^affectCards anySatisfy: [:card | card class = aCard class ].
]

{ #category : #initialization }
SquareHandler >> initializeWith: aSquare [
	affectCards:= OrderedCollection new.
	square:=aSquare.
]

{ #category : #actions }
SquareHandler >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	
	(self reversed)
	ifTrue:[square makeReversedEffectOn: aPlayer thatHasItsPositionIn: aBoard] 
	ifFalse:[square makeEffectOn: aPlayer thatHasItsPositionIn: aBoard].
]

{ #category : #action }
SquareHandler >> removeEffectOf: aCard [ 
	affectCards := affectCards select: [:card | (card class = aCard class)not]
]

{ #category : #action }
SquareHandler >> reverse: aSquare [
	affectCards add: ReversalCard new.
]

{ #category : #accesing }
SquareHandler >> reversed [
	^ affectCards anySatisfy: [:card | card class = ReversalCard ].
]

{ #category : #action }
SquareHandler >> square [
	^square.
]
