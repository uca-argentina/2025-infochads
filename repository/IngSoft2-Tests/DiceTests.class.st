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
