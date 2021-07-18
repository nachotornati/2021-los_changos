Class {
	#name : #MoonWalkSquare,
	#superclass : #Square,
	#instVars : [
		'numberOfSquaresToMoveBackwards'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
MoonWalkSquare class >> with: numberOfSquaresToMoveBackwards [ 
	^ self new initializeWith: numberOfSquaresToMoveBackwards.
]

{ #category : #initalize }
MoonWalkSquare >> initializeWith: aNumberOfSquaresToMoveBackwards [ 
	numberOfSquaresToMoveBackwards:= aNumberOfSquaresToMoveBackwards.
]

{ #category : #action }
MoonWalkSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	(aBoard isReversed: self)
	ifTrue: [ aBoard moveAllPlayersForward: numberOfSquaresToMoveBackwards except: aPlayer.]
	ifFalse: [aBoard moveAllPlayersBackards: numberOfSquaresToMoveBackwards except: aPlayer.]
]
