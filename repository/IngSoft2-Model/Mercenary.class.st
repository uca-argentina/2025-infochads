Class {
	#name : 'Mercenary',
	#superclass : 'PermanentCard',
	#instVars : [
		'ally'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Mercenary >> getAlly [

	^ ally
]

{ #category : 'testing' }
Mercenary >> hasNoMercenary [

	^ ally isNil
]

{ #category : 'testing' }
Mercenary >> isMercenary [

	^ true
]

{ #category : 'as yet unclassified' }
Mercenary >> signContract: aMercenarySpaceShip [

	ally := aMercenarySpaceShip
]
