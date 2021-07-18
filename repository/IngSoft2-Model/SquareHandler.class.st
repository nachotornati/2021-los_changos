Class {
	#name : #SquareHandler,
	#superclass : #Object,
	#instVars : [
		'square',
		'reversed'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
SquareHandler class >> with: square [
	^self new initializeWith: square.
]

{ #category : #initialization }
SquareHandler >> initializeWith: aSquare [
	square:=aSquare.
	reversed:=false.
]

{ #category : #action }
SquareHandler >> reverse: aSquare [
	reversed:=true.
]

{ #category : #accesing }
SquareHandler >> reversed [
	^ reversed
]

{ #category : #accesing }
SquareHandler >> square [
	^ square
]
