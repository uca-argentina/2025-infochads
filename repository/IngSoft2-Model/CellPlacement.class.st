Class {
	#name : 'CellPlacement',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'gameBoard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CellPlacement >> atomicBombCellsWithPercentage: aPercentage andShieldsSacrificed: aNumberOfShields [

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
CellPlacement >> blackHoleCellsWithPercentage: aPercentage andDesplacemets: aDesplacement [

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
CellPlacement >> createBoardWithCellConfiguration: aConfigDice andSize: aBoardSize [

	boardSize := aBoardSize.
	gameBoard := OrderedCollection new.
	aConfigDice isEmpty ifTrue: [ ^nil ].
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

	self fillTheMissingCells.

	^ gameBoard 
]

{ #category : 'creation' }
CellPlacement >> fillTheMissingCells [

	gameBoard size = boardSize ifTrue: [ ^ self ].
	1 to: boardSize - gameBoard size do: [ :cell |
		gameBoard add: (Cell new initializeWithType: #normal effect: nil) ]
]

{ #category : 'creation' }
CellPlacement >> hyperJumpCellsWithPercentage: aPercentage andParsecValue: aParsecValue andJumpList: aConfigDice [

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
CellPlacement >> hyperSpaceJumpCellsWithPercantage: aPercentage andDesplacements: aDesplacement andShieldsLost: aShieldNumber [

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

{ #category : 'creation' }
CellPlacement >> moonWalkCellsWithPercentage: aPercentage andDisplacements: aConfigDice [

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
CellPlacement >> normalCellsWithPercentage: aPercentage [
	|numberOfCells|
	numberOfCells := (aPercentage*boardSize)/100.
	
	1 to: numberOfCells do: [ :cell |
		gameBoard add:
			(Cell new initializeWithType: #normal effect: nil) ].
]
