Class {
	#name : 'GameTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTests >> testWhen [

	| aGame boardSize numberOfSpaceShips aDiceSet aWormHole |
	boardSize := 10.
	aDiceSet := RiggedDice new initializeWith: { 2. }.
	aWormHole := {}.
	numberOfSpaceShips := 2.
	aGame := Game
		         withBoardSize: boardSize
		         withSpaceShips: numberOfSpaceShips
		         withDiceSet: aDiceSet
		         withWormHole: aWormHole.

	aGame start.

	self assert: (aGame positionOfSpaceShip: 1) equals: 7
]
