Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Object',
	#classInstVars : [
		'displacement',
		'shieldsTaken'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJump class >> withDesplacementValue: aPosition andShieldsSacrificed: aNumberOfShields [

	displacement := aPosition.
	shieldsTaken := aNumberOfShields
]
