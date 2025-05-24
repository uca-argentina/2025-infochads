Class {
	#name : 'LoopedBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
LoopedBoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenGameStartsAndSpaceShipsHaventMadeALap [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2 }.
	aGame := Game
		         withBoardSize: 100
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1.

	aGame start.

	self assert: (aGame amountOfLapsFromSpaceShip: 1) equals: 1.
	self assert: (aGame amountOfLapsFromSpaceShip: 2) equals: 1
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenSpaceShipMakesALapTheExcessThrowIsUsedToMoveInTheNextLapWhenReturningToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2.

	aGame start.

	self assert: (aGame amountOfLapsFromSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenTheInputtedLapIsNegativeThenIsInvalid [

	self
		should: [
			Game
				withBoardSize: 10
				withSpaceShips: 2
				withDiceSet: {  }
				withWormHole: { 10. 2 }
				withAmountOfLaps: -1 ]
		raise: Error
		withMessageText: 'Laps must be a positive integer.'
]
