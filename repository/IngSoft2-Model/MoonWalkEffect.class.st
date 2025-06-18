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

{ #category : 'instance creation' }
MoonWalkEffect class >> with: aDisplacement [

	^ self new initializeWith: aDisplacement
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> applyToAllSpaceShips: aPosition [

	^ Position at: aPosition - desplacement withLaps: 0
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> initializeWith: aDisplacement [

	desplacement := aDisplacement
]
