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

	| aGame aWormHole aDiceRoll |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 3. 7 }.
	aGame allocatedWormHole: aWormHole.
	aDiceRoll := 3.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnSecondWormHoleThenTeleportsToFirstWormHoleThenIsValid [

	| aGame aWormHole aDiceRoll |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 3. 7 }.
	aGame allocatedWormHole: aWormHole.
	aDiceRoll := 7.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryWormHoleIsEqualsToExitWormHoleThenIsInvalid [

	| aGame aWormHole  |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 7. 7 }.
	
	self
		should: [ aGame allocatedWormHole: aWormHole ]
		raise: Error
		withMessageText: 'First WormHole should be lower than second one.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsHigherThanABoardSizeThenIsInvalid [

	| aGame aWormHole  |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 3. 11 }.
	self
		should: [ aGame allocatedWormHole: aWormHole ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitWormHoleIsLowerThanEntryWormHoleThenIsInvalid [

	| aGame aWormHole  |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 5.  2}.
	

	self
		should: [ aGame allocatedWormHole: aWormHole ]
		raise: Error
		withMessageText: 'First WormHole should be lower than second one.'
]
