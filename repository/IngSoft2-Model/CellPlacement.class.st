Class {
	#name : 'CellPlacement',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'rawCellDistribution',
		'distribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
CellPlacement >> addNormalCellAtBeguiningAndEndOfBoard: netCellDistibution [

    netCellDistibution at: 1 put: (rawCellDistribution at: 1).
    netCellDistibution at: boardSize put: (rawCellDistribution at: 1).
    ^ netCellDistibution
]

{ #category : 'creation' }
CellPlacement >> atomicBombCellsWithPercentage: aPercentage andShieldsSacrificed: aNumberOfShields [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #atomicBomb
			            effect:
			            (AtomicBombEffect new shieldsSacrificed:
				             aNumberOfShields) ].
	rawCellDistribution := rawCellDistribution , newCells
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
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'as yet unclassified' }
CellPlacement >> createBoardWithCellConfiguration: aConfigDice andSize: aBoardSize [

 
	boardSize := aBoardSize.
	rawCellDistribution := OrderedCollection new.
	aConfigDice isEmpty ifTrue: [ ^ nil ].
	distribution := aConfigDice toss.
	self generateUniverse: aConfigDice.
	^ self extractSample.

	 
]

{ #category : 'as yet unclassified' }
CellPlacement >> extractSample [

	| netCellDistibution |
	netCellDistibution := distribution = 0
		                      ifTrue: [ self randomCellPicking ]
		                      ifFalse: [ self selectiveCellPicking ].

	^ self addNormalCellAtBeguiningAndEndOfBoard: netCellDistibution
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
	rawCellDistribution := rawCellDistribution , newCells
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
	rawCellDistribution := rawCellDistribution , newCells
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
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> normalCellsWithPercentage: aPercentage [

	1 to: aPercentage do: [ :cell |
		rawCellDistribution add: (Cell new initializeWithType: #normal effect: nil) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainFragmentOfCellsFromRawCellDistribution: range [

    ^ rawCellDistribution copyFrom: range first to: range second
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainRange [

	distribution = 1 ifTrue: [ ^ { 1. 40 } ]. "Normal"

	distribution = 2 ifTrue: [ ^ { 41. 60 } ]. "Black Hole"

	distribution = 3 ifTrue: [ ^ { 61. 80 } ]. "Hyper Space Jump"

	distribution = 4 ifTrue: [ ^ { 81. 88 } ]. "Hyper Jump"

	distribution = 5 ifTrue: [ ^ { 89. 90 } ]. "Atomic Bomb"

	distribution = 6 ifTrue: [ ^ { 91. 100 } ] "Moon Walk"
]

{ #category : 'as yet unclassified' }
CellPlacement >> randomCellPicking [

    ^ (1 to: boardSize) collect: [ :cell |
          rawCellDistribution at: (Random new nextInteger: 100) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> repeat: netCellDistibution theseManyTimes: repetitions [

    ^ (Array streamContents: [ :s |
           repetitions timesRepeat: [ s nextPutAll: netCellDistibution ] ])
          copyFrom: 1
          to: boardSize
]

{ #category : 'as yet unclassified' }
CellPlacement >> selectiveCellPicking [

	| range netCellDistibution fragmentLength repetitions |
	range := self obtainRange.
	netCellDistibution := self
		                      obtainFragmentOfCellsFromRawCellDistribution:
		                      range.

	fragmentLength := range second - range first + 1.
	repetitions := (boardSize / fragmentLength) ceiling.

	netCellDistibution := self
		                      repeat: netCellDistibution
		                      theseManyTimes: repetitions.
	^ netCellDistibution
]
