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
		        effect: (AtomicBombEffect new shieldsSacrificed: 1).

	self assert: cell type equals: #atomicBomb
]

{ #category : 'tests' }
PowerCellsTest >> testWhenABlackHoleEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #blackHole
		        effect: (BlackHoleEffect new withDesplacementValue: 4).

	self assert: cell type equals: #blackHole
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAForthShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves30JumpsAndCombatsWithFirstShip [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 40. 40. 40. 40. 2. 1}.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 4
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 6.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 3) equals: 46.
	self assert: (aGame positionOfSpaceShip: 4) equals: 1.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenAHyperJumpEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #hyperJump
		        effect: (HyperJumpEffect new
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
		        effect: (MoonWalkEffect new withDesplacementValue: 4).
		
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
PowerCellsTest >> testWhenAShipMovesLandsOnAPowerCellAndMovesDueToItThenTheNextPowerCellDoesNotAffect [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 37 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 42.


]

{ #category : 'tests' }
PowerCellsTest >> testWhenAShipMovesToAHyperJumpWith50ParsecDivisionAnd30_20_10JumpsThenItMoves30Jumps [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 50. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 4
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 21.


]

{ #category : 'tests' }
PowerCellsTest >> testWhenAThirdShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves10Jumps [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 40. 40. 40. }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 6.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 3) equals: 46.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenHyperSpaceJumpEffectIsAppliedToCellThenCanBeCreated [

	| cell |
	cell := Cell new
		        initializeWithType: #hyperSpaceJump
		        effect:
		        (HyperSpaceJumpEffect new 
			         withDesplacementValue: 4
			         andShieldsSacrificed: 1).

	self assert: cell type equals: #hyperSpaceJump
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipAnotherMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves20Jumps [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 40. 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 6.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAAtomicBombCellThenAllShipsReturnToBeguiningAndLose1Shield [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10. 14. 44 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame shieldStatus: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame shieldStatus: 2) equals: 2.
	self assert: (aGame positionOfSpaceShip: 3) equals: 1.
	self assert: (aGame shieldStatus: 3) equals: 2.
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToABlackHoleCellThenItGoesBack4Spaces [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 20 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 17
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves30Moves [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 6.

]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAHyperSpaceJumpCellThenItMovesForward4SpacesAndLose1Shield [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 30 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 35.
	self assert: (aGame shieldStatus: 1) equals: 2
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAMoonWalkCellOf4ThenItMovesEveryShipExceptForSelectedBack6Steps [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10. 11. 46 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 7.
	self assert: (aGame positionOfSpaceShip: 2) equals: 8.
	self assert: (aGame positionOfSpaceShip: 3) equals: 47.
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAMoonWalkCellOf6ThenItMovesEveryShipExceptForSelectedBack6Steps [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10. 11. 45 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 5.
	self assert: (aGame positionOfSpaceShip: 2) equals: 6.
	self assert: (aGame positionOfSpaceShip: 3) equals: 46.
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAMoonWalkCellOf6ThenShipWithNegativePositionMoveToBeguiningOfLap [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 3. 45 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aGame := Game
		         withBoardSize: 50
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
		         withCellConfigurations: aConfigureDiceSet.

	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 3) equals: 46.
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToNormalCellThenItStaysThere [

	| aGame aDiceSet aConfigureDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
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
