Class {
	#name : 'NoEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NoEffect >> applyToAllSpaceShips: aPosition [

	^ Position at: aPosition withLaps: 0
]

{ #category : 'as yet unclassified' }
NoEffect >> applyToSpaceShip: aPosition [

	^ Position at: aPosition withLaps: 0
]

{ #category : 'as yet unclassified' }
NoEffect >> damageAllShields [

	^ false
]

{ #category : 'as yet unclassified' }
NoEffect >> damageShield [

	^ false
]

{ #category : 'as yet unclassified' }
NoEffect >> giveCardToShip [

	^ self
]
