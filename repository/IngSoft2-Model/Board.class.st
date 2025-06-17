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
		ship storeageNewPosition:
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
Board >> checkForWormHole: aPosition [

	^ Position at: (wormHole moveifWormHole: aPosition position) withLaps: 0.
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
		^ Position at: aPosition position - 1 withLaps: 0 ].

	(self the: aPosition hasReached: totalLaps) ifTrue: [
		^ Position
			  at: boardSize - aPosition position
			  withLaps: totalLaps - aPosition lap ].

	aPosition position <= boardSize ifTrue: [
		^ Position at: 0 withLaps: 0 ].

	^ Position
		  at: boardSize * (aPosition position // boardSize) negated
		  withLaps: aPosition position // boardSize
]

{ #category : 'as yet unclassified' }
Board >> the: aPosition hasReached: totalLaps [

	^ aPosition position + (aPosition lap * boardSize)
	  >= (totalLaps * boardSize)
]
