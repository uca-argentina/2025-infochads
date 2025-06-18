Class {
	#name : 'HyperSpaceJumpEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'desplacement',
		'shieldsTaken'
	],
	#classInstVars : [
		'displacement',
		'shieldsTaken'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect class >> with: aDesplacement and: shieldsSacrified [

	^ self new initializeWith: aDesplacement and: shieldsSacrified
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
HyperSpaceJumpEffect >> initializeWith: aDesplacement and: shieldsSacrified [

	desplacement := aDesplacement.
]
