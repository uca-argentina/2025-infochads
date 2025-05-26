Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Object',
	#instVars : [
		'shieldScrificed'
	],
	#classInstVars : [
		'shieldScrificed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBombEffect >> deductOneShield: aCollection [ 
	
	aCollection do: [ :ship |
		ship loseShield ]
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> modify: aSpaceShip orMaybe: allSpaceShips [

	self moveBack: allSpaceShips.
	self deductOneShield: allSpaceShips.
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> moveBack: allSpaceShips [

	allSpaceShips do: [ :ship |
		ship updateTemporaryPosition: 1 ]
]

{ #category : 'as yet unclassified' }
AtomicBombEffect >> shieldsSacrificed: aNumberOfShields [

	shieldScrificed := aNumberOfShields
]
