Class {
	#name : 'SpaceShipTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceShipTests >> testWhenMultipleSpaceShipsAreCreatedThenTheInitialPositionsAre0 [

	| aBoard |
	aBoard := Board withSize: 13 withNumberOfSpaceShips: 3.
	self assert: (aBoard positionOfSpaceShip: 3) equals: 0.
	self assert: (aBoard positionOfSpaceShip: 2) equals: 0.
	self assert: (aBoard positionOfSpaceShip: 1) equals: 0
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
