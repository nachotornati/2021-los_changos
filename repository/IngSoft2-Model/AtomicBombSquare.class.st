Class {
	#name : #AtomicBombSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
AtomicBombSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	aBoard restartPositionOfAllPlayers.
]

{ #category : #action }
AtomicBombSquare >> makeReversedEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	self makeEffectOn: aPlayer thatHasItsPositionIn: aBoard
]
