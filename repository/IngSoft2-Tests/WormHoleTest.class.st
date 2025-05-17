Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormHoleTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnFirstWormHoleThenTeleportsToSecondWormHoleThenIsValid [

	| aGame aWormHolePosition aDiceRoll |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { 3. 7 }.
	aGame withWormHole: aWormHolePosition.
	aDiceRoll := 3.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnSecondWormHoleThenTeleportsToFirstWormHoleThenIsValid [

	| aGame aWormHolePosition aDiceRoll |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { 3. 7 }.
	aGame withWormHole: aWormHolePosition.
	aDiceRoll := 7.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryHoleIsNegativeThenIsInvalid [

	| aGame aWormHolePosition |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { -1. 7 }.
	self
		should: [ aGame withWormHole: aWormHolePosition ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryHoleIsZeroThenIsInvalid [

	| aGame aWormHolePosition |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { 0. 7 }.
	self
		should: [ aGame withWormHole: aWormHolePosition ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryWormHoleIsEqualsToExitWormHoleThenIsInvalid [

	| aGame aWormHolePosition |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { 7. 7 }.

	self
		should: [ aGame withWormHole: aWormHolePosition ]
		raise: Error
		withMessageText: 'The WormHole Entry cannot be the exit.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsEqualToBoardSizeThenIsInvalid [

	| aGame aWormHolePosition |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { 3. 10 }.
	self
		should: [ aGame withWormHole: aWormHolePosition ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsHigherThanABoardSizeThenIsInvalid [

	| aGame aWormHolePosition |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := { 3. 11 }.
	self
		should: [ aGame withWormHole: aWormHolePosition ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenWormHoleIsNotAnIntThenIsInvalid [

	| aGame aWormHolePosition |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHolePosition := '2->5'.

	self
		should: [ aGame withWormHole: aWormHolePosition ]
		raise: Error
		withMessageText: 'WormHole must be a pair of integers.'
]
