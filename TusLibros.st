!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'items' stamp: 'FB 10/26/2017 21:43:18'!
itemNotSoldByStore

	^'Item not sold by store'.! !


!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:23:33'!
test01NewCartIsEmpty

	| cart |
	
	cart _ self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:32:34'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart _ self createCart.
	
	self
		should: [ cart add: self itemNotSoldByStore]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty.].
		! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:22:20'!
testX02CartIsNotEmptyAfterAddingAnItem

	| cart book |
	
	cart _ Cart new.
	book _ #Book1.
	
	cart add: book.
		
	self assert: cart isEmpty not.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:22:34'!
testX03CartCanHaveMoreThanOneElement

	| cart book1 book2 |
	
	cart _ Cart new.
	book1 _ #Book1.
	book2 _ #Book2.
	
	cart add: book1.
	cart add: book2.
		
	self assert: cart isEmpty not.
	self assert: (cart includes: book1).
	self assert: (cart includes: book2).! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:22:41'!
testX04CartCanAddSameItemMoreThanOnce

	| cart book1 |
	
	cart _ Cart new.
	book1 _ #Book1.
	
	cart add: book1.
	cart add: book1.
		
	self assert: cart isEmpty not.
	self assert: (cart ocurrencesOf: book1) equals: 2.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:22:50'!
testX05RemovingAUnitOfAnItemDecreasesItsOcurrencesByOne



	| cart book1 |
	
	cart _ Cart new.
	book1 _ #Book1.
	
	cart add: book1.
	cart add: book1.
	
	cart remove: book1.
		
	self assert: (cart ocurrencesOf: book1) equals: 1.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:23:01'!
testX06CartDoesNotIncludeItemAfterRemovingAllItsOcurrences



	| cart book1 book2 |
	
	cart _ Cart new.
	book1 _ #Book1.
	book2 _ #Book2.
	
	cart add: book1.
	cart add: book1.
	cart add: book1.
	cart add: book2.
	
	cart remove: book1.
	cart remove: book1.
	cart remove: book1.
		
	self assert: (cart includes: book1) not.
	self assert: (cart includes: book2).! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:40:47'!
testX07CanNotRemoveAnItemFromCartThatWasNotAdded

	| cart book1 book2 |
	
	cart _ Cart new.
	book1 _ #Book1.
	book2 _ #Book2.
	
	cart add: book1.
	self
		should: [ cart remove: book2. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = cart itemNotInCartErrorMessage.
			self assert: (cart includes: book1).
			self assert: (cart includes: book2) not ].

	! !


!CartTest methodsFor: 'cart creation' stamp: 'FB 10/26/2017 21:47:46'!
createCart

	^Cart forCatalogue: self defaultCatalogue.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding items' stamp: 'FB 10/26/2017 20:32:52'!
add: anItem
	
	| newValue |
	
	items at: anItem ifPresent: [ :eachNotUsed | newValue _ (items at: anItem) + 1 ] ifAbsent: [ newValue _ 1 ].
	
	items at: anItem put: newValue.
	! !


!Cart methodsFor: 'initialization' stamp: 'FB 10/26/2017 21:51:14'!
initializeWithCatalogue: aCatalogue

	items _ Dictionary new. "Cambiar a bag?"
	catalogue _ aCatalogue.! !


!Cart methodsFor: 'inspection' stamp: 'FB 10/26/2017 20:28:01'!
includes: anItem

	^items includesKey: anItem.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/26/2017 19:59:10'!
isEmpty

	^items isEmpty.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/26/2017 20:19:57'!
ocurrencesOf: anItem

	^items at: anItem.! !


!Cart methodsFor: 'removing items' stamp: 'FB 10/26/2017 21:37:11'!
remove: anItem
	| newValue |
	newValue _ (items
		at: anItem
		ifAbsent: [ ^ self itemNotInCartErrorMessage ]) - 1.
	newValue = 0
		ifTrue: [ items removeKey: anItem ]
		ifFalse: [
			items
				at: anItem
				put: newValue ].! !


!Cart methodsFor: 'errors' stamp: 'FB 10/26/2017 21:35:58'!
invalidItemErrorMessage

	^Error signal: (self class invalidItemErrorMessage).! !

!Cart methodsFor: 'errors' stamp: 'FB 10/26/2017 21:37:11'!
itemNotInCartErrorMessage
	^ Error signal: self class itemNotInCartErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'FB 10/26/2017 21:36:30'!
invalidItemErrorMessage

	^'Error: invalid item'.! !

!Cart class methodsFor: 'error messages' stamp: 'FB 10/26/2017 21:36:38'!
itemNotInCartErrorMessage

	^'Error: item not in cart'.! !


!Cart class methodsFor: 'instance creation' stamp: 'FB 10/26/2017 21:50:21'!
forCatalogue: aCatalogue

	^self basicNew initializeWithCatalogue: aCatalogue.! !
