Class {
	#name : 'Dice',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice >> roll [

	^ (1 to: 6) atRandom
]
