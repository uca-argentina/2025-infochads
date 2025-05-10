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
Board class >> boardSizeMustBePositiveInteger: boardSize [

	(boardSize isInteger not or: [ boardSize negative ]) ifTrue: [
		Error signal: 'Board Size must be a positive interger' ]
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aBoardSize [

	self boardSizeMustBePositiveInteger: aBoardSize.

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

{ #category : 'path commands' }
Board >> moveTo: newPosition [

	| aNewPosition |
	aNewPosition := self boardLimitAdjustment: newPosition.
	aNewPosition := self checkForWormHole: aNewPosition .
	^ aNewPosition
]

{ #category : 'as yet unclassified' }
Board >> placeWormHole: aWormHole [ 
	| entry exit |
	
	entry := aWormHole first.
	exit := aWormHole second.
	
	entry >= exit ifTrue: [ 
		self error: 'First WormHole should be lower than second one.' ].
	
	exit > boardSize ifTrue: [
		self error: 'WormHole exit must be within board limits.'
	].
	
	wormHole := aWormHole.
	
]
