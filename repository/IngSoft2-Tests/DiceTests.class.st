Class {
	#name : 'DiceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DiceTests >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
DiceTests >> testDiceCanBeCreated [

	| dice |
	dice := Dice new.
	self assert: Dice notNil
]

{ #category : 'tests' }
DiceTests >> testWhenMultipleDicesOf6SidesAreRolledThenRetunsNumbersBetween1And6 [

	| dice1 dice2 dice3 result1 result2 result3 |
	dice1 := Dice withSides: 6.
	dice2 := Dice withSides: 6.
	dice3 := Dice withSides: 6.
	result1 := dice1 roll.
	result2 := dice2 roll.
	result3 := dice3 roll.

	self assert: (result1 between: 1 and: 6).
	self assert: (result2 between: 1 and: 6).
	self assert: (result3 between: 1 and: 6)
]

{ #category : 'tests' }
DiceTests >> testWhenMultipleDicesOfDiferentNumberOfSidesAreRolledThenRetunsNumbersBetween1AndCorrespondingNumberOfSides [

	| diceD6 diceD20 resultD6 resultD20 diceD8 resultD8 |
	diceD6 := Dice withSides: 6.
	diceD20 := Dice withSides: 20.
	diceD8 := Dice withSides: 8.
	resultD6 := diceD6 roll.
	resultD20 := diceD20 roll.
	resultD8 := diceD8 roll.

	self assert: (resultD6 between: 1 and: 6).
	self assert: (resultD20 between: 1 and: 20).
	self assert: (resultD8 between: 1 and: 8)
]

{ #category : 'tests' }
DiceTests >> testWhenOneDiceIsRolledTwiceThenReturnsTwoResultsBetween1AndNumberOfSides [

	| aDice result1 result2 numberOfSides |
	numberOfSides := 6.
	aDice := Dice withSides: numberOfSides.
	result1 := aDice roll.
	result2 := aDice roll.

	self assert: (result1 between: 1 and: numberOfSides).
	self assert: (result2 between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf20SidesIsRolledThenReturnsNumberBetween1And20 [

	| numberOfSides aDice result |
	numberOfSides := 20.
	aDice := Dice withSides: numberOfSides.
	result := aDice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf3SidesIsRolledThenReturnsNumberBetween1And3 [

	| numberOfSides aDice result |
	numberOfSides := 3.
	aDice := Dice withSides: numberOfSides.
	result := aDice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf4SidesIsRolledThenReturnsNumberBetween1And4 [

	| numberOfSides aDice result |
	numberOfSides := 4.
	aDice := Dice withSides: numberOfSides.
	result := aDice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf6SidesIsRolledThenReturnsNumberBetween1And6 [

	| numberOfSides aDice result |
	numberOfSides := 6.
	aDice := Dice withSides: numberOfSides.
	result := aDice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'errors' }
DiceTests >> testWhenTheDiceOfNegativeSidesIsRolledThenCreationFails [

	self
		should: [ Dice withSides: -1 ]
		raise: Error
		withMessageText: 'The number of sides shoud be a positive integer.'
]

{ #category : 'errors' }
DiceTests >> testWhenTheDiceOfStringNumberSidesIsRolledThenCreationFails [

	self
		should: [ Dice withSides: 'a' ]
		raise: Error
		withMessageText: 'The number of sides shoud be a positive integer.'
]

{ #category : 'tests' }
DiceTests >> testWhenTwoDicesOf6SidesAreRolledThenRetunsNumbersBetween1And6 [

	| dice1 dice2 result1 result2 |
	dice1 := Dice withSides: 6.
	dice2 := Dice withSides: 6.
	result1 := dice1 roll.
	result2 := dice2 roll.

	self assert: (result1 between: 1 and: 6).
	self assert: (result2 between: 1 and: 6)
]
