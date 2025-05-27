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
Board class >> boardSizeMustBePositiveInteger: aBoardSize [

	aBoardSize isInteger ifFalse: [
		Error signal: 'Board Size must be a positive interger.' ]
]

{ #category : 'as yet unclassified' }
Board class >> boardSizeMustBePositiveOverZero: aBoardSize [

	aBoardSize <= 0 ifTrue: [ Error signal: 'Board Size must be over 0.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize andWormHolePosition: aWormHolePosition andCellConfiguration: aConfigDiceSet [

	self boardSizeMustBePositiveInteger: aBoardSize.
	self boardSizeMustBePositiveOverZero: aBoardSize.
	^ self new
		  initializeWithSize: aBoardSize
		  andWormHolePosition: aWormHolePosition
		  andCellConfiguration: aConfigDiceSet
]

{ #category : 'as yet unclassified' }
Board >> adjustPositionOf: aSpaceShip withTotallaps: totalLaps [

	self boardLimitAdjustment: aSpaceShip lap: totalLaps.

	aSpaceShip updatePosition
]

{ #category : 'as yet unclassified' }
Board >> boardLimitAdjustment: aSpaceShip lap: totalLaps [
	
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

	boardSize ifNil: [ Error signal: 'Board size not initialized' ].
	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForPowerUps: aSpaceShip andAllSpaceShips: allSpaceShips [

	| cell |
	gameBoard ifNil: [ ^ self ].
	cell := gameBoard at: (aSpaceShip getTemporaryPosition).

	cell takeAction: aSpaceShip andOtherSpaceShips: allSpaceShips
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aSpaceShip [

	wormHole positions isNil ifTrue: [ ^ self ].
	aSpaceShip updateTemporaryPosition:
		(wormHole verifyPosition: aSpaceShip getTemporaryPosition)
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize andWormHolePosition: aWormHolePosition andCellConfiguration: aConfigDiceSet [

	boardSize := aBoardSize.
	gameBoard := CellPlacement new createBoardWithCellConfiguration: aConfigDiceSet andSize: boardSize.

	wormHole := WormHole withGates: aWormHolePosition.
	wormHole mustBeWithInLimits: aBoardSize.
	^ self
]

{ #category : 'as yet unclassified' }
Board >> shuffle [

	| range randomizedBoard |
	range := Random new.
	randomizedBoard := gameBoard asSortedCollection: [ :a :b |
		               range next < 0.5 ].
	gameBoard := randomizedBoard.
]

{ #category : 'as yet unclassified' }
Board >> withWormHole: aWormHole [

	wormHole := WormHole withGates: aWormHole.
	wormHole wormHoleMustBeWithinLimits: boardSize
]
