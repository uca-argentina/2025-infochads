Class {
	#name : 'AtomicBombEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'desplacement'
	],
	#classInstVars : [
		'shieldScrificed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombEffect class >> with: aDesplacement [

	(aDesplacement isInteger not or: [ aDesplacement ~= 0 ]) ifTrue: [
		Error signal: 'The desplacement must be 0.' ].
	^ self new initializedWith: aDesplacement
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> applyToAllSpaceShips: aPosition [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> applyToSpaceShip: aPosition [

	^ Position at: 0 withLaps: 0
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> damageAllShields [

	^ true
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> initializedWith: aDesplacement [

	desplacement := aDesplacement
]
