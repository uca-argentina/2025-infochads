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

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 3 endingAt: 7)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnSecondWormHoleThenTeleportsToFirstWormHoleThenIsValid [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 6 }.

	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 3 endingAt: 7)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryHoleIs1ThenIsInvalid [

	self
		should: [ WormHole startingAt: 1 endingAt: 7 ]
		raise: Error
		withMessageText: 'WormHole must be a pair of integers.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryHoleIsNegativeThenIsInvalid [

	self
		should: [ WormHole startingAt: -1 endingAt: 7 ]
		raise: Error
		withMessageText: 'WormHole must be a pair of integers.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenEntryWormHoleIsEqualsToExitWormHoleThenIsInvalid [

	self
		should: [ WormHole startingAt: 7 endingAt: 7 ]
		raise: Error
		withMessageText: 'The WormHole Entry cannot be the exit.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsEqualToBoardSizeThenIsInvalid [

	self
		should: [
			Board
				withSize: 100
				composedOf: (WormHole startingAt: 100 endingAt: 4)
				andACellConfiguration: {  } ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenExitHoleIsHigherThanABoardSizeThenIsInvalid [

	self
		should: [
			Board
				withSize: 100
				composedOf: (WormHole startingAt: 1000 endingAt: 4)
				andACellConfiguration: {  } ]
		raise: Error
		withMessageText: 'WormHole exit must be within board limits.'
]

{ #category : 'tests' }
WormHoleTest >> testWhenWormHoleIsNotAnIntThenIsInvalid [

	self
		should: [ WormHole startingAt: 4 endingAt: '7' ]
		raise: Error
		withMessageText: 'WormHole must be a pair of integers.'
]
