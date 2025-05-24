Class {
	#name : 'SpaceShipCreationTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpaceShipCreationTests >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenMultipleSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 3
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	self assert: (aGame positionOfSpaceShip: 3) equals: 0.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0.
	self assert: (aGame positionOfSpaceShip: 1) equals: 0
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsAStringThenCreationFails [

	| aDiceSet |
	aDiceSet := RiggedDice new initializeWith: {  }.
	self
		should: [
			Game
				withBoardSize: 10
				withSpaceShips: '3'
				withDiceSet: aDiceSet
				withWormHole: {  }
				withAmountOfLaps: 1 ]
		raise: Error
		withMessageText:
		'The number of space ships should be a positive integer.'
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsCeroThenCreationFails [

	| aDiceSet |
	aDiceSet := RiggedDice new initializeWith: {  }.
	self
		should: [
			Game
				withBoardSize: 10
				withSpaceShips: 0
				withDiceSet: aDiceSet
				withWormHole: {  }
				withAmountOfLaps: 1 ]
		raise: Error
		withMessageText: 'The number of space ships must be at least 1.'
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsNegativeThenCreationFails [

	| aDiceSet |
	aDiceSet := RiggedDice new initializeWith: {  }.
	self
		should: [
			Game
				withBoardSize: 10
				withSpaceShips: -1
				withDiceSet: aDiceSet
				withWormHole: {  }
				withAmountOfLaps: 1 ]
		raise: Error
		withMessageText:
		'The number of space ships should be a positive integer.'
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenOneSpaceShipIsCreatedThenTheInitialPositionIs0 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	self assert: (aGame positionOfSpaceShip: 1) equals: 0
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenTwoSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
					withAmountOfLaps: 1.

	self assert: (aGame positionOfSpaceShip: 2) equals: 0.
	self assert: (aGame positionOfSpaceShip: 1) equals: 0
]
