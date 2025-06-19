Class {
	#name : 'CellPlacement',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'rawCellDistribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
CellPlacement >> addNormalCellAtBeguiningAndEndOfBoard: netCellDistibution [

	| safeCell |
	safeCell := Cell has: NoEffect new.
	netCellDistibution at: 1 put: safeCell.
	netCellDistibution at: boardSize put: safeCell.
	^ netCellDistibution
]

{ #category : 'creation' }
CellPlacement >> atomicBombCellsWithPercentage: aPercentage and: aDesplacement [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :cell |
		            Cell has:
			            (AtomicBombEffect with: aDesplacement) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> blackHoleCellsWithPercentage: aPercentage andDesplacemets: aDesplacement [

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :cell |
		            Cell has:
			            (BlackHoleEffect withBackTrack: aDesplacement) ].
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

	| probabilities |
	probabilities := self obtainProbabilities: aConfigDice.
	self theProbabilitiesMustSum100: probabilities.
	
	self normalCellsWithPercentage: (probabilities at: 1).
	self blackHoleCellsWithPercentage: (probabilities at: 2) andDesplacemets: 4.
	self
		hyperSpaceJumpCellsWithPercantage: (probabilities at: 3)
		andDesplacements: 4.
	self
		hyperJumpCellsWithPercentage: (probabilities at: 4)
		andParsecValue: aConfigDice toss
		andJumpList: aConfigDice.
	self atomicBombCellsWithPercentage: (probabilities at: 5) and: 0.
	self moonWalkCellsWithPercentage: (probabilities at: 6) andDisplacements: aConfigDice
]

{ #category : 'creation' }
CellPlacement >> hyperJumpCellsWithPercentage: aPercentage andParsecValue: aParsecValue andJumpList: aConfigDice [

	| jumps amountOfJumps newCells |
	amountOfJumps := aConfigDice toss.
	jumps := OrderedCollection new: amountOfJumps.

	1 to: amountOfJumps do: [ :jump | jumps add: aConfigDice toss ].


	newCells := (1 to: aPercentage) collect: [ :cell |
		            Cell has:
			            (HyperJumpEffect
				             with: aParsecValue // boardSize 
				             andParsec: jumps) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> hyperSpaceJumpCellsWithPercantage: aPercentage andDesplacements: aDesplacement [ 

	| newCells |
	newCells := (1 to: aPercentage) collect: [ :cell |
		            Cell has: (HyperSpaceJumpEffect
				             with: aDesplacement) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> moonWalkCellsWithPercentage: aPercentage andDisplacements: aConfigDice [

	| newCells stepBackwards allDisplacements repeat |
	stepBackwards := self obtainNextDisplacement: aConfigDice.
	repeat := boardSize.

	allDisplacements := Array streamContents: [ :particular |
		                    repeat timesRepeat: [
			                    particular nextPutAll: stepBackwards ] ].

	newCells := (1 to: aPercentage) collect: [ :particular |
		            Cell has:
			            (MoonWalkEffect with: (allDisplacements at: particular)) ].
	rawCellDistribution := rawCellDistribution , newCells
]

{ #category : 'creation' }
CellPlacement >> normalCellsWithPercentage: aPercentage [

	1 to: aPercentage do: [ :cell |
	rawCellDistribution add: (Cell has: NoEffect new) ]
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
CellPlacement >> obtainProbabilities: aConfigureDice [

	^ (1 to: 6) collect: [ :effect | aConfigureDice toss ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> randomCellPicking [

    ^ (1 to: boardSize) collect: [ :cell |
          rawCellDistribution at: ((1 to: 100) atRandom) ]
]

{ #category : 'as yet unclassified' }
CellPlacement >> theProbabilitiesMustSum100: percentajes [

	(percentajes sum: [ :proba | proba ]) = 100 ifFalse: [
		Error signal: 'The probabilites dont sum 100.' ]
]
