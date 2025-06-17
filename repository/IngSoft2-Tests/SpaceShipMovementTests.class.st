Class {
	#name : 'SpaceShipMovementTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpaceShipMovementTests >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
	
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenARiggedDiceToss6ThenShipMovesTo7 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 6 }.
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

	self assert: (aGame positionOf: 1) equals: 7
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRolls5ThenMovesSpaceShipToPosition6 [

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

	self assert: (aGame positionOf: 1) equals: 6
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenRiggedDiceToss1_2ThenShip1MovesTo4 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 2 }.
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

	self assert: (aGame positionOf: 1) equals: 4
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenRiggedDiceToss1_2_3ThenShip1MovesTo7 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3 }.
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

	self assert: (aGame positionOf: 1) equals: 7
]
