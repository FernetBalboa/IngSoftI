!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'CM 9/12/2017 21:23:38'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topNode size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:27:56'!
ifEmptySendErrorSignal
	
	self isEmpty 
		ifTrue: [self signalStackEmptyErrorDescription].! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:08:20'!
intializeStack
	
	size _ 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 21:17:49'!
isEmpty

	^self size = 0 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:15:13'!
pop

	| topElement |
	self ifEmptySendErrorSignal.
	topElement _ topNode value.
	topNode _ topNode nextNode.
	size _ size - 1.
	
	^topElement ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:10:21'!
push: aObject
	topNode _ OONode withNext: topNode andValue: aObject.
	size _ size+1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 05:57:44'!
signalStackEmptyErrorDescription 

	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:08:38'!
size
	
	^size
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:14:58'!
top
	self ifEmptySendErrorSignal.
	^topNode value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'CM 9/13/2017 19:07:25'!
new

	| objectTemporal |
	objectTemporal _ super new.
	objectTemporal intializeStack.
	^objectTemporal ! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OONode category: #'Stack-Exercise'!
OOStack subclass: #OONode
	instanceVariableNames: 'nextNode value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONode methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 19:32:46'!
nextNode

	^nextNode ! !

!OONode methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 07:02:47'!
nextNode: aNode

	nextNode _ aNode ! !

!OONode methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 06:15:23'!
nextNode: aNode andValue: aValue

	self nextNode: aNode.
	self value: aValue.! !

!OONode methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 20:00:05'!
value

	^value! !

!OONode methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 07:03:08'!
value: aObject

	value _ aObject ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONode class' category: #'Stack-Exercise'!
OONode class
	instanceVariableNames: ''!

!OONode class methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 20:28:46'!
withNext: alink

	^ self new nextNode: alink! !

!OONode class methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 20:28:26'!
withNext: alink andValue: aValue

	^ self new nextNode: alink andValue: aValue ! !
