Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'wormHole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> boardSizeMustBePositiveInteger: aBoardSize [

	aBoardSize isInteger ifFalse: [
		Error signal: 'Board Size must be a positive interger.' ]
]

{ #category : 'as yet unclassified' }
Board class >> boardSizeMustBePositiveOverZero: aBoardSize [

	aBoardSize <= 0 ifTrue: [ Error signal: 'Board Size must be over 0.' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize andWormHolePosition: aWormHolePosition [

	self boardSizeMustBePositiveInteger: aBoardSize.
	self boardSizeMustBePositiveOverZero: aBoardSize.
	^ self new
		  initializeWithSize: aBoardSize
		  andWormHolePosition: aWormHolePosition
]

{ #category : 'as yet unclassified' }
Board >> adjustPositionOf: aSpaceShip considering: totalLaps [

	self boardLimitAdjustment: aSpaceShip lap: totalLaps.
	self checkForWormHole: aSpaceShip.

	aSpaceShip updatePosition
]

{ #category : 'as yet unclassified' }
Board >> boardLimitAdjustment: aSpaceShip lap: totalLaps [
	"extract"

	(aSpaceShip getLaps = totalLaps and:
		 aSpaceShip getTemporaryPosition > boardSize) ifTrue: [
		aSpaceShip updateTemporaryPosition: boardSize.
		^ self ].
	
	aSpaceShip getTemporaryPosition > boardSize ifTrue: [
		aSpaceShip updateLap: (aSpaceShip getTemporaryPosition // boardSize).
		aSpaceShip updateTemporaryPosition: (aSpaceShip getTemporaryPosition
			- (boardSize * (aSpaceShip getTemporaryPosition // boardSize))) ].
	^ self
]

{ #category : 'accessing' }
Board >> boardSize [

	boardSize ifNil: [ Error signal: 'Board size not initialized' ].
	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aSpaceShip [

	
	aSpaceShip updateTemporaryPosition: (wormHole verifyPosition: aSpaceShip getTemporaryPosition ). "extract"

]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize andWormHolePosition: aWormHolePosition [

	wormHole := WormHole withGates: aWormHolePosition.
	wormHole mustBeWithInLimits: aBoardSize.
	boardSize := aBoardSize.
	^ self
]

{ #category : 'as yet unclassified' }
Board >> withWormHole: aWormHole [
	wormHole := WormHole withGates: aWormHole.
	wormHole wormHoleMustBeWithinLimits: boardSize.
]
