Class {
	#name : 'SpaceShipMovementTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpaceShipMovementTests >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
	
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenARiggedDiceToss6ThenShipMovesTo7 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 6 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRolls5ThenMovesSpaceShipToPosition6 [

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

	self assert: (aGame positionOfSpaceShip: 1) equals: 6
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenRiggedDiceToss1_2ThenShip1MovesTo4 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 4
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenRiggedDiceToss1_2_3ThenShip1MovesTo7 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]
