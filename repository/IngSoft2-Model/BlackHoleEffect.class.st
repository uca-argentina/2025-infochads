Class {
	#name : 'BlackHoleEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'displacement',
		'desplacement'
	],
	#classInstVars : [
		'displacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleEffect class >> withBackTrack: aDesplacement [

	^ self new initializeWith: aDesplacement
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> applyToSpaceShip: aPosition [

	^ Position at: aPosition - desplacement withLaps: 0.
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> initializeWith: aDesplacement [

	desplacement := aDesplacement
]
