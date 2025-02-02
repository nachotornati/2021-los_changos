Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'laps',
		'players',
		'positions',
		'squares',
		'cardHandlers',
		'deck',
		'lastCardPlayed',
		'lastSquarePlayed',
		'squareHandlers'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Board class >> errorMessageOutOfBound [
	^'The number of square cannot be greater than the board size'
]

{ #category : #'instance creation' }
Board class >> notValidNumberOfLapsErrorMessage [
	^ 'Number of laps must be greater than 0'
]

{ #category : #'instance creation' }
Board class >> notValidNumberOfPlayersErrorMessage [
	^ 'There must be 2 or more players'
]

{ #category : #'instance creation' }
Board class >> notValidNumberOfSquaresErrorMessage [
	^ 'Size must be greater than 4'
]

{ #category : #'instance creation' }
Board class >> playedBy: players with: squares andCardsFrom: deck finishingAfter: laps [
	self validate: players withNumberOf: laps  andWith: squares. 
	^self new initializePlayedBy: players withNumberOf: laps with: squares andCardsFrom: deck.
]

{ #category : #'instance creation' }
Board class >> validate: players withNumberOf: laps andWith: squares [
	self validatePlayers: players.
	self validateLaps: laps.
	self validateSquares: squares
]

{ #category : #'instance creation' }
Board class >> validateLaps: laps [
	laps < 1
		ifTrue: [ self error: self notValidNumberOfLapsErrorMessage ]
]

{ #category : #'instance creation' }
Board class >> validatePlayers: players [
	players size <= 1
		ifTrue: [ self error: self notValidNumberOfPlayersErrorMessage ]
]

{ #category : #'instance creation' }
Board class >> validateSquares: squares [
	squares size <= 4
		ifTrue: [ self error: self notValidNumberOfSquaresErrorMessage ]
]

{ #category : #action }
Board >> addEffectOf: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) addEffectOf: aCard.
	lastCardPlayed:= aCard.
]

{ #category : #action }
Board >> addInHand: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) addToHand: aCard.
]

{ #category : #action }
Board >> addToAllEffectOf: aCard [ 
	players do:[:player | self addEffectOf: aCard to:player].
	
]

{ #category : #action }
Board >> applyEffectOfTheLastPlayedSquareTo: aPlayer from: aCard [
	(self squareHandleOf: lastSquarePlayed) makeEffectOn: aPlayer thatHasItsPositionIn: self.
	lastCardPlayed:= aCard.
]

{ #category : #boolean }
Board >> cardHandlerOf: aPlayer [
	^ cardHandlers detect: [ :handler | handler player = aPlayer ].
]

{ #category : #initialization }
Board >> distributeCardsFrom: aDeck [
	cardHandlers
		do: [ :cardHandler | 
			cardHandler addToHand: aDeck pick.
			cardHandler addToHand: aDeck pick ]
]

{ #category : #accessing }
Board >> finished: aPlayer [
	| playerPosition squaresAdvanced |
	playerPosition := self positionOf: aPlayer.
	squaresAdvanced := self numberOfSquaresAdvancedOf: playerPosition.
	^ squaresAdvanced = self limit
]

{ #category : #action }
Board >> giveCardFromDeckTo: aPlayer [ 
	(self cardHandlerOf: aPlayer) addToHand: (deck pick).
	
]

{ #category : #boolean }
Board >> has: aPlayer the: aCard [
	| playerCardHandler |
	playerCardHandler := self cardHandlerOf: aPlayer.
	^ playerCardHandler hasInHand: aCard
]

{ #category : #initialization }
Board >> initializePlayedBy: aGroupOfPlayers withNumberOf: numberOfLaps with: aGroupOfSquares andCardsFrom: aDeck [
	positions := aGroupOfPlayers
		collect: [ :player | Position of: player at: 1 after: 0 ].
	cardHandlers := aGroupOfPlayers
		collect: [ :player | CardHandler with: player ].
	
	self distributeCardsFrom: aDeck.
		squareHandlers:= aGroupOfSquares
		collect: [ :square | SquareHandler with: square ].

	squares := aGroupOfSquares.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
	deck := aDeck.
	lastCardPlayed := nil.
	lastSquarePlayed := EffectlessSquare new.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 
	^ (self positionOf: aPlayer) lap.
]

{ #category : #accessing }
Board >> lastCardPlayed [
	^lastCardPlayed.
]

{ #category : #accessing }
Board >> limit [
	^(laps * (squares size)) + 1
]

{ #category : #action }
Board >> move: aPlayer backwards: numberOfSquares [

	| aPosition newPosition |
	aPosition := self positionOf: aPlayer.
	newPosition := self newPosition: (numberOfSquares negated) from: aPosition. 
	positions remove: aPosition.
	positions add: newPosition.
]

{ #category : #action }
Board >> move: aPlayer forwardWithEffect: squaresToMove [
	| currentSquare newPosition |
	newPosition := self move: aPlayer forwardWithoutEffectTo: squaresToMove.
	currentSquare := squares at: newPosition numberOfSquare.
	lastSquarePlayed := currentSquare.
	
	(self squareHandleOf: currentSquare) makeEffectOn: aPlayer thatHasItsPositionIn: self.
	"currentSquare makeEffectOn: aPlayer thatHasItsPositionIn: self"
]

{ #category : #action }
Board >> move: aPlayer forwardWithoutEffectTo: squaresToMove [
	| oldPosition newPosition |
	oldPosition := self positionOf: aPlayer.
	positions remove: oldPosition.
	newPosition := self newPosition: squaresToMove from: oldPosition.
	positions add: newPosition.
	^ newPosition
]

{ #category : #action }
Board >> moveAllPlayersBackards: numberOfSquaresToMoveBackwards except: aPlayer [ 
	| playersToMove |
	playersToMove:= self players.
	playersToMove remove: aPlayer.
	playersToMove do:[:player| self move: player backwards: numberOfSquaresToMoveBackwards ].
]

{ #category : #action }
Board >> moveAllPlayersForward: numberOfSquaresToMove except: aPlayer [
	| playersToMove |
	playersToMove:= self players.
	playersToMove remove: aPlayer.
	playersToMove do:[:player| self move: player forwardWithoutEffectTo: numberOfSquaresToMove.].
]

{ #category : #action }
Board >> newPosition: numberOfSquaresToAdvance from: aPosition [
	| newLap newNumberOfSquare quantityOfSquaresAdvanced |
	quantityOfSquaresAdvanced := (self
		numberOfSquaresAdvancedOf: aPosition) + numberOfSquaresToAdvance
		min: self limit
		max: 1.
	newLap := (quantityOfSquaresAdvanced - 1) // self size.
	newNumberOfSquare := quantityOfSquaresAdvanced % self size.
	newNumberOfSquare = 0
		ifTrue: [ newNumberOfSquare := self size ].
	^ Position of: aPosition player at: newNumberOfSquare after: newLap
]

{ #category : #accessing }
Board >> numberOfSquaresAdvancedOf: aPosition [
	^ aPosition lap * squares size + aPosition numberOfSquare
]

{ #category : #accessing }
Board >> players [
	^ players copy.
]

{ #category : #accessing }
Board >> positionOf: aPlayer [ 
	^ positions detect: [ :aPosition | aPosition player = aPlayer  ]
]

{ #category : #accessing }
Board >> quantityOfCardsOf: aPlayer [
	| cardHandler |
	cardHandler:= self cardHandlerOf: aPlayer.
	^(cardHandler cardsInHand) size.
	
]

{ #category : #action }
Board >> removeAnyCardFromHandTo: aPlayer [
	
	(self cardHandlerOf: aPlayer) removeACardFromHand. 
]

{ #category : #action }
Board >> removeFromHand: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) removeFromHand: aCard.
]

{ #category : #action }
Board >> removeToAllPlayersPermanent: card [
	| handlersWithCardToBeRemoved |
	handlersWithCardToBeRemoved := cardHandlers
		select: [ :cardHandler | cardHandler affectsPlayer: card ].
		
		
	handlersWithCardToBeRemoved
		do: [ :cardHandler | cardHandler removeEffectOf: card ].
		lastCardPlayed := CancellationCard  new.
]

{ #category : #action }
Board >> removeToAllSquares: card [
	|handlersWithCardToBeRemoved |
	handlersWithCardToBeRemoved := squareHandlers
		select: [ :squareHandler | squareHandler affectsSquare: card ].
	handlersWithCardToBeRemoved
		do: [ :squareHandler | squareHandler removeEffectOf: card ].
		lastCardPlayed := CancellationCard  new.
]

{ #category : #action }
Board >> restartPositionOfAllPlayers [
	positions := players
		collect:
			[ :player | Position of: player at: 1 after: (self lapOf: player) ]
]

{ #category : #action }
Board >> reverseSquareNumber: aNumberOfSquare [
	| square squareHandler |
	square:= squares at:aNumberOfSquare ifAbsent:[self error: (self class errorMessageOutOfBound)] .
	squareHandler:= self squareHandleOf: square.
	squareHandler reverse: square.
	lastCardPlayed:= ReversalCard new.
]

{ #category : #accessing }
Board >> size [
	^ squares size
]

{ #category : #accessing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]

{ #category : #accessing }
Board >> squareHandleOf: aSquare [
	^ squareHandlers detect: [ :handler | handler square = aSquare ].
]
