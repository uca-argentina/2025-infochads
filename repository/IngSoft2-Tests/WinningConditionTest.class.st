Class {
	#name : 'WinningConditionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WinningConditionTest >> testWhenARoundHasPassedAndSpaceShip1WinsTheGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3. 9 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenAfterARoundSpaceShip1WinsGameIsOverThenInformsSpaceShip2And3Position [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 8. 3. 7. 1 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 2) equals: 4.
	self assert: (aGame positionOf: 3) equals: 8
]

{ #category : 'tests' }
WinningConditionTest >> testWhenDiceRollIsHigherThanBoardSizeThenSpaceShipMovesToTheFinishLineTheGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 12 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1HasMovedToTheEndOfThenGameIsOver [

		| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.
	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndGameIsntOverThenGameContinues [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 5 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self deny: aGame isOver
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsGameThenInformsSpaceShip1Position [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 3. 10 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1PlaysAndSpaceShip2WinsThenGameIsOver [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 3. 10 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip1WinsAndInformsSpaceShip1_2And3Positions [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 10 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 10.
	self assert: (aGame positionOf: 2) equals: 1.
	self assert: (aGame positionOf: 3) equals: 1
]

{ #category : 'tests' }
WinningConditionTest >> testWhenSpaceShip3WinsGameIsOverThenInformsSpaceShip1And2Positions [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 10 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	aGame start.

	self assert: aGame isOver.

	self assert: aGame isOver.
	self assert: (aGame positionOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 3
]
