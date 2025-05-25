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

{ #category : 'creation' }
Board >> atomicBombCellsWithPercentage: aPercentage andShieldsSacrificed: aNumberOfShields [

	| numberOfCells newCells |
	numberOfCells := aPercentage * boardSize / 100.

	newCells := (1 to: numberOfCells) collect: [ :i |
		            Cell new
			            initializeWithType: #atomicBomb
			            effect:
			            (AtomicBombEffect new shieldsSacrificed: aNumberOfShields) ].
	gameBoard := gameBoard, newCells
]

{ #category : 'creation' }
Board >> blackHoleCellsWithPercentage: aPercentage andDesplacemets: aDesplacement [

	| numberOfCells newCells |
	numberOfCells := aPercentage * boardSize / 100.

	newCells := (1 to: numberOfCells) collect: [ :i |
		            Cell new
			            initializeWithType: #blackhole
			            effect:
			            (BlackHoleEffect new withDesplacementValue: aDesplacement) ].
	gameBoard := gameBoard, newCells
]

{ #category : 'as yet unclassified' }
Board >> boardLimitAdjustment: aSpaceShip lap: totalLaps [

	aSpaceShip getTemporaryPosition <= 0 ifTrue: [
		aSpaceShip updateTemporaryPosition: 1 ].

	(aSpaceShip isBeforeBoardStart: boardSize) ifTrue: [ ^ self ].

	(aSpaceShip hasReachedMaxProgressFor: totalLaps boardSize: boardSize)
		ifTrue: [
			aSpaceShip finishAt: boardSize withLaps: totalLaps.
			^ self ].

	aSpaceShip adjustLapAndPositionRelativeTo: boardSize.

	^ self
]

{ #category : 'accessing' }
Board >> boardSize [

	boardSize ifNil: [ Error signal: 'Board size not initialized' ].
	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForPowerUps: aSpaceShip andOtherSpaceShips: allSpaceShips [

	| cell |
	gameBoard ifNil: [ ^ self ].
	cell := gameBoard at: aSpaceShip getTemporaryPosition.

	cell takeAction: aSpaceShip andOtherSpaceShips: allSpaceShips
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aSpaceShip [

	aSpaceShip updateTemporaryPosition: (wormHole verifyPosition: aSpaceShip getTemporaryPosition ). "extract"

]

{ #category : 'creation' }
Board >> createBoardWithCellConfiguration: aConfigDice [

	gameBoard := OrderedCollection new.
	self normalCellsWithPercentage: 40.
	self blackHoleCellsWithPercentage: 20 andDesplacemets: -4.
	self
		hyperSpaceJumpCellsWithPercantage: 20
		andDesplacements: 4
		andShieldsLost: -1.
	self
		hyperJumpCellsWithPercentage: 8
		andParsecValue: aConfigDice toss
		andJumpList: aConfigDice.
	self atomicBombCellsWithPercentage: 2 andShieldsSacrificed: -1.
	self moonWalkCellsWithPercentage: 10 andDisplacements: aConfigDice.

	^ self
]

{ #category : 'creation' }
Board >> hyperJumpCellsWithPercentage: aPercentage andParsecValue: aParsecValue andJumpList: aConfigDice [

	| numberOfCells jumps amountOfJumps newCells |
	numberOfCells := aPercentage * boardSize / 100.

	amountOfJumps := aConfigDice toss.
	jumps := Array new: amountOfJumps.

	jumps := (1 to: amountOfJumps) collect: [ :i | aConfigDice toss ].


	newCells := (1 to: numberOfCells) collect: [ :i |
		            Cell new
			            initializeWithType: #hyperJump
			            effect: (HyperJumpEffect new
					             withParsecValue: aParsecValue
					             totalBoardSize: boardSize
					             andParsecJumps: jumps) ].
	gameBoard := gameBoard, newCells
]

{ #category : 'creation' }
Board >> hyperSpaceJumpCellsWithPercantage: aPercentage andDesplacements: aDesplacement andShieldsLost: aShieldNumber [

	| numberOfCells newCells |
	numberOfCells := aPercentage * boardSize / 100.

	newCells := (1 to: numberOfCells) collect: [ :i |
		            Cell new
			            initializeWithType: #hyperSpaceJump
			            effect: (HyperSpaceJumpEffect new
					             withDesplacementValue: aDesplacement
					             andShieldsSacrificed: aShieldNumber) ].
	gameBoard := gameBoard, newCells
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize andWormHolePosition: aWormHolePosition andCellConfiguration: aConfigDiceSet [

	boardSize := aBoardSize.

	(aConfigDiceSet isEmpty) ifFalse: [self createBoardWithCellConfiguration: aConfigDiceSet ] .


	wormHole := WormHole withGates: aWormHolePosition.
	wormHole mustBeWithInLimits: aBoardSize.
	^ self
]

{ #category : 'creation' }
Board >> moonWalkCellsWithPercentage: aPercentage andDisplacements: aConfigDice [

	| numberOfCells newCells |
	numberOfCells := aPercentage * boardSize / 100.

	newCells := (1 to: numberOfCells) collect: [ :i |
		            Cell new
			            initializeWithType: #moonWalk
			            effect:
			            (MoonWalkEffect new withDesplacementValue:
				             aConfigDice toss * -1) ].
	gameBoard := gameBoard , newCells
]

{ #category : 'creation' }
Board >> normalCellsWithPercentage: aPercentage [
	|numberOfCells|
	numberOfCells := (aPercentage*boardSize)/100.
	
	1 to: numberOfCells do: [ :cell |
		gameBoard add:
			(Cell new initializeWithType: #normal effect: nil) ].
]

{ #category : 'as yet unclassified' }
Board >> withWormHole: aWormHole [

	wormHole := WormHole withGates: aWormHole.
	wormHole wormHoleMustBeWithinLimits: boardSize
]
