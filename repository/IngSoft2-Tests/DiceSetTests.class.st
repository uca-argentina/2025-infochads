Class {
	#name : 'DiceSetTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceSetTests >> testWhenADiceSetIsRiggedWithNextMovementAs1ThenTheNextMovementIs1 [

	| diceSet movement |

	diceSet := RiggedDice new initializeWith: {1}.
	movement := diceSet toss.
	self assert: movement equals: 1
]

{ #category : 'tests' }
DiceSetTests >> testWhenARiggedDiceWithNextMovements1And2ThenThoseAreTheNextMovements [

	| diceSet movement1  movement2 |
	
	diceSet := RiggedDice new initializeWith: {1. 2}.
	movement1 := diceSet toss.
	movement2 := diceSet toss.
	self assert: movement1 equals: 1.
	self assert: movement2 equals: 2
]

{ #category : 'tests' }
DiceSetTests >> testWhenASackOfDicesWithOneD6AndOneD8IsTossedThenResultBetween1And14 [

	| diceSet |
	diceSet := DiceSet withDices: {
			           (Dice withSides: 6).
			           (Dice withSides: 8) }.
	self assert: (diceSet toss between: 1 and: 14)
]

{ #category : 'tests' }
DiceSetTests >> testWhenASackOfDicesWithOneD6IsTossedThenResultBetween1And6 [

	| diceSet |
	diceSet := DiceSet withDices: { (Dice withSides: 6) }.
	self assert: (diceSet toss between: 1 and: 6)
]

{ #category : 'tests' }
DiceSetTests >> testWhenASackOfDicesWithTwoD6IsTossedThenResultBetween1And6 [

	| diceSet |
	diceSet := DiceSet withDices: {
			           (Dice withSides: 6).
			           (Dice withSides: 6) }.

	self assert: (diceSet toss between: 1 and: 12)
]

{ #category : 'tests' }
DiceSetTests >> testWhenRiggedDiceWithNumberOfMovementsThenTheyWillBeMoved [

	| diceSet aSetOfMovements movement1 movement2 movement3 |
	aSetOfMovements := OrderedCollection withAll: #( 1 2 3 ).
	diceSet := RiggedDice new initializeWith: aSetOfMovements.
	movement1 := diceSet toss.
	movement2 := diceSet toss.
	movement3 := diceSet toss.
	self assert: movement1 equals: 1.
	self assert: movement2 equals: 2.
	self assert: movement3 equals: 3
]
