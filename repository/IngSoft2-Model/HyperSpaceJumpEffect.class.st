Class {
	#name : 'HyperSpaceJumpEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'desplacement'
	],
	#classInstVars : [
		'displacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect class >> mustBeFour: aDesplacement [

	(aDesplacement isInteger not or: [ aDesplacement ~= 4 ]) ifTrue: [
		Error signal: 'The desplacement must be 4.' ]
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect class >> with: aDesplacement [

	self mustBeFour: aDesplacement.
	^ self new initializeWith: aDesplacement
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> applyToSpaceShip: aPosition [

	^ Position at: aPosition + desplacement withLaps: 0
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> damageShield [

	^ true
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect >> initializeWith: aDesplacement [

	desplacement := aDesplacement.
]
