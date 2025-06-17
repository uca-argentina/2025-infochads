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
Board >> adjust: spaceShips positionAnd: totalLaps [

	spaceShips do: [ :ship |
		ship updatePosition:
			(self limitAdjustment: ship position withTotalLaps: totalLaps) ]
]

{ #category : 'accessing' }
Board >> boardSize [

	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForPowerUps: aSpaceShip andAllSpaceShips: allSpaceShips [

	| cell |
	gameBoard ifNotEmpty: [
		cell := gameBoard at: aSpaceShip getPosition.
		cell takeAction: aSpaceShip andOtherSpaceShips: allSpaceShips ].

]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aSpaceShip [

	aSpaceShip updatePosition:
		(wormHole moveifWormHole: aSpaceShip getPosition)
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
Board >> limitAdjustment: aPosition withTotalLaps: totalLaps [

	aPosition position <= 0 ifTrue: [
		aPosition toBeginningOfLap.
		^ aPosition ].

	(self the: aPosition position hasReached: totalLaps) ifTrue: [
		aPosition migrateToPosition: boardSize.
		aPosition migrateToLap: totalLaps.
		^ aPosition ].

	aPosition position <= boardSize ifTrue: [ ^ aPosition ].


	aPosition migrateToLap: aPosition position // boardSize.
	aPosition migrateToPosition: aPosition position \\ boardSize.

	^ aPosition
]

{ #category : 'as yet unclassified' }
Board >> the: aPosition hasReached: totalLaps [

	^ aPosition position + (aPosition lap * boardSize)
	  >= (totalLaps * boardSize)
]
