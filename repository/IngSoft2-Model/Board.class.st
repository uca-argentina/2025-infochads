Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'wormHole',
		'gameBoard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> assertIsPositiveOverZero: aBoardSize [

	(aBoardSize isInteger and: [ aBoardSize > 0 ]) ifFalse: [
		Error signal: 'Board Size must be a positive interger.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize composedOf: aWormHole andACellConfiguration: aConfigDiceSet [

	self assertIsPositiveOverZero: aBoardSize.
	^ self new
		  initializeWithSize: aBoardSize
		  composedOf: aWormHole
		  andConfiguration: aConfigDiceSet
]

{ #category : 'as yet unclassified' }
Board >> adjust: spaceShips positionAnd: laps [

	spaceShips do: [ :ship |
		self boardLimitAdjustment: ship withTotalLaps: laps.
		ship updatePosition ]
]

{ #category : 'as yet unclassified' }
Board >> boardLimitAdjustment: aSpaceShip withTotalLaps: totalLaps [

	aSpaceShip getTemporaryPosition <= 0 ifTrue: [
		aSpaceShip updateTemporaryPosition: 1 ].
	
	(self the: aSpaceShip hasReached: totalLaps) ifTrue: [
		aSpaceShip finishAt: boardSize withLaps: totalLaps.
		^ self ].

	(aSpaceShip getTemporaryPosition <= boardSize ) ifTrue: [ ^ self ].


	aSpaceShip updateLap: aSpaceShip getTemporaryPosition // boardSize.
	aSpaceShip updateTemporaryPosition:
		aSpaceShip getTemporaryPosition \\ boardSize
]

{ #category : 'accessing' }
Board >> boardSize [

	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForPowerUps: aSpaceShip andAllSpaceShips: allSpaceShips [

	| cell |
	gameBoard ifNotEmpty: [
		cell := gameBoard at: aSpaceShip getTemporaryPosition.
		cell takeAction: aSpaceShip andOtherSpaceShips: allSpaceShips ].

	self checkForWormHole: aSpaceShip
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aSpaceShip [

	aSpaceShip updateTemporaryPosition:
		(wormHole moveifWormHole: aSpaceShip getTemporaryPosition)
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize composedOf: aWormHole andConfiguration: aConfigDiceSet [

	boardSize := aBoardSize.

	gameBoard := CellPlacement new
		             createBoardWithCellConfiguration: aConfigDiceSet
		             andSize: boardSize.

	wormHole := aWormHole.
	wormHole mustBeWithInLimits: aBoardSize.

]

{ #category : 'as yet unclassified' }
Board >> the: aSpaceShip hasReached: totalLaps [

	^ aSpaceShip getTemporaryPosition + (aSpaceShip getLaps * boardSize)
	  >= (totalLaps * boardSize)
]
