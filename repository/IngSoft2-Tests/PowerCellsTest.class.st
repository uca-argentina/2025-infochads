Class {
	#name : 'PowerCellsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
PowerCellsTest >> readme [
	"{ %Normal. %BlackHole. %HyperSpaceJump. %HyperJump. %AtomicBomb. %MoonWalk. -> (The sum of the values must be %100)

	Parsecs. Len Array HyperJump. jump1. jump2. ... jumpN. -> (Jumps are the values in the array)
	
	MoonWalk1. MoonWalk2. ... MoonWalkM.  } -> Config MoonWalk (Deduct values to ships)"

	
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

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2. 2. 2. 2. 5 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 100. 3. 30. 20. 10 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing: aDiceSet
		         wonAfter: 4.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 33.
	self assert: (aGame positionOf: 2) equals: 23.
	self assert: (aGame positionOf: 3) equals: 13.
	self assert: (aGame positionOf: 4) equals: 1
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
PowerCellsTest >> testWhenARandomizedBoardThenTheFirstAndLastPositionsAreNormalCells [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 50. 49 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 40. 20. 20. 8. 2. 10. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7. 7. 7. 7. 7. 7. 10. 6. 4. 2. 5. 7. 7. 7.
		                     7. 7. 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 50
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAShipMovesLandsOnAPowerCellAndMovesDueToItThenTheNextPowerCellDoesNotAffect [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 37 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 100. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.


	aGame start.
	self assert: (aGame positionOf: 1) equals: 42
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAShipMovesToAHyperJumpWith50ParsecDivisionAnd30_20_10JumpsThenItMoves30Jumps [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 50. 3. 30. 20. 10. 6. 4. 2.
		                     5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 4
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 21
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAThirdShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves10Jumps [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 40. 40. 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 46
]

{ #category : 'tests' }
PowerCellsTest >> testWhenAnotherShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves20Jumps [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 40. 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 6.
	self assert: (aGame positionOf: 2) equals: 1
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
PowerCellsTest >> testWhenShipIsMovedByAnEffectToAWormHoleThenIsTPdToACellThatHasNoEffectOnTheShip [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 30 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 100. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.

	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 35 endingAt: 4)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAAtomicBombCellThenAllShipsReturnToBeguiningAndLose1Shield [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 49. 10 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 100. 0. 100. 3. 30. 20. 10. 6. 4. 2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame shieldOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame shieldOf: 2) equals: 2
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToABlackHoleCellThenItGoesBack4Spaces [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 20 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 100. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 17
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAHyperJumpWith100ParsecDivisionAnd30_20_10JumpsThenItMoves30Moves [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 40 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 100. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAHyperSpaceJumpCellThenItMovesForward4SpacesAndLose1Shield [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 30 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 100. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 35.
	self assert: (aGame shieldOf: 1) equals: 2
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAMoonWalkCellOf4ThenItMovesEveryShipExceptForSelectedBack4Steps [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10. 11. 46 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 100. 100. 3. 30. 20. 10. 4. 4.
		                     4. 4. 4. 0 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 3.
	self assert: (aGame positionOf: 2) equals: 8.
	self assert: (aGame positionOf: 3) equals: 47
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAMoonWalkCellOf6ThenItMovesEveryShipExceptForSelectedBack6Steps [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 50. 60. 70 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 100. 100. 3. 30. 20. 10. 6. 6.
		                     6. 6. 6. 6. 0 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 39.
	self assert: (aGame positionOf: 2) equals: 55.
	self assert: (aGame positionOf: 3) equals: 71
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToAMoonWalkCellOf6ThenShipWithNegativePositionMoveToBeguiningOfLap [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2. 3. 45 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 0. 0. 0. 0. 0. 100. 100. 3. 30. 20. 10. 6. 6.
		                     6. 6. 6. 6. 0 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 1.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 46
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToNormalCellThenItStaysThere [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 0. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7 }.
	aBoard := Board
		          withSize: 50
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 2
]

{ #category : 'tests' }
PowerCellsTest >> testWhenShipMovesToNormalInABiggerBoardCellThenItStaysThere [

	| aGame aDiceSet aConfigureDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 38 }.
	aConfigureDiceSet := RiggedDice new initializeWith:
		                     { 100. 0. 0. 0. 0. 0. 100. 3. 30. 20. 10. 6. 4.
		                     2. 5. 7. 5. 6. 3. 4. 2 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: aConfigureDiceSet.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: (aGame positionOf: 1) equals: 39
]
