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

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 6 }.
	aBoard := Board
		          withSize: 11
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	aGame start.

	self assert: (aGame lapOf: 1) equals: 1.
	self assert: (aGame positionOf: 1) equals: 11.
	self assert: aGame isOver
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenGameStartsAndSpaceShipsHaventMadeALap [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 2 }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.

	aGame start.

	self assert: (aGame lapOf: 1) equals: 0.
	self assert: (aGame lapOf: 2) equals: 0
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndExceedsTheEndOfBoardInFinalLapUsingMultipleThrowsThenGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 3. 10 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2
					withDeck: { }.

	aGame start.

	self assert: (aGame lapOf: 1) equals: 2.
	self assert: (aGame positionOf: 1) equals: 10.
	self assert: aGame isOver
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndExceedsTheEndOfBoardInFinalLapUsingSingleThrowThenGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 30 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2
					withDeck: { }.

	aGame start.

	self assert: (aGame lapOf: 1) equals: 2.
	self assert: (aGame positionOf: 1) equals: 10.
	self assert: aGame isOver
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndGetToTheEndOfLap2UsingASingleThrowThenGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 19 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2
					withDeck: { }.
	aGame start.

	self assert: (aGame lapOf: 1) equals: 2.
	self assert: (aGame positionOf: 1) equals: 10.
	self assert: aGame isOver
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenShip1MakesALapAndGetToTheEndOfLap2UsingMultipleThrowsThenGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 1. 5. 3. 9 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 2
					withDeck: { }.

	aGame start.

	self assert: (aGame lapOf: 1) equals: 2.
	self assert: (aGame positionOf: 1) equals: 10.
	self assert: aGame isOver
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenSpaceShipMakesALapTheExcessThrowIsUsedToMoveInTheNextLapWhenReturningToStart [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5. 2. 7 }.
	aBoard := Board
		          withSize: 11
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
		aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 2
					withDeck: { }.

	aGame start.

	self assert: (aGame lapOf: 1) equals: 1.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
LoopedBoardTest >> testWhenTheInputtedLapIsNegativeThenIsInvalid [

	| aBoard aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 0. }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	self
		should: [
			 	Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: -1
					withDeck: { }. ]
		raise: Error
		withMessageText: 'Laps must be a positive integer.'
]
