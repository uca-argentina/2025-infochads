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

	| dice1 dice2 result1 result2 |
	dice1 := Dice withSides: 6.
	dice2 := Dice withSides: 6.
	result1 := dice1 roll.
	result2 := dice2 roll.

	self assert: (result1 between: 1 and: 6).
	self assert: (result2 between: 1 and: 6)
]

{ #category : 'tests' }
DiceTests >> testWhenMultipleDicesOfDiferentNumberOfSidesAreRolledThenRetunsNumbersBetween1And6 [

	| diceD6 diceD20 resultD6 resultD20 |
	diceD6 := Dice withSides: 6.
	diceD20 := Dice withSides: 20.
	resultD6 := diceD6 roll.
	resultD20 := diceD20 roll.

	self assert: (resultD6 between: 1 and: 6).
	self assert: (resultD20 between: 1 and: 20)
]

{ #category : 'tests' }
DiceTests >> testWhenOneDiceIsRolledTwiceThenReturnsTwoResultsBetween1AndNumberOfSides [

	| dice result1 result2 numberOfSides |
	numberOfSides := 6.
	dice := Dice withSides: numberOfSides.
	result1 := dice roll.
	result2 := dice roll.

	self assert: (result1 between: 1 and: numberOfSides).
	self assert: (result2 between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf20SidesIsRolledThenReturnsNumberBetween1And20 [

	|numberOfSides dice result |
	numberOfSides := 20.
	dice := Dice withSides: numberOfSides.
	result := dice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf3SidesIsRolledThenReturnsNumberBetween1And3 [

	| numberOfSides dice result |
	numberOfSides := 3.
	dice := Dice withSides: numberOfSides.
	result := dice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf4SidesIsRolledThenReturnsNumberBetween1And4 [

	| numberOfSides dice result |
	numberOfSides := 4.
	dice := Dice withSides: numberOfSides.
	result := dice roll.
	self assert: (result between: 1 and: numberOfSides)
]

{ #category : 'tests' }
DiceTests >> testWhenTheDiceOf6SidesIsRolledThenReturnsNumberBetween1And6 [

	|numberOfSides dice result |
	numberOfSides := 6.
	dice := Dice withSides: numberOfSides.
	result := dice roll.
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
