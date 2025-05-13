Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'aBoard',
		'spaceShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> withBoardSize: aBoardSize withSpaceShips: aNumberOfSpaceShips [

	^ self new
		  initializeWithBoardSize: aBoardSize
		  andNumberOfSpaceShips: aNumberOfSpaceShips
]

{ #category : 'as yet unclassified' }
Game >> checkForWinner [

	self isGameOver ifTrue: [
		Error signal:
			'Space ship ' , (spaceShips getWinner: aBoard boardSize) asString , ' has already won.' ]
]

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoardSize andNumberOfSpaceShips: aNumberOfSpaceShips [

	aBoard := Board withSize: aBoardSize.
	spaceShips := RacePosition withPieces: aNumberOfSpaceShips.
	^ self
]

{ #category : 'testing' }
Game >> isGameOver [

	^ spaceShips isAtFinishLine: aBoard boardSize
]

{ #category : 'testing' }
Game >> isOver [
	^ self isGameOver 
]

{ #category : 'as yet unclassified' }
Game >> moveSpaceShip: aSpaceShipID numberOfPositions: positionsToSum [

	| posibleNextPosition realNextPosition |
	self checkForWinner.
	posibleNextPosition := spaceShips
		                       withID: aSpaceShipID
		                       wouldMoveForward: positionsToSum.
	realNextPosition := aBoard spaceShipWillMoveTo: posibleNextPosition.

	spaceShips move: aSpaceShipID toPosition: realNextPosition
]

{ #category : 'as yet unclassified' }
Game >> placeWormHole: aWormHole [
	
	aBoard placeWormHole: aWormHole . 
]

{ #category : 'as yet unclassified' }
Game >> positionOfSpaceShip: aSpaceShipID [

	^ spaceShips positions at: aSpaceShipID
]
