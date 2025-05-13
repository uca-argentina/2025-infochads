Class {
	#name : 'BoardAndDiceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardAndDiceTests >> testWhenDiceReturnsNumberBelowDiceSidesThenIsValid [

	| numberOfSides aDice result aBoard boardSize |
	boardSize := 10.
	aBoard := Board withSize: boardSize.
	numberOfSides := 6.
	aDice := Dice withSides: numberOfSides.
	result := aDice roll.

	self assert: result < boardSize
]

{ #category : 'tests' }
BoardAndDiceTests >> testWhenDiceRollLandsOnLastPositionThenIsValid [

	| aBoard aDiceRoll boardSize |
	boardSize := 10.
	aBoard := Board withSize: boardSize.

	aDiceRoll := 10.

	self
		assert: aDiceRoll equals: boardSize
]
