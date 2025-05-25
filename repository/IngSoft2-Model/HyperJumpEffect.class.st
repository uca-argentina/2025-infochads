Class {
	#name : 'HyperJumpEffect',
	#superclass : 'Object',
	#instVars : [
		'parsecs',
		'parsecScale',
		'listOfJumps'
	],
	#classInstVars : [
		'parsecs',
		'parsecScale',
		'listOfJumps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJumpEffect class >> withParsecValue: totalParsecs totalBoardSize: totalDistance andParsecJumps: aListOfJumps [

	parsecs := totalParsecs.
	parsecScale := totalDistance / totalParsecs.
	listOfJumps := aListOfJumps
]

{ #category : 'as yet unclassified' }
HyperJumpEffect >> withParsecValue: totalParsecs totalBoardSize: totalDistance andParsecJumps: aListOfJumps [

	parsecs := totalParsecs.
	parsecScale := totalDistance / totalParsecs.
	listOfJumps := aListOfJumps
]
