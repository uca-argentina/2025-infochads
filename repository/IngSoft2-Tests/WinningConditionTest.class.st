Class {
	#name : 'WinningConditionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WinningConditionTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
WinningConditionTest >> testWhenARoundHasPassedAndSpaceShip1WinsTheGameIsOver [

	| aGame aDiceRoll boardSize numberOfSpaceShips aDiceRoll2 |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 7.
	aDiceRoll2 := 3.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 3 numberOfPositions: aDiceRoll2.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll2.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenAfterARoundSpaceShip1WinsGameIsOverThenInformsSpaceShip2And3Position [

	| aGame aDiceRoll boardSize numberOfSpaceShips aDiceRoll2 |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 7.
	aDiceRoll2 := 3.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll2.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll2.
	aGame moveSpaceShip: 3 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 2) equals: 3.
	self assert: (aGame positionOfSpaceShip: 3) equals: 7
]

{ #category : 'tests' }
WinningConditionTest >> testWhenDiceRollIsHigherThanBoardSizeThenSpaceShipMovesToTheFinishLineTheGameIsOver [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 12.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenGameIsOverSpaceShip2CanNotPlay [

	| aGame aDiceRoll aDiceRoll2 boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 10.
	aDiceRoll2 := 1.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self
		should: [ aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll2 ]
		raise: Error
		withMessageText: 'Space ship 1 has already won.'
]

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

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsGameOverThenInformsSpaceShip1Position [

	| aGame aDiceRoll boardSize numberOfSpaceShips aDiceRoll2 |
	boardSize := 10.
	numberOfSpaceShips := 2.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 10.
	aDiceRoll2 := 3.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll2.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll.
	
	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 3.
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsThenGameIsOver [

	| aGame aDiceRoll boardSize numberOfSpaceShips aDiceRoll2 |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 5.
	aDiceRoll2 := 10.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll2.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1WinsAndInformsSpaceShip1_2And3Positions [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 10.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0.
	self assert: (aGame positionOfSpaceShip: 3) equals: 0
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip3WinsAndSpaceShip1CanNotPlay [

	| aGame aDiceRoll boardSize numberOfSpaceShips aDiceRoll2 |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 5.
	aDiceRoll2 := 10.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 3 numberOfPositions: aDiceRoll2.

	self
		should: [ aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll ]
		raise: Error
		withMessageText: 'Space ship 3 has already won.'
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip3WinsGameIsOverThenInformsSpaceShip1And2Positions [

	| aGame aDiceRoll boardSize numberOfSpaceShips aDiceRoll2 |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 10.
	aDiceRoll2 := 3.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll2.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll2.
	aGame moveSpaceShip: 3 numberOfPositions: aDiceRoll.

	self assert: aGame isOver.
	self assert: (aGame positionOfSpaceShip: 1) equals: 3.
	self assert: (aGame positionOfSpaceShip: 2) equals: 3
]
