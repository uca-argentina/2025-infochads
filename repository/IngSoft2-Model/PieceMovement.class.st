Class {
	#name : 'PieceMovement',
	#superclass : 'Object',
	#instVars : [
		'positions',
		'piecePositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PieceMovement class >> withPieces: aNumberOfSpaceShips [
	^self new initializeWithNumberOfSpaceShips: aNumberOfSpaceShips.
]

{ #category : 'initialization' }
PieceMovement >> initializeWithNumberOfSpaceShips: aNumberOfSpaceShips [

	piecePositions := self startingPositions: aNumberOfSpaceShips.
	^ self
]

{ #category : 'as yet unclassified' }
PieceMovement >> move: aSpaceShipID thisManySteps: positionsForward [

	piecePositions
		at: aSpaceShipID
		put: (piecePositions at: aSpaceShipID) + positionsForward
]

{ #category : 'accessing' }
PieceMovement >> positions [

	^ piecePositions
]

{ #category : 'initialization' }
PieceMovement >> startingPositions: aNumberOfSpaceShips [

	| initialPositions |
	initialPositions := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :position | initialPositions add: 0 ].

	^ initialPositions
]
