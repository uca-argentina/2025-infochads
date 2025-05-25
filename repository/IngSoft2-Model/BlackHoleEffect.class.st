Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Object',
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
BlackHoleEffect class >> withDesplacementValue: aPosition [

	displacement := aPosition
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> withDesplacementValue: aNumber [

	desplacement := aNumber
]
