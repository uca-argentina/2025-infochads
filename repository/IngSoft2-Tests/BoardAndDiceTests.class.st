Class {
	#name : 'BoardAndDiceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardAndDiceTests >> should: anError raise: anErrorClass withMessageText: anErrorMessage [ 
	 self
        should: anError 
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                anErrorMessage ]
]

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

{ #category : 'tests' }
BoardAndDiceTests >> testWhenDiceRollExceedBoardSizeThenIsNotValid [

	| aBoard aDiceRoll boardSize |
	boardSize := 10.
	aBoard := Board withBoardSize: boardSize.

	aDiceRoll := 12.

	self
		should: [ aBoard positionAnalize: aDiceRoll ]
		raise: Error
		withMessageText: 'Dice roll should be below or equals board size.' 
]

{ #category : 'tests' }
BoardAndDiceTests >> testWhenDiceRollLandsOnLastPositionThenIsValid [

	| aBoard aDiceRoll boardSize |
	boardSize := 10.
	aBoard := Board withBoardSize: boardSize.

	aDiceRoll := 10.

	self
		assert: aDiceRoll equals: boardSize
]
