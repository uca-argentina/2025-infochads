Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'type',
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Cell >> effect [

	^ effect 
]

{ #category : 'initialization' }
Cell >> initializeWithType: aType effect: anEffect [

	type := aType.
	effect := anEffect.
	^ self
]

{ #category : 'as yet unclassified' }
Cell >> takeAction: aSpaceShip andOtherSpaceShips: otherSpaceShips [
	
	(type = #normal) ifTrue: [ ^self ].
	effect modify: aSpaceShip orMaybe: otherSpaceShips
]

{ #category : 'accessing' }
Cell >> type [

	^ type 
]
