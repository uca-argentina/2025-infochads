Class {
	#name : 'SpaceShipMovementTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenFirstDiceRolls1AndSecondDiceRolls2ThenTheSpaceShipMovesToPosition3 [

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
SpaceShipMovementTests >> testWhenFirstDiceRollsFiveThenTheSpaceShipMovesToPosition5 [

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
SpaceShipMovementTests >> testWhenFirstDiceRollsSixThenTheSpaceShipMovesToPosition5 [

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
