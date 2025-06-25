Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Card >> isCancellation [

	^ false
]

{ #category : 'testing' }
Card >> isInstant [

	^ false
]

{ #category : 'testing' }
Card >> isPermanent [

	^ false
]

{ #category : 'testing' }
Card >> isRedo [

	^ false
]

{ #category : 'as yet unclassified' }
Card >> resolveCardWith: aPreviousCard [

	^ self
]
