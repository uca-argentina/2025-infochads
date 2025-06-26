Class {
	#name : 'CardDeck',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardDeck >> availableCards [

	^ {
		  Speed new.
		  Acceleration new.
		  Cancellation new.
		  Redo new.
		  Repeat new.
		  Mercenary new }
]

{ #category : 'as yet unclassified' }
CardDeck >> drawRandomCard [

	^ self availableCards atRandom
]
