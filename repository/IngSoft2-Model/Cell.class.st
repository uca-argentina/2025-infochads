Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'position',
		'type',
		'powerUp',
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
Cell >> initializeWithPosition: aPosition type: aType effect: anEffect [

	position := aPosition.
	type := aType.
	effect := anEffect.
	^ self
]

{ #category : 'accessing' }
Cell >> position [

	^ position
]

{ #category : 'accessing' }
Cell >> type [

	^ type 
]
