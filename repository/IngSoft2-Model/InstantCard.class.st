Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
InstantCard >> isCancellation [

	^ false
]

{ #category : 'testing' }
InstantCard >> isInstant [

	^ true
]

{ #category : 'testing' }
InstantCard >> isRepeat [

	^ false
]
