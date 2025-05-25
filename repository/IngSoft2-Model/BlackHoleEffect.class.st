Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Object',
	#instVars : [
		'displacement'
	],
	#classInstVars : [
		'displacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleEffect >> modify: aSpaceShip orMaybe: allSpaceShips [

	aSpaceShip updateTemporaryPosition: (aSpaceShip getTemporaryPosition ) + displacement
]

{ #category : 'as yet unclassified' }
BlackHoleEffect >> withDesplacementValue: aPosition [

	displacement := aPosition
]
