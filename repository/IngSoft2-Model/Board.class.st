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
Board class >> withSize: aBoardSize [

	self boardSizeMustBePositiveInteger: aBoardSize.
	self boardSizeMustBePositiveOverZero: aBoardSize.

	^ self new initializeWithSize: aBoardSize
]

{ #category : 'as yet unclassified' }
Board >> boardLimitAdjustment: newPosition [

	| aPosition |
	aPosition := newPosition.
	newPosition > boardSize ifTrue: [ aPosition := boardSize ].
	^ aPosition
]

{ #category : 'accessing' }
Board >> boardSize [

	boardSize ifNil: [ Error signal: 'Board size not initialized' ].
	^ boardSize
]

{ #category : 'as yet unclassified' }
Board >> checkForWormHole: aPosition [

	| aNewPosition |
	aNewPosition := aPosition.

	(wormHole anySatisfy: [ :aHole | aHole = aPosition ]) ifTrue: [
		aNewPosition := (wormHole copyWithout: aPosition) first ].

	^ aNewPosition
]

{ #category : 'initialization' }
Board >> initializeWithSize: aBoardSize [

	boardSize := aBoardSize.
	wormHole := #(  ).
	^ self
]

{ #category : 'as yet unclassified' }
Board >> placeWormHole: aWormHole [

	self wormHoleExitMustBePositiveInteger: aWormHole first.
	self wormHoleExitMustBePositiveInteger: aWormHole second.

	self wormHoleMustBeWithinLimits: aWormHole.
	self wormHoleExitMustNotBeEntry: aWormHole.

	wormHole := aWormHole
]

{ #category : 'path commands' }
Board >> spaceShipWillMoveTo: posibleNextPosition [

	| aNewPosition |
	aNewPosition := self boardLimitAdjustment: posibleNextPosition.
	aNewPosition := self checkForWormHole: aNewPosition.
	^ aNewPosition
]

{ #category : 'as yet unclassified' }
Board >> wormHoleExitMustBePositiveInteger: aWormHoleExit [

	aWormHoleExit isInteger ifFalse: [
		Error signal: 'WormHole must be a pair of integers.' ]
]

{ #category : 'as yet unclassified' }
Board >> wormHoleExitMustNotBeEntry: aWormHole [

	aWormHole first = aWormHole second ifTrue: [
		Error signal: 'The WormHole Entry cannot be the exit.' ]
]

{ #category : 'as yet unclassified' }
Board >> wormHoleMustBeWithinLimits: aWormHole [

	(aWormHole anySatisfy: [ :hole | hole >= boardSize or: hole <= 0 ])
		ifTrue: [ self error: 'WormHole exit must be within board limits.' ]
]
