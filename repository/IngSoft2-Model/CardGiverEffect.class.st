Class {
	#name : 'CardGiverEffect',
	#superclass : 'NoEffect',
	#instVars : [
		'cardDeck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardGiverEffect class >> with: aCardDeck [

	^ self new initializeWith: aCardDeck
]

{ #category : 'as yet unclassified' }
CardGiverEffect >> giveCardToShip [

	^ cardDeck drawRandomCard
]

{ #category : 'initialization' }
CardGiverEffect >> initializeWith: aCardDeck [

	cardDeck := aCardDeck.
]
