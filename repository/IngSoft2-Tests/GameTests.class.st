Class {
	#name : 'GameTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTests >> testGameCanBeCreated [

	| game |
	game := Game new.
	self assert: Game notNil
]
