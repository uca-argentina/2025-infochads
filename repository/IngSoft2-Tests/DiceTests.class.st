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
DiceTests >> testWhenTheDiceIsRolledThenTheNumberExpectedIsBetween1And6 [

	| dice result |
	dice := Dice new.
	result := dice roll.
	self assert: (result between: 1 and: 6)
]
