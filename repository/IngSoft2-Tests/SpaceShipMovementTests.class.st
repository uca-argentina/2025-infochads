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

	| gameBoard aDiceRoll1 aDiceRoll2 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 2.
	gameBoard := Board
		             withSize: boardSize
		             withNumberOfSpaceShips: numberOfSpaceShips.
	aDiceRoll1 := 1.
	aDiceRoll2 := 1.
	gameBoard moveSpaceShip: 1 numberOfPositions: aDiceRoll1.
	gameBoard moveSpaceShip: 2 numberOfPositions: aDiceRoll2.

	self assert: (gameBoard positionOfSpaceShip: 1) equals: 1.
	self assert: (gameBoard positionOfSpaceShip: 2) equals: 1.
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDice1Rolls1AndDice2Rolls2ThenMoveSpaceShipToPosition3 [

	| gameBoard aDiceRoll1 aDiceRoll2 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 1.
	gameBoard := Board
		             withSize: boardSize
		             withNumberOfSpaceShips: numberOfSpaceShips.
	aDiceRoll1 := 1.
	aDiceRoll2 := 2.
	gameBoard moveSpaceShip: 1 numberOfPositions: aDiceRoll1.
	gameBoard moveSpaceShip: 1 numberOfPositions: aDiceRoll2.

	self assert: (gameBoard positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRoll5ThenMovesSpaceShipToPosition5 [

	| gameBoard aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 1.
	gameBoard := Board
		             withSize: boardSize
		             withNumberOfSpaceShips: numberOfSpaceShips.
	aDiceRoll := 5.
	gameBoard moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (gameBoard positionOfSpaceShip: 1) equals: 5
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRolls6ThenMoveSpaceShipToPosition6 [

	| gameBoard aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 1.
	gameBoard := Board
		             withSize: boardSize
		             withNumberOfSpaceShips: numberOfSpaceShips.
	aDiceRoll := 6.
	gameBoard moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (gameBoard positionOfSpaceShip: 1) equals: 6
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenIntendedToMoveSpaceShip3WhenOnly2AreOnGameThenCreationFails [

	| gameBoard aDiceRoll1 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 2.
	gameBoard := Board
		             withSize: boardSize
		             withNumberOfSpaceShips: numberOfSpaceShips.
	aDiceRoll1 := 1.
	self
		should: [ gameBoard moveSpaceShip: 3 numberOfPositions: aDiceRoll1 ]
		raise: Error
		withMessageText:
		'Invalid spaceship ID. There are only 2 spaceships.'
]
