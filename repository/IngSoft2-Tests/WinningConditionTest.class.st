Class {
	#name : 'WinningConditionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WinningConditionTest >> testWhenARoundHasPassedAndSpaceShip1WinsTheGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3. 9 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenAfterARoundSpaceShip1WinsGameIsOverThenInformsSpaceShip2And3Position [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 8. 3. 7. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 2) equals: 4.
	self assert: (aGame positionOfSpaceShip: 3) equals: 8
]

{ #category : 'tests' }
WinningConditionTest >> testWhenDiceRollIsHigherThanBoardSizeThenSpaceShipMovesToTheFinishLineTheGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 12 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1HasMovedToTheEndOfThenGameIsOver [

		| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.
	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndGameIsntOverThenGameContinues [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self deny: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsGameThenInformsSpaceShip1Position [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 3. 10 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 4
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsThenGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 3. 10 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver.
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1WinsAndInformsSpaceShip1_2And3Positions [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 3) equals: 1
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip3WinsGameIsOverThenInformsSpaceShip1And2Positions [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 10 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: aGame isOver.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 2) equals: 3
]
