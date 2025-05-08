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

{ #category : 'initialization' }
Game >> initializeWithBoardSize: aBoardSize andNumberOfSpaceShips: aNumberOfSpaceShips [

	aBoard := Board withSize: aBoardSize.
	spaceShips := RacePosition withPieces: aNumberOfSpaceShips.
	^ self
]

{ #category : 'as yet unclassified' }
Game >> moveSpaceShip: aSpaceShipID numberOfPositions: positionToMove [

	| posiblePosition realPosition |
	posiblePosition := spaceShips
		                   withID: aSpaceShipID
		                   createPositionPosition: positionToMove.
	realPosition := aBoard moveTo: posiblePosition.
	spaceShips move: aSpaceShipID toPosition: realPosition
]

{ #category : 'as yet unclassified' }
Game >> positionOfSpaceShip: aSpaceShipID [

	^ spaceShips positions at: aSpaceShipID
]
