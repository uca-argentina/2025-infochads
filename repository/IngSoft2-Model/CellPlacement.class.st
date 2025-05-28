Class {
	#name : 'CellPlacement',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'gameBoard',
		'distribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CellPlacement >> atomicBombCellsWithPercentage: aPercentage andShieldsSacrificed: aNumberOfShields [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #atomicBomb
			            effect:
			            (AtomicBombEffect new shieldsSacrificed:
				             aNumberOfShields) ].
	gameBoard := gameBoard , newCells
]

{ #category : 'creation' }
CellPlacement >> blackHoleCellsWithPercentage: aPercentage andDesplacemets: aDesplacement [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #blackhole
			            effect:
			            (BlackHoleEffect new withDesplacementValue:
				             aDesplacement) ].
	gameBoard := gameBoard , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> createBoardWithCellConfiguration: aConfigDice andSize: aBoardSize [

 
	boardSize := aBoardSize.
	gameBoard := OrderedCollection new.
	aConfigDice isEmpty ifTrue: [ ^ nil ].
	distribution := aConfigDice toss.
	self generateUniverse: aConfigDice.
	^ self extractSample.

	 
]

{ #category : 'as yet unclassified' }
CellPlacement >> extractSample [

	| range aux |
	distribution = 0
		ifTrue: [
			^ (1 to: boardSize) collect: [ :subject |
				  gameBoard at: (Random new nextInteger: 100) ] ]
		ifFalse: [
			range := self obtainRange.
			aux := gameBoard copyFrom: range first to: range second.
			^ Array streamContents: [ :s |
				  boardSize / (range second - range first + 1) timesRepeat: [
					  s nextPutAll: aux ] ] ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> generateUniverse: aConfigDice [

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
	self moonWalkCellsWithPercentage: 10 andDisplacements: aConfigDice
]

{ #category : 'creation' }
CellPlacement >> hyperJumpCellsWithPercentage: aPercentage andParsecValue: aParsecValue andJumpList: aConfigDice [

	| jumps amountOfJumps newCells |
	amountOfJumps := aConfigDice toss.
	jumps := Array new: amountOfJumps.

	jumps := (1 to: amountOfJumps) collect: [ :i | aConfigDice toss ].


	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #hyperJump
			            effect: (HyperJumpEffect new
					             withParsecValue: aParsecValue
					             totalBoardSize: boardSize
					             andParsecJumps: jumps) ].
	gameBoard := gameBoard , newCells
]

{ #category : 'creation' }
CellPlacement >> hyperSpaceJumpCellsWithPercantage: aPercentage andDesplacements: aDesplacement andShieldsLost: aShieldNumber [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #hyperSpaceJump
			            effect: (HyperSpaceJumpEffect new
					             withDesplacementValue: aDesplacement
					             andShieldsSacrificed: aShieldNumber) ].
	gameBoard := gameBoard , newCells
]

{ #category : 'creation' }
CellPlacement >> moonWalkCellsWithPercentage: aPercentage andDisplacements: aConfigDice [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #moonWalk
			            effect:
			            (MoonWalkEffect new withDesplacementValue:
				             aConfigDice toss * -1) ].
	gameBoard := gameBoard , newCells
]

{ #category : 'creation' }
CellPlacement >> normalCellsWithPercentage: aPercentage [

	1 to: aPercentage do: [ :cell |
		gameBoard add: (Cell new initializeWithType: #normal effect: nil) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainRange [

	distribution = 1 ifTrue: [ ^ { 1. 40 } ].

	distribution = 2 ifTrue: [ ^ { 41. 60 } ].

	distribution = 3 ifTrue: [ ^ { 61. 80 } ].

	distribution = 4 ifTrue: [ ^ { 81. 88 } ].

	distribution = 5 ifTrue: [ ^ { 89. 90 } ].

	distribution = 6 ifTrue: [ ^ { 91. 100 } ]
]
