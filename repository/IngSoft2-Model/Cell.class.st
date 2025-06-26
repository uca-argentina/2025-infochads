Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Cell class >> has: effect [

	^ self new initializeWithA: effect 
]

{ #category : 'as yet unclassified' }
Cell >> affectOnly: aSpaceShip thatIsPlacedIn: spaceShipPositions [

	spaceShipPositions
		at: aSpaceShip id
		put: ((spaceShipPositions at: aSpaceShip id) replacePositionWith:
				 (effect applyToSpaceShip:
					  (spaceShipPositions at: aSpaceShip id) position))
]

{ #category : 'as yet unclassified' }
Cell >> affectTheShieldOf: aSpaceShip [

	effect damageShield ifTrue: [ aSpaceShip loseShield ]
]

{ #category : 'as yet unclassified' }
Cell >> affectTheShieldOfAll: spaceShips [

	effect damageAllShields ifTrue: [
		spaceShips do: [ :ship | ship loseShield ] ]
]

{ #category : 'as yet unclassified' }
Cell >> dontAffect: aSpaceShip butInstedAffectAll: spaceShips thatArePlacedIn: spaceShipPositions [

	spaceShips do: [ :ship |
		ship == aSpaceShip ifFalse: [
			spaceShipPositions
				at: ship id
				put: ((spaceShipPositions at: ship id) replacePositionWith:
						 (effect applyToAllSpaceShips:
							  (spaceShipPositions at: ship id) position)) ] ]
]

{ #category : 'accessing' }
Cell >> effect [

	^ effect 
]

{ #category : 'as yet unclassified' }
Cell >> giveCardToShip: aSpaceShip [

	aSpaceShip drawCard: (effect giveCardToShip).
					  
]

{ #category : 'initialization' }
Cell >> initializeWithA: anEffect [

	effect := anEffect
]

{ #category : 'as yet unclassified' }
Cell >> takeActionOver: aSpaceShip or: spaceShips thatArePlaced: spaceShipPositions [

	self affectOnly: aSpaceShip thatIsPlacedIn: spaceShipPositions.
	self giveCardToShip: aSpaceShip.
	self
		dontAffect: aSpaceShip
		butInstedAffectAll: spaceShips
		thatArePlacedIn: spaceShipPositions.

	self affectTheShieldOf: aSpaceShip.

	self affectTheShieldOfAll: spaceShips
]
