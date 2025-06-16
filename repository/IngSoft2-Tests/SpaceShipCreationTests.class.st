Class {
	#name : 'SpaceShipCreationTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpaceShipCreationTests >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenMultipleSpaceShipsAreCreatedThenTheInitialPositionsAre1 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 3
		         throwing: aDiceSet
		         wonAfter: 1.

	self assert: (aGame positionOfSpaceShip: 3) equals: 1.
	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 1) equals: 1
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsAStringThenCreationFails [

	| aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	self
		should: [
			Game
				playedIn: aBoard
				by: '3'
				throwing: aDiceSet
				wonAfter: 1 ]
		raise: Error
		withMessageText:
		'The number of space ships should be a positive integer.'
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsCeroThenCreationFails [

	| aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	self
		should: [
			Game
				playedIn: aBoard
				by: 0
				throwing: aDiceSet
				wonAfter: 1 ]
		raise: Error
		withMessageText: 'The number of space ships must be at least 1.'
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsNegativeThenCreationFails [

	| aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aBoard := Board
		          withSize: 100
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	self
		should: [
			Game
				playedIn: aBoard
				by: -1
				throwing: aDiceSet
				wonAfter: 1 ]
		raise: Error
		withMessageText:
		'The number of space ships should be a positive integer.'
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenOneSpaceShipIsCreatedThenTheInitialPositionIs1 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 1
		         throwing: aDiceSet
		         wonAfter: 1.

	self assert: (aGame positionOfSpaceShip: 1) equals: 1
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenTwoSpaceShipsAreCreatedThenTheInitialPositionsAre1 [

	| aGame aDiceSet aBoard |
	aDiceSet := RiggedDice new initializeWith: {  }.
	aBoard := Board
		          withSize: 10
		          composedOf: (WormHole startingAt: 0 endingAt: 0)
		          andACellConfiguration: {  }.
	aGame := Game
		         playedIn: aBoard
		         by: 2
		         throwing: aDiceSet
		         wonAfter: 1.

	self assert: (aGame positionOfSpaceShip: 2) equals: 1.
	self assert: (aGame positionOfSpaceShip: 1) equals: 1
]
