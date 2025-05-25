Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Object',
	#classInstVars : [
		'shieldScrificed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombEffect class >> ShieldsSacrificed: aNumberOfShields [

	shieldScrificed := aNumberOfShields
]
