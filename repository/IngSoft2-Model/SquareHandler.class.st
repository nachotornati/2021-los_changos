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

{ #category : #action }
SquareHandler >> removeEffectOf: aCard [ 
	affectCards := affectCards collect: [:card | (card class = ReversalCard) not]
]

{ #category : #action }
SquareHandler >> reverse: aSquare [
	affectCards add: ReversalCard new.
]

{ #category : #accesing }
SquareHandler >> reversed [
	^ affectCards anySatisfy: [:card | card class = ReversalCard ].
]

{ #category : #accesing }
SquareHandler >> square [
	^ square
]
