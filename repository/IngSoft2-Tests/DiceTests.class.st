Class {
	#name : 'DiceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTests >> testDiceCanBeCreated [

	| dice |
	dice := Dice new.
	self assert: Dice notNil
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf3SidesIsRolledThenReturnsNumberBetween1And3 [

	| dice result |
	dice := Dice withSides: 3.
	result := dice roll.
	self assert: (result between: 1 and: 3)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf4SidesIsRolledThenReturnsNumberBetween1And4 [

	| dice result |
	dice := Dice withSides: 4.
	result := dice roll.
	self assert: (result between: 1 and: 4)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf6SidesIsRolledThenReturnsNumberBetween1And6 [

	| dice result |
	dice := Dice withSides: 6.
	result := dice roll.
	self assert: (result between: 1 and: 6)
]
