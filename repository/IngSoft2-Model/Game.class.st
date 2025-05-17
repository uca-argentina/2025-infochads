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
Game >> positionOfSpaceShip: aSpaceShipID [

	^ spaceShips positions at: aSpaceShipID
]

{ #category : 'as yet unclassified' }
Game >> spaceShip: aSpaceShipID hasRolled: diceRoll [

	| posibleNextPosition realNextPosition |
	posibleNextPosition := spaceShips
		                       withID: aSpaceShipID
		                       wouldMoveForward: diceRoll.

	realNextPosition := aBoard spaceShipWillMoveTo: posibleNextPosition.

	spaceShips move: aSpaceShipID toPosition: realNextPosition
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll |
	diceRoll := diceSet toss.
	[ (self isGameOver) or: (diceRoll = 0)] whileFalse: [
		self spaceShip: nextSpaceShipToMove hasRolled: diceRoll.
		self updateNextShipToMove: nextSpaceShipToMove.
		diceRoll := diceSet toss ]
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
