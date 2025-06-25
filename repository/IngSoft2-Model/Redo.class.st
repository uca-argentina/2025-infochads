Class {
	#name : 'Redo',
	#superclass : 'Card',
	#instVars : [
		'lastCardEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Redo >> getLastCardEffect [

	^ lastCardEffect
]

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]

{ #category : 'as yet unclassified' }
Redo >> resolveCardWith: aPreviousCard [

	| resolved |
	resolved := aPreviousCard.
	[ resolved isRedo ] whileTrue: [ resolved := resolved getLastCardEffect ].
	lastCardEffect := resolved.
	^ self
]
