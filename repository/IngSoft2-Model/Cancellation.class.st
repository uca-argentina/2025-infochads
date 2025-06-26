Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#instVars : [
		'removedEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Cancellation >> effectTypeToCancel: effectToRemove [

	removedEffect := effectToRemove
]

{ #category : 'as yet unclassified' }
Cancellation >> getEffect [

	^ removedEffect
]

{ #category : 'testing' }
Cancellation >> isCancellation [

	^ true
]
