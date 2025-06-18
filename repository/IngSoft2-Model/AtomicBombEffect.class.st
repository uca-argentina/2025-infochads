Class {
	#name : 'AtomicBombEffect',
	#superclass : 'NoEffect',
	#classInstVars : [
		'shieldScrificed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombEffect class >> withSacrified: shields [

	^self new initializedWithSacrified: shields
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
AtomicBombEffect >> initializedWithSacrified: shields [

	
]
