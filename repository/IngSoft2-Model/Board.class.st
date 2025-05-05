Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'spaceShipPositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> boardSizeMustBePositiveInteger: boardSize [

	(boardSize isInteger not or: [ boardSize negative ]) ifTrue: [
		Error signal: 'Board Size must be a positive interger' ]
]

{ #category : 'as yet unclassified' }
Board class >> numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips [

	aNumberOfSpaceShips <= 0 ifTrue: [
		Error signal: 'The number of space ships must be at least 1.' ]
]

{ #category : 'as yet unclassified' }
Board class >> numberOfSpaceShipsMustBePositiveInteger: boardSize [

	(boardSize isInteger not or: [ boardSize negative ]) ifTrue: [
		Error signal:
			'The number of space ships should be a positive integer.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize withNumberOfSpaceShips: aNumberOfSpaceShips [

	self boardSizeMustBePositiveInteger: aBoardSize.
	self numberOfSpaceShipsMustBePositiveInteger: aNumberOfSpaceShips.
	self numberOfSpaceShipsMustBeAtLeastOne: aNumberOfSpaceShips.

	^ self new
		  initializeWithSize: aBoardSize
		  andNumberOfSpaceShips: aNumberOfSpaceShips
]

{ #category : 'accessing' }
Board >> boardSize [
	boardSize ifNil:[Error signal: 'Board size not initialized'].
	^ boardSize
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize andNumberOfSpaceShips: aNumberOfSpaceShips [

	spaceShipPositions := self startingPositions: aNumberOfSpaceShips.
	boardSize := aBoardSize.
	^ self
]

{ #category : 'path commands' }
Board >> positionAnalize: aPosition [

	aPosition > boardSize ifTrue: [
		Error signal: 'Dice roll should be below or equals board size.' ].
	^ true
]

{ #category : 'as yet unclassified' }
Board >> positionOfSpaceShip: numberOfSpaceShip [

	^ spaceShipPositions at: numberOfSpaceShip
]

{ #category : 'initialization' }
Board >> startingPositions: aNumberOfSpaceShips [

	| initialPositions |
	initialPositions := OrderedCollection new.
	1 to: aNumberOfSpaceShips do: [ :position |
	initialPositions add: 0 ].

	^ initialPositions
]
