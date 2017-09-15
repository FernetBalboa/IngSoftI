!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'CM 9/14/2017 21:29:32'!
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
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 21:28:51'!
intializeStack
	size _ 0.
	topElement _ OOStackBaseElement basicNew.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 21:17:49'!
isEmpty

	^self size = 0 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 06:50:58'!
pop

	| stackTop |
	self top.
	stackTop _ topElement value.
	topElement _ topElement nextElement.
	size _ size - 1.
	
	^stackTop ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 06:37:32'!
push: aObject
	topElement _ OOStackedElement
		withNext: topElement 
		andValue: aObject.
	size _ size + 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/13/2017 19:08:38'!
size
	
	^size
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 06:50:22'!
top
	"self ifEmptySendErrorSignal."
	^topElement value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'CM 9/14/2017 21:28:13'!
new

	| objectTemporal |
	objectTemporal _ self basicNew.
	objectTemporal intializeStack.
	^objectTemporal ! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOElement category: #'Stack-Exercise'!
OOStack subclass: #OOElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOElement methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 21:44:21'!
nextElement

	self subclassResponsibility ! !

!OOElement methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 18:23:36'!
value

	self subclassResponsibility ! !


!classDefinition: #OOStackBaseElement category: #'Stack-Exercise'!
OOElement subclass: #OOStackBaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBaseElement methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 21:44:05'!
nextElement

	^nil! !

!OOStackBaseElement methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 21:39:36'!
value

	^OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackedElement category: #'Stack-Exercise'!
OOElement subclass: #OOStackedElement
	instanceVariableNames: 'nextElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackedElement methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 06:35:15'!
nextElement
	
	^nextElement ! !

!OOStackedElement methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 06:34:50'!
nextElement: aElement andValue: aValue

	nextElement _ aElement .
	value _ aValue.! !

!OOStackedElement methodsFor: 'as yet unclassified' stamp: 'CM 9/12/2017 20:00:05'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackedElement class' category: #'Stack-Exercise'!
OOStackedElement class
	instanceVariableNames: ''!

!OOStackedElement class methodsFor: 'as yet unclassified' stamp: 'CM 9/14/2017 06:35:56'!
withNext: aElement andValue: aValue

	^ self new nextElement: aElement andValue: aValue ! !
