Class {
	#name : #ReversalCard,
	#superclass : #Card,
	#category : #'IngSoft2-Tests'
}

{ #category : #action }
ReversalCard >> applyTo: aNumberOfSquare in: aGame from: aPlayer [
		aGame validateThrowOfAPermanent: self  from: aPlayer.
		aGame reverseSquareNumber: aNumberOfSquare.
]
