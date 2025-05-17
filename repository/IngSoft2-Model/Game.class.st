Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'aBoard',
		'spaceShips',
		'diceSet',
		'nextSpaceShipToMove',
		'numberOfSpaceShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> withBoardSize: aBoardSize withSpaceShips: aNumberOfSpaceShips withDiceSet: aDiceSet withWormHole: aWormHolePosition [

	^ self new
		  initializeWithBoardSize: aBoardSize
		  AndNumberOfSpaceShips: aNumberOfSpaceShips
		  AndDiceSet: aDiceSet
		  AndWormHole: aWormHolePosition
]

{ #category : 'as yet unclassified' }
Game >> checkForWinner [

	self isGameOver ifTrue: [
		Error signal:
			'Space ship ' , (spaceShips getWinner: aBoard boardSize) asString , ' has already won.' ]
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoardSize AndNumberOfSpaceShips: aNumberOfSpaceShips AndDiceSet: aDiceSet AndWormHole: aWormHolePosition [

	aBoard := Board withSize: aBoardSize andWormHolePosition: aWormHolePosition .
	spaceShips := RacePosition withPieces: aNumberOfSpaceShips.
	diceSet := aDiceSet.
	nextSpaceShipToMove := 1.
	numberOfSpaceShips := aNumberOfSpaceShips.
	^ self
]

{ #category : 'testing' }
Game >> isGameOver [

	^ spaceShips isAtFinishLine: aBoard boardSize
]

{ #category : 'testing' }
Game >> isOver [
	^ self isGameOver 
]

{ #category : 'as yet unclassified' }
Game >> moveSpaceShip: aSpaceShipID numberOfPositions: positionsToSum [

	| posibleNextPosition realNextPosition |
	posibleNextPosition := spaceShips
		                       withID: aSpaceShipID
		                       wouldMoveForward: positionsToSum.
	realNextPosition := aBoard spaceShipWillMoveTo: posibleNextPosition.

	spaceShips move: aSpaceShipID toPosition: realNextPosition
]

{ #category : 'as yet unclassified' }
Game >> positionOfSpaceShip: aSpaceShipID [

	^ spaceShips positions at: aSpaceShipID
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll |
	diceRoll := diceSet toss.
	[ (self isGameOver) or: (diceRoll = 0)] whileFalse: [
		self moveSpaceShip: nextSpaceShipToMove numberOfPositions: diceRoll.
		self updateNextShipToMove: nextSpaceShipToMove.
		diceRoll := diceSet toss ]
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
