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


	^ self new initializeWith: aPlaceInSpace  andLaps: aNumberOfLaps
]

{ #category : 'initialization' }
Position >> initializeWith: aPlaceInSpace andLaps: aNumberOfLaps [

	position := aPlaceInSpace.
	lap := aNumberOfLaps.
]

{ #category : 'testing' }
Position >> isEqualTo: aPosition [

	^ position = aPosition position and: lap = aPosition lap
]

{ #category : 'testing' }
Position >> isPositionEqualTo: aPosition [

	^ position = aPosition position
]

{ #category : 'accessing' }
Position >> lap [

	^ lap
]

{ #category : 'accessing' }
Position >> position [

	^ position
]

{ #category : 'as yet unclassified' }
Position >> replacePositionWith: aPosition [

	^ self class at: aPosition position withLaps: lap
]

{ #category : 'as yet unclassified' }
Position >> sumPositionTo: aPosition [

	^ self class at: aPosition position withLaps: lap
]

{ #category : 'as yet unclassified' }
Position >> sumTo: aPosition [

	^ self class
		  at: position + aPosition position
		  withLaps: lap + aPosition lap
]
