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
SpaceShipCreationTests >> testWhenMultipleSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aGame aBoardSize aNumberOfSpaceShips |
	aBoardSize := 10.
	aNumberOfSpaceShips := 3.
	aGame := Game withBoardSize: aBoardSize withSpaceShips: aNumberOfSpaceShips.
	self assert: (aGame positionOfSpaceShip: 3) equals: 0.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0.
	self assert: (aGame positionOfSpaceShip: 1) equals: 0
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsAStringThenCreationFails [

		self
		should: [ Game withBoardSize: 13 withSpaceShips: '10']
		raise: Error
		withMessageText: 'The number of space ships should be a positive integer.'

]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsCeroThenCreationFails [

		self
		should: [ Game withBoardSize: 13 withSpaceShips: 0 ]
		raise: Error
		withMessageText: 'The number of space ships must be at least 1.'

]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenNumberOfSpaceShipsIsNegativeThenCreationFails [

		self
		should: [ Game withBoardSize: 13 withSpaceShips: -1 ]
		raise: Error
		withMessageText: 'The number of space ships should be a positive integer.'

]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenOneSpaceShipIsCreatedThenTheInitialPositionIs0 [

	| aGame |
	aGame := Game withBoardSize: 13 withSpaceShips: 1.
	self assert: (aGame positionOfSpaceShip:1)  equals: 0
]

{ #category : 'tests' }
SpaceShipCreationTests >> testWhenTwoSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aGame |
	aGame := Game withBoardSize: 13 withSpaceShips: 2.
	self assert: (aGame positionOfSpaceShip: 2) equals: 0.
	self assert: (aGame positionOfSpaceShip: 1) equals: 0.
]
