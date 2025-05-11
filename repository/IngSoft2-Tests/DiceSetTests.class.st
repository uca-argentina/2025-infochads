Class {
	#name : 'DiceSetTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceSetTests >> testWhenASackOfDicesWithOneD6AndOneD8IsTossedThenResultBetween1And14 [

	| diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).
	diceSet add: (Dice withSides: 8).
	self assert: (diceSet toss between: 1 and: 14)
]

{ #category : 'tests' }
DiceSetTests >> testWhenASackOfDicesWithOneD6IsTossedThenResultBetween1And6 [

	| diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).
	self assert: (diceSet toss between: 1 and: 6)
]

{ #category : 'tests' }
DiceSetTests >> testWhenASackOfDicesWithTwoD6IsTossedThenResultBetween1And6 [

	| diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).
	diceSet add: (Dice withSides: 6).
	self assert: (diceSet toss between: 1 and: 12)
]

{ #category : 'tests' }
DiceSetTests >> testWhenASetOfDiceWith2D6TossThenSpaceShip1MovesToPositionBetween1And12 [

	| aGame diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).
	diceSet add: (Dice withSides: 6).
	aGame := Game withBoardSize: 20 withSpaceShips: 1.

	aGame moveSpaceShip: 1 numberOfPositions: diceSet toss.

	self assert: ((aGame positionOfSpaceShip: 1) between: 1 and: 12).
]

{ #category : 'tests' }
DiceSetTests >> testWhenASetOfDiceWithAD6AndD8TossThenSpaceShip1MovesToPositionBetween1And14 [

	| aGame diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).
	diceSet add: (Dice withSides: 8).

	aGame := Game withBoardSize: 20 withSpaceShips: 1.

	aGame moveSpaceShip: 1 numberOfPositions: diceSet toss.

	self assert: ((aGame positionOfSpaceShip: 1) between: 1 and: 14).
]

{ #category : 'tests' }
DiceSetTests >> testWhenASetOfDiceWithAD6TossAfter1RoundThenSpaceShip1MovesToPositionBetween2And12 [

	| aGame diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).

	aGame := Game withBoardSize: 20 withSpaceShips: 2.

	aGame moveSpaceShip: 1 numberOfPositions: diceSet toss.
	aGame moveSpaceShip: 2 numberOfPositions: diceSet toss.
	aGame moveSpaceShip: 1 numberOfPositions: diceSet toss.
		
	self assert: ((aGame positionOfSpaceShip: 1) between: 2 and: 12).
]

{ #category : 'tests' }
DiceSetTests >> testWhenASetOfDiceWithAD6TossThenSpaceShip1MovesToPositionBetween1And6 [

	| aGame diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).

	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aGame moveSpaceShip: 1 numberOfPositions: diceSet toss.

	self assert: ((aGame positionOfSpaceShip: 1) between: 1 and: 6).
]

{ #category : 'tests' }
DiceSetTests >> testWhenASetOfDiceWithAD6TossThenSpaceShip2MovesToPositionBetween1And6 [

	| aGame diceSet |
	diceSet := DiceSet new initializeWith.
	diceSet add: (Dice withSides: 6).

	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aGame moveSpaceShip: 1 numberOfPositions: diceSet toss.

	
	self assert: ((aGame positionOfSpaceShip: 1) between: 1 and: 6).
]
