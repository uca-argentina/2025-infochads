Class {
	#name : 'SpaceShipTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SpaceShipTests >> should: anError raise: anErrorClass withMessageText: anErrorMessage [ 
	 self
        should: anError 
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                anErrorMessage ]

]

{ #category : 'tests' }
SpaceShipTests >> testWhenMultipleSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aBoard |
	aBoard := Board withSize: 13 withNumberOfSpaceShips: 3.
	self assert: (aBoard positionOfSpaceShip: 3) equals: 0.
	self assert: (aBoard positionOfSpaceShip: 2) equals: 0.
	self assert: (aBoard positionOfSpaceShip: 1) equals: 0
]

{ #category : 'tests' }
SpaceShipTests >> testWhenNumberOfSpaceShipsIsAStringThenCreationFails [

		self
		should: [ Board withSize: 13 withNumberOfSpaceShips: '10' ]
		raise: Error
		withMessageText: 'The number of space ships should be a positive integer.'

]

{ #category : 'tests' }
SpaceShipTests >> testWhenNumberOfSpaceShipsIsCeroThenCreationFails [

		self
		should: [ Board withSize: 13 withNumberOfSpaceShips: 0 ]
		raise: Error
		withMessageText: 'The number of space ships must be at least 1.'

]

{ #category : 'tests' }
SpaceShipTests >> testWhenNumberOfSpaceShipsIsNegativeThenCreationFails [

		self
		should: [ Board withSize: 13 withNumberOfSpaceShips: -1 ]
		raise: Error
		withMessageText: 'The number of space ships should be a positive integer.'

]

{ #category : 'tests' }
SpaceShipTests >> testWhenOneSpaceShipIsCreatedThenTheInitialPositionIs0 [

	| aBoard |
	aBoard := Board withSize: 13 withNumberOfSpaceShips: 1.
	self assert: (aBoard positionOfSpaceShip:1)  equals: 0
]

{ #category : 'tests' }
SpaceShipTests >> testWhenTwoSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aBoard |
	aBoard := Board withSize: 13 withNumberOfSpaceShips: 2.
	self assert: (aBoard positionOfSpaceShip: 2) equals: 0.
	self assert: (aBoard positionOfSpaceShip: 1) equals: 0.
]
