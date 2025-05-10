Class {
	#name : 'WinningConditionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WinningConditionTest >> testWhenGameNotifiesAWinnerThenItsOver [

	| aGame aDiceRoll aDiceRoll2 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 10.
	aDiceRoll2 := 1.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame isOver)
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1HasMovedToTheEndOfThenIsValid [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 10.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndGameIsntOverThenGameContinues [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 5.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self deny: aGame isOver
]
