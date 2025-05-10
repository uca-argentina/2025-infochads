Class {
	#name : 'TurnsTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
TurnsTests >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsToPlayAndSpaceShip1PlaysThenIsValid [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 2.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsToPlayAndSpaceShip2PlaysThenCreationFails [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 2.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 1.

	self
		should: [ aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll ]
		raise: Error
		withMessageText: 'Its space ship 1 turn to move.'
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsToPlayAndSpaceShip3PlaysThenCreationFails [

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 2.

	self
		should: [ aGame moveSpaceShip: 3 numberOfPositions: aDiceRoll ]
		raise: Error
		withMessageText: 'Its space ship 1 turn to move.'
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip2IsToPlayAndSpaceShip2PlaysThenIsValid [ 

	| aGame aDiceRoll boardSize numberOfSpaceShips |
	boardSize := 10.
	numberOfSpaceShips := 3.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips.

	aDiceRoll := 2.

	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.
	aGame moveSpaceShip: 2 numberOfPositions: aDiceRoll.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 2) equals: 2.
]
