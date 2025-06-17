Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Position class >> at: aPlaceInSpace [

	self mustBePositive: aPlaceInSpace.

	^ self new initializeWith: aPlaceInSpace
]

{ #category : 'as yet unclassified' }
Position class >> mustBePositive: aPlaceInSpace [

	(aPlaceInSpace isInteger and: [ aPlaceInSpace >= 1 ]) ifFalse: [
		Error signal: 'The position must be positive' ]
]

{ #category : 'initialization' }
Position >> initializeWith: aPlaceInSpace [

	position := aPlaceInSpace
]
