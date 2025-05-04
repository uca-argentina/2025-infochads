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
	aBoard := Board withBoardSize: boardSize.
	numberOfSides := 6.
	aDice := Dice withSides: numberOfSides.
	result := aDice roll.
	self assert: result < boardSize
]
