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
Board class >> boardSizeMustBePositiveOverZero: aBoardSize [

	(aBoardSize isInteger and: [ aBoardSize > 0 ]) ifFalse: [
		Error signal: 'Board Size must be a positive interger.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize composedOf: aWormHole andACellConfiguration: aConfigDiceSet [

	self boardSizeMustBePositiveOverZero: aBoardSize.
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
	
	(aSpaceShip hasReachedMaxProgressFor: totalLaps boardSize: boardSize)
		ifTrue: [
			aSpaceShip finishAt: boardSize withLaps: totalLaps.
			^ self ].

	(aSpaceShip isBeforeBoardStart: boardSize) ifTrue: [ ^ self ].

	

	aSpaceShip adjustLapAndPositionRelativeTo: boardSize.

	^ self
]

{ #category : 'accessing' }
Board >> boardSize [

	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForPowerUps: aSpaceShip andAllSpaceShips: allSpaceShips [

	| cell |
	gameBoard ifNotNil: [
		cell := gameBoard at: aSpaceShip getTemporaryPosition.
		cell takeAction: aSpaceShip andOtherSpaceShips: allSpaceShips ].

	self checkForWormHole: aSpaceShip
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aSpaceShip [

	aSpaceShip updateTemporaryPosition:
		(wormHole verifyPosition: aSpaceShip getTemporaryPosition)
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
