Class {
	#name : 'Card',
	#superclass : 'Object',
	#instVars : [
		'isApplicable'
	],
	#classInstVars : [
		'isApplicable'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Card >> isApplicable [

	^ isApplicable ifNil: [ true ]
]

{ #category : 'accessing' }
Card >> isApplicable: aBoolean [

	isApplicable := aBoolean
]

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

{ #category : 'testing' }
Card >> isRepeat [

	^ false
]

{ #category : 'as yet unclassified' }
Card >> resolveCardWith: aPreviousCard [

	^ self
]
