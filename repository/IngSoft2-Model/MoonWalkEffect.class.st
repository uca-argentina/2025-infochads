Class {
	#name : 'MoonWalkEffect',
	#superclass : 'Object',
	#instVars : [
		'desplacement'
	],
	#classInstVars : [
		'desplacement'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalkEffect >> modify: aSpaceShip orMaybe: allSpaceShips [

	| otherShips |
	otherShips := allSpaceShips select: [ :ship | ship ~= aSpaceShip ].

	otherShips ifNotNil: [ self moveBack: otherShips ]
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> moveBack: otherSpaceShips [

	otherSpaceShips do: [ :ship |
		ship updateTemporaryPosition: (ship getTemporaryPosition + desplacement) ]
]

{ #category : 'as yet unclassified' }
MoonWalkEffect >> withDesplacementValue: aPosition [

	desplacement := aPosition
]
