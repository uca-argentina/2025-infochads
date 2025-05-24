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

	| aGame aWormHole aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 3 }.
	aWormHole := { 3. 7 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: aWormHole
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnSecondWormHoleThenTeleportsToFirstWormHoleThenIsValid [

	| aGame aWormHole aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 7 }.
	aWormHole := { 3. 7 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: aWormHole
					withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryHoleIsNegativeThenIsInvalid [

	self
		should: [ WormHole withGates: { -1. 7 } ]
		raise: Error
		withMessageText: 'WormHole must be a pair of integers.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryHoleIsZeroThenIsInvalid [

	self
		should: [ WormHole withGates: { 0. 7 } ]
		raise: Error
		withMessageText: 'WormHole must be a pair of integers.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryWormHoleIsEqualsToExitWormHoleThenIsInvalid [

	self
		should: [ WormHole withGates: { 7. 7 } ]
		raise: Error
		withMessageText: 'The WormHole Entry cannot be the exit.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsEqualToBoardSizeThenIsInvalid [

	self
		should: [
			Game
				withBoardSize: 10
				withSpaceShips: 2
				withDiceSet: {  }
				withWormHole: { 10. 2 }
				withAmountOfLaps: 1 ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsHigherThanABoardSizeThenIsInvalid [

	self
		should: [
			Game
				withBoardSize: 10
				withSpaceShips: 2
				withDiceSet: {  }
				withWormHole: { 100. 2 }
				withAmountOfLaps: 1 ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenWormHoleIsNotAnIntThenIsInvalid [

	self
		should: [ WormHole withGates: '2' ]
		raise: Error
		withMessageText: 'The Worm Hole Position Must have at least 2 positions.'
]
