Class {
	#name : 'TurnsTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
TurnsTests >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsTheOnlyPlayerThenCanPlayAlone [

	| aGame aDiceSet aBoard |
	aDiceSet := DiceSet withDices: { (Dice withSides: 6) }.

	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 10
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip1IsToPlayAndSpaceShip1PlaysThenIsValid [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 3
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip2IsToPlayAndSpaceShip2PlaysThenIsValid [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2. 3 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.
	aGame start.
	self assert: (aGame positionOf: 1) equals: 3.
	self assert: (aGame positionOf: 2) equals: 4
]

{ #category : 'tests' }
TurnsTests >> testWhenSpaceShip3IsToPlayAndSpaceShip3PlaysThenIsValid [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 1. 2. 3 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 2.
	self assert: (aGame positionOf: 2) equals: 3.
	self assert: (aGame positionOf: 3) equals: 4
]

{ #category : 'tests' }
TurnsTests >> testWhenTheFirstRoundIsPlayedThenSpaceShip1IsToPlayThenIsValid [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: { 2. 1. 3. 2 }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 1 endingAt: 1)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1
					withDeck: { }.
	aGame start.

	self assert: (aGame positionOf: 1) equals: 5.
	self assert: (aGame positionOf: 2) equals: 2.
	self assert: (aGame positionOf: 3) equals: 4
]
