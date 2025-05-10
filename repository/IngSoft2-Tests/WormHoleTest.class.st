Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnFirstWormHoleThenTeleportsToSecondWormHoleThenIsValid [

	| aGame aWormHole aDiceRoll |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 3. 7 }.
	aGame allocatedWormHole: aWormHole.
	aDiceRoll := 3.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]

{ #category : 'tests' }
WormHoleTest >> testWhenASpaceShipPlaysAndLandsOnSecondWormHoleThenTeleportsToFirstWormHoleThenIsValid [

	| aGame aWormHole aDiceRoll |
	aGame := Game withBoardSize: 10 withSpaceShips: 1.

	aWormHole := { 3. 7 }.
	aGame allocatedWormHole: aWormHole.
	aDiceRoll := 7.
	aGame moveSpaceShip: 1 numberOfPositions: aDiceRoll.

	self assert: (aGame positionOfSpaceShip: 1) equals: 3
]
