Class {
	#name : 'HyperJumpEffect',
	#superclass : 'Object',
	#instVars : [
		'parsecs',
		'parsecScale',
		'listOfJumps',
		'turn'
	],
	#classInstVars : [
		'parsecs',
		'parsecScale',
		'listOfJumps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> withParsecValue: totalParsecs totalBoardSize: totalDistance andParsecJumps: aListOfJumps [

	parsecs := totalParsecs.
	parsecScale := totalDistance / totalParsecs.
	listOfJumps := aListOfJumps
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> getPositionToMove [

	| actualTurn |
	turn > listOfJumps size
		ifTrue: [
			actualTurn := 1.
			turn := 1 ]
		ifFalse: [
			actualTurn := turn.
			turn := turn + 1 ].
	^ listOfJumps at: actualTurn
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> modify: aSpaceShip orMaybe: allSpaceShips [

	| positionToMove cells |
	positionToMove := self getPositionToMove.
	
	cells := (parsecScale*positionToMove rounded).
	
	aSpaceShip updateTemporaryPosition: (aSpaceShip getTemporaryPosition + cells)
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> withParsecValue: totalParsecs totalBoardSize: totalDistance andParsecJumps: aListOfJumps [

	parsecs := totalParsecs.
	parsecScale := totalDistance / totalParsecs.
	listOfJumps := aListOfJumps.
	turn := 1.
]
