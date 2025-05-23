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
Game >> lookForBattle [

	| aDiceRoll aDiceRoll2 shipsPositions encounteredShips ship1 ship2 shipsNotInStart |
	shipsPositions := spaceShips positions.
	shipsNotInStart := shipsPositions select: [ :pos | pos ~= 0 ].

	encounteredShips := (1 to: shipsPositions size) select: [ :i |
		                    (shipsPositions at: i) ~= 0 and: [
			                    (shipsNotInStart occurrencesOf:
				                     (shipsPositions at: i)) > 1 ] ].

	encounteredShips size ~= 2 ifTrue: [ ^ self ].

	aDiceRoll := diceSet toss.
	aDiceRoll2 := diceSet toss.

	ship1 := encounteredShips at: 1.
	ship2 := encounteredShips at: 2.

	aDiceRoll > aDiceRoll2
		ifTrue: [ spaceShips move: ship2 toPosition: 0 ]
		ifFalse: [ spaceShips move: ship1 toPosition: 0 ]
]

{ #category : 'as yet unclassified' }
Game >> positionOfSpaceShip: aSpaceShipID [

	^ (spaceShips positions at: aSpaceShipID) getPosition.
]

{ #category : 'as yet unclassified' }
Game >> spaceShip: aSpaceShipID hasRolled: diceRoll [

	"| posibleNextPosition realNextPosition |" 
	|spaceShip |
	"posibleNextPosition := spaceShips
		                       withID: aSpaceShipID
		                       wouldMoveForward: diceRoll."
		
	spaceShip := spaceShips withID: aSpaceShipID moveToTemporaryPosition: diceRoll.

	"realNextPosition := aBoard spaceShipWillMoveTo: posibleNextPosition."
	spaceShip updatePosition: (aBoard adjustPositionOf: (spaceShip getTemporaryPosition)).

	"spaceShips move: aSpaceShipID toPosition: realNextPosition"
]

{ #category : 'accessing' }
Game >> start [

	| diceRoll |
	diceRoll := diceSet toss.
	[ self isGameOver or: diceRoll = 0 ] whileFalse: [
		self spaceShip: nextSpaceShipToMove hasRolled: diceRoll.
		self updateNextShipToMove: nextSpaceShipToMove.
		self lookForBattle.
		diceRoll := diceSet toss ]
]

{ #category : 'as yet unclassified' }
Game >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > numberOfSpaceShips ifTrue: [
		nextSpaceShipToMove := 1 ]
]
