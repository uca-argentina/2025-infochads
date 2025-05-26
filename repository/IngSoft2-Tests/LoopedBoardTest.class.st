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
LoopedBoardTest >> testWhenASpaceShipGetsToTheEndMadeTheMaxLapsFromGameThenIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 1) equals: 11.
	self assert: aGame isOver
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
		         withAmountOfLaps: 1
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 0.
	self assert: (aGame inWhichLapIsSpaceShip: 2) equals: 0
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndExceedsTheEndOfBoardInFinalLapUsingMultipleThrowsThenGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 3. 10}.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10.
	self assert: aGame isOver 
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndExceedsTheEndOfBoardInFinalLapUsingSingleThrowThenGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 30}.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10.
	self assert: aGame isOver 
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndGetToTheEndOfLap2UsingASingleThrowThenGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 19 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10.
	self assert: aGame isOver 
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndGetToTheEndOfLap2UsingMultipleThrowsThenGameIsOver [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 3. 9}.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 2.
	self assert: (aGame positionOfSpaceShip: 1) equals: 10.
	self assert: aGame isOver 
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenSpaceShipMakesALapTheExcessThrowIsUsedToMoveInTheNextLapWhenReturningToStart [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 7 }.
	aGame := Game
		         withBoardSize: 11
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }
		         withAmountOfLaps: 2
					withCellConfigurations: { }.

	aGame start.

	self assert: (aGame inWhichLapIsSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 1) equals: 2.
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
				withAmountOfLaps: -1
				withCellConfigurations: {  } ]
		raise: Error
		withMessageText: 'Laps must be a positive integer.'
]
