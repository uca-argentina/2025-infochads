Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withBoardSize: aNumber [ 
	^self new initializeWithBoardSize: aNumber.
]

{ #category : 'accessing' }
Board >> boardSize [
	^ boardSize
]

{ #category : 'initialization' }
Board >> initializeWithBoardSize: aNumber [ 
	(aNumber isNil or: [aNumber <=0])
		ifTrue: [ Error signal: 'Board Size must be a positive interger' ].
	boardSize := aNumber.
	^self

]
