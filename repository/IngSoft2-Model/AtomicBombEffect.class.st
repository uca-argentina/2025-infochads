Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Object',
	#instVars : [
		'shieldScrificed'
	],
	#classInstVars : [
		'shieldScrificed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombEffect >> shieldsSacrificed: aNumberOfShields [

	shieldScrificed := aNumberOfShields
]
