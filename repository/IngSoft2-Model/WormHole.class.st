Class {
	#name : 'WormHole',
	#superclass : 'Object',
	#instVars : [
		'wormHolePositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHole class >> withGates: aWormHolePositions [

	aWormHolePositions ifNotEmpty: [
		self wormHoleExitMustBePositiveInteger: aWormHolePositions first.
		self wormHoleExitMustBePositiveInteger: aWormHolePositions second.
		self wormHoleExitMustNotBeEntry: aWormHolePositions ].

	^ self new intializeWithGates: aWormHolePositions
]

{ #category : 'as yet unclassified' }
WormHole class >> wormHoleExitMustBePositiveInteger: aWormHoleExit [

	aWormHoleExit isInteger ifFalse: [
		Error signal: 'WormHole must be a pair of integers.' ]
]

{ #category : 'as yet unclassified' }
WormHole class >> wormHoleExitMustNotBeEntry: aWormHole [

	aWormHole first = aWormHole second ifTrue: [
		Error signal: 'The WormHole Entry cannot be the exit.' ]
]

{ #category : 'as yet unclassified' }
WormHole >> intializeWithGates: aWormHolePositions [

	wormHolePositions := aWormHolePositions
]

{ #category : 'as yet unclassified' }
WormHole >> verifyPosition: aPosition [

	wormHolePositions ifNotEmpty: [
		(wormHolePositions anySatisfy: [ :aHole | aHole = aPosition ])
			ifTrue: [ ^ (wormHolePositions copyWithout: aPosition) first ] ].

	^ aPosition
]
