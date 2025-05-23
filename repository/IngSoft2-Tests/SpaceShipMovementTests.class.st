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
SpaceShipMovementTests >> testWhenASetOfDiceWithAD6AndD8TossThenSpaceShip1MovesToPositionBetween1And14 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 6 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 6
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDice1Rolls1AndDice2Rolls1ThenMoveSpaceShip1And2ToPosition1 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 1 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 2
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDice1Rolls1AndDice2Rolls2AndDice3Rolls3ThenMoveSpaceShipToPosition6 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 6
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDice1Rolls1AndDice2Rolls2ThenMoveSpaceShipToPosition3 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 1. 2 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]

{ #category : 'tests' }
SpaceShipMovementTests >> testWhenDiceRolls5ThenMovesSpaceShipToPosition5 [

	| aGame aDiceSet |
	aDiceSet := RiggedDice new initializeWith: { 5 }.
	aGame := Game
		         withBoardSize: 10
		         withSpaceShips: 1
		         withDiceSet: aDiceSet
		         withWormHole: {  }.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 5
]
