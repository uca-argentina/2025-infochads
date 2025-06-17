Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'position',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Position class >> at: aPlaceInSpace withLaps: aNumberOfLaps [

	self mustBePositive: aPlaceInSpace.

	^ self new initializeWith: aPlaceInSpace  andLaps: aNumberOfLaps
]

{ #category : 'as yet unclassified' }
Position class >> mustBePositive: aPlaceInSpace [

	(aPlaceInSpace isInteger and: [ aPlaceInSpace >= 1 ]) ifFalse: [
		Error signal: 'The position must be positive' ]
]

{ #category : 'initialization' }
Position >> initializeWith: aPlaceInSpace andLaps: aNumberOfLaps [

	position := aPlaceInSpace.
	lap := 0.
]

{ #category : 'accessing' }
Position >> lap [

	^ lap
]

{ #category : 'as yet unclassified' }
Position >> migrateTo: aNewPosition [

	position := aNewPosition position.
	position := aNewPosition lap
]

{ #category : 'as yet unclassified' }
Position >> migrateToLap: aNewLap [
	lap := aNewLap
]

{ #category : 'as yet unclassified' }
Position >> migrateToPosition: aNewPosition [

	position := aNewPosition
]

{ #category : 'as yet unclassified' }
Position >> sumTo: aPosition [

	position := position + aPosition position.
	lap := lap + aPosition lap
]

{ #category : 'as yet unclassified' }
Position >> toBeginningOfLap [
	position := 1.
]
