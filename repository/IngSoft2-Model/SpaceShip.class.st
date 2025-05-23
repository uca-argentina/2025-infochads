Class {
	#name : 'SpaceShip',
	#superclass : 'Object',
	#instVars : [
		'shield',
		'position',
		'temporaryPosition',
		'spaceShipID'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpaceShip >> consumeShield [

	shield := shield - 1
]

{ #category : 'as yet unclassified' }
SpaceShip >> getID [

	^ spaceShipID
]

{ #category : 'as yet unclassified' }
SpaceShip >> getPosition [

	^ position
]

{ #category : 'as yet unclassified' }
SpaceShip >> getShield [

	^ shield
]

{ #category : 'as yet unclassified' }
SpaceShip >> getTemporaryPosition [

	^ temporaryPosition
]

{ #category : 'as yet unclassified' }
SpaceShip >> goToTemporaryPosition: positionsToSum [

	temporaryPosition := position + positionsToSum
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields andInitialPosition: aPosition [ 
	shield := aNumberOfShields.
	position := aPosition.
	temporaryPosition := aPosition.
	^self
]

{ #category : 'initialization' }
SpaceShip >> initializeWithShield: aNumberOfShields andInitialPosition: aPosition andID: aSpaceShipID [

	spaceShipID := aSpaceShipID.
	shield := aNumberOfShields.
	position := aPosition.
	temporaryPosition := aPosition.
	^ self
]

{ #category : 'as yet unclassified' }
SpaceShip >> updatePosition: aNewPosition [

	position := aNewPosition.
	temporaryPosition := position
]

{ #category : 'as yet unclassified' }
SpaceShip >> updateTemporaryPosition: aNewTemporaryPosition [

	temporaryPosition := aNewTemporaryPosition
]
