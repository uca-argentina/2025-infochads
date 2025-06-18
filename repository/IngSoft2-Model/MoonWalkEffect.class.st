Class {
	#name : 'MoonWalkEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'desplacement'
	],
	#classInstVars : [
		'desplacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalkEffect class >> mustBePositive: aDesplacement [

	(aDesplacement isInteger not or: [ aDesplacement <= 0]) ifTrue: [
		Error signal: 'The desplacement must be a posible value.' ]
]

{ #category : 'instance creation' }
MoonWalkEffect class >> with: aDesplacement [

	self mustBePositive: aDesplacement.
	^ self new initializeWith: aDesplacement
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> applyToAllSpaceShips: aPosition [

	^ Position at: aPosition - desplacement withLaps: 0
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> initializeWith: aDisplacement [

	desplacement := aDisplacement
]
