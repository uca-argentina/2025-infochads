Class {
	#name : 'HyperSpaceJumpEffect',
	#superclass : 'Object',
	#classInstVars : [
		'displacement',
		'shieldsTaken'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJumpEffect class >> withDesplacementValue: aPosition andShieldsSacrificed: aNumberOfShields [

	displacement := aPosition.
	shieldsTaken := aNumberOfShields
]
