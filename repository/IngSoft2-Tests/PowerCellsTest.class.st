Class {
	#name : 'PowerCellsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
PowerCellsTest >> readme [
   " Para testeo de posiciones de celdas en tablero (board size 50)"
	" Normal     | BlackHole (4) | HyperSpaceJump (4,1) | HyperJump (parsecs , length M of list, jump1, jump2, ... ,jumpM) | AtomicBomb (1) | MoonWalk (N positions back) ..."
	" 40% -> 20c | 20% -> 10c    | 20% -> 10c           | 8% -> 4c                                                         | 2% -> 1        | 10% -> 5c "
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAAtomicBombEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #atomicBomb
		        effect: (AtomicBombEffect shieldsSacrificed: 1).

	self assert: cell type equals: #atomicBomb
]

{ #category : 'tests' }
PowerCellsTest >> testWhenABlackHoleEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #blackHole
		        effect: (BlackHoleEffect withDesplacementValue: 4).

	self assert: cell type equals: #blackHole
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAHyperJumpEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #hyperJump
		        effect: (HyperJumpEffect
				         withParsecValue: 100
				         totalBoardSize: 10
				         andParsecJumps: #( 10 7 2 )).

	self assert: cell type equals: #hyperJump
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAMoonWalkEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #moonWalk
		        effect: (MoonWalkEffect withDesplacementValue: 4).
		
	self assert: cell type equals: #moonWalk.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenANormalEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #normal
		        effect: nil.
		
	self assert: cell type equals: #normal.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenHyperSpaceJumpEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #hyperSpaceJump
		        effect:
		        (HyperSpaceJumpEffect
			         withDesplacementValue: 4
			         andShieldsSacrificed: 1).

	self assert: cell type equals: #hyperSpaceJump
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToNormalCellThenItStaysThere [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 4. 4. 1. 100. 3. 30. 20. 10. 1. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.
		
	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2
]
