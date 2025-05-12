Class {
	#name : 'RacePosition',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'nextSpaceShipToMove'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RacePosition class >> numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips [

	aNumberOfSpaceShips <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
RacePosition class >> numberOfSpaceShipsMustBePositiveInteger: boardSize [

	(boardSize isInteger not or: [ boardSize negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
RacePosition class >> withPieces: aNumberOfSpaceShips [

	self numberOfSpaceShipsMustBePositiveInteger: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.
	^ self new initializeWithNumberOfSpaceShips: aNumberOfSpaceShips
]

{ #category : 'as yet unclassified' }
RacePosition >> getWinner: aFinishLine [
	
	^spaceShips indexOf: aFinishLine
]

{ #category : 'initialization' }
RacePosition >> initializeWithNumberOfSpaceShips: aNumberOfSpaceShips [

	spaceShips := self startingPositions: aNumberOfSpaceShips.
	nextSpaceShipToMove := 1.
	^ self
]

{ #category : 'testing' }
RacePosition >> isAtFinishLine: finishLine [

	^ spaceShips anySatisfy: [ :aShip | aShip = finishLine ]
]

{ #category : 'as yet unclassified' }
RacePosition >> move: aSpaceShipID toPosition: newPosition [

	spaceShips at: aSpaceShipID put: newPosition
]

{ #category : 'accessing' }
RacePosition >> positions [

	^ spaceShips
]

{ #category : 'as yet unclassified' }
RacePosition >> spaceShipToMove: spaceShipID [

	spaceShipID ~= nextSpaceShipToMove ifTrue: [
		Error signal:
			'Its space ship ' , nextSpaceShipToMove asString , ' turn to move.' ].
	self updateNextShipToMove: spaceShipID
]

{ #category : 'initialization' }
RacePosition >> startingPositions: aNumberOfSpaceShips [

	| initialPositions |
	initialPositions := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :position | initialPositions add: 0 ].

	^ initialPositions
]

{ #category : 'as yet unclassified' }
RacePosition >> updateNextShipToMove: spaceShipID [

	nextSpaceShipToMove := spaceShipID + 1.
	nextSpaceShipToMove > spaceShips size ifTrue: [
		nextSpaceShipToMove := 1 ]
]

{ #category : 'as yet unclassified' }
RacePosition >> validateID: spaceShipID [

	(spaceShipID < 1 or: [ spaceShipID > spaceShips size ]) ifTrue: [
		Error signal:
			'Invalid spaceship ID. There are only ' , spaceShips size asString
			, ' spaceships.' ]
]

{ #category : 'as yet unclassified' }
RacePosition >> withID: aSpaceShipID wouldMoveForward: positionsToSum [

	self validateID: aSpaceShipID.
	self spaceShipToMove: aSpaceShipID.

	^ (spaceShips at: aSpaceShipID) + positionsToSum
]
