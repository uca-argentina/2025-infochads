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

	| safeCell |
	safeCell := Cell new initializeWithType: #normal effect: nil.
	netCellDistibution at: 1 put: safeCell.
	netCellDistibution at: boardSize put: safeCell.
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
	aConfigDice isEmpty ifTrue: [ ^ rawCellDistribution ].
	self generateUniverse: aConfigDice.
	^ self extractSample
]

{ #category : 'as yet unclassified' }
CellPlacement >> extractSample [

	| netCellDistibution |
	
	netCellDistibution := self randomCellPicking.

	^ self addNormalCellAtBeguiningAndEndOfBoard: netCellDistibution
]

{ #category : 'as yet unclassified' }
CellPlacement >> generateUniverse: aConfigDice [

	| percentages |
	percentages := self obtainPercentages: aConfigDice.
	self normalCellsWithPercentage: (percentages at: 1).
	self blackHoleCellsWithPercentage: (percentages at: 2) andDesplacemets: -4.
	self
		hyperSpaceJumpCellsWithPercantage: (percentages at: 3)
		andDesplacements: 4
		andShieldsLost: -1.
	self
		hyperJumpCellsWithPercentage: (percentages at: 4)
		andParsecValue: aConfigDice toss
		andJumpList: aConfigDice.
	self atomicBombCellsWithPercentage: (percentages at: 5) andShieldsSacrificed: -1.
	self moonWalkCellsWithPercentage: (percentages at: 6) andDisplacements: aConfigDice
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

	| newCells stepBackwards allStepBackwards repeat |
	stepBackwards := self obtainNextDisplacement: aConfigDice.
	repeat:= boardSize.
	
	allStepBackwards := Array streamContents: [ :s |
		             repeat timesRepeat: [ s nextPutAll: stepBackwards ] ].
	
	newCells := (1 to: aPercentage) collect: [ :i |
		            Cell new
			            initializeWithType: #moonWalk
			            effect:
			            (MoonWalkEffect new withDesplacementValue:
				             (allStepBackwards at: i) * -1) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> normalCellsWithPercentage: aPercentage [

	1 to: aPercentage do: [ :cell |
		rawCellDistribution add: (Cell new initializeWithType: #normal effect: nil) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainNextDisplacement: aConfigDice [

	| results throw |
	results := OrderedCollection new.
	throw := aConfigDice toss.
	[ throw = 0 or: (throw = -1) ] whileFalse: [
		results add: throw.
		throw := aConfigDice toss ].

	^ results
]

{ #category : 'as yet unclassified' }
CellPlacement >> obtainPercentages: aConfigureDice [

	^ (1 to: 6) collect: [ :effect | aConfigureDice toss ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> randomCellPicking [

    ^ (1 to: boardSize) collect: [ :cell |
          rawCellDistribution at: ((1 to: 100) atRandom) ]
]
