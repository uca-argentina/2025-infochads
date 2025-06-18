Class {
	#name : 'PowerCellUnitTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PowerCellUnitTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: (error messageText) equals:
                errorMessage ]
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenAtomicBombDoesntReceiveADesplacementNotAsIntegerThenCreationFails [

	self
		should: [ AtomicBombEffect with: 'a' ]
		raise: Error
		withMessageText: 'The desplacement must be 0.'
]

{ #category : 'tests' }
PowerCellUnitTest >> testWhenAtomicBombReceiveADesplacementOtherThan0ThenCreationFails [

	self
		should: [ AtomicBombEffect with: 10 ]
		raise: Error
		withMessageText: 'The desplacement must be 0.'
]
