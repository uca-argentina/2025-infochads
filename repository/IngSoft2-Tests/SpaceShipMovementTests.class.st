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
SpaceShipMovementTests >> testWhenDice1Rolls1AndDice2Rolls1ThenMoveSpaceShip1And2ToPosition1 [

	| aGame aDiceRoll1 aDiceRoll2 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 2.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll1 := 1.
	aDiceRoll2 := 1.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll1.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll2.

	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDice1Rolls1AndDice2Rolls2ThenMoveSpaceShipToPosition3 [

	| aGame aDiceRoll1 aDiceRoll2 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 1.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.
	aDiceRoll1 := 1.
	aDiceRoll2 := 2.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll1.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll2.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRoll5ThenMovesSpaceShipToPosition5 [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 1.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 5.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 5
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRolls6ThenMoveSpaceShipToPosition6 [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 1.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 6.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 6
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenIntendedToMoveSpaceShip3WhenOnly2AreOnGameThenCreationFails [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 2.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.
	aDiceRoll := 1.
	self
		should: [ aGame moveSpaceShip: 3 numberOfPositions: aDiceRoll. ]
		raise: Error
		withMessageText:
		'Invalid spaceship ID. There are only 2 spaceships.'
]
