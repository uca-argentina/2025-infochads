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
TurnsTests >> testWhenSpaceShip1IsTheOnlyPlayerThenCanPlayAlone [

	| aGame diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: diceSet
		         withWormHole: {  }.
	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsToPlayAndSpaceShip1PlaysThenIsValid [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }.
	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip2IsToPlayAndSpaceShip2PlaysThenIsValid [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 3 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }.
	aGame start.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 2) equals: 3
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip3IsToPlayAndSpaceShip3PlaysThenIsValid [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }.
	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 2.
	self assert: (aGame positionOfSpaceShip: 3) equals: 3
]

{ #category : 'tests' }
TurnsTests >> testWhenTheFirstRoundIsPlayedThenSpaceShip1IsToPlayThenIsValid [

		| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 2. 1. 3. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }.
	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 4.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 3) equals: 3
]
