!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'items' stamp: 'FB 10/27/2017 10:57:56'!
item1SoldByStore
	^ 'Item1 sold by store'.! !

!CartTest methodsFor: 'items' stamp: 'FB 10/27/2017 10:58:01'!
item2SoldByStore
	^ 'Item2 sold by store'.! !

!CartTest methodsFor: 'items' stamp: 'FB 10/26/2017 21:43:18'!
itemNotSoldByStore

	^'Item not sold by store'.! !


!CartTest methodsFor: 'testing' stamp: 'FB 10/26/2017 21:23:33'!
test01NewCartIsEmpty

	| cart |
	
	cart _ self createCart.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 10:54:30'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart _ self createCart.
	
	self
		should: [ cart add: self itemNotSoldByStore]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty.].
		! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 10:57:45'!
test03CartIsNotEmptyAfterAddingAnItem
	| cart |
	cart _ self createCart.
	cart add: self item1SoldByStore.
	self assert: cart isEmpty not.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 11:00:04'!
test04CartCanHaveMoreThanOneElement

	| cart item1 item2 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	item2 _ self item2SoldByStore.
	
	cart add: item1.
	cart add: item2.
		
	self assert: cart isEmpty not.
	self assert: (cart includes: item1).
	self assert: (cart includes: item2).! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 11:02:32'!
test05CartCanAddSameItemMoreThanOnce

	| cart item |
	
	cart _ self createCart.
	item _ self item1SoldByStore.
	
	cart add: item.
	cart add: item.
		
	self assert: cart isEmpty not.
	self assert: (cart occurrencesOf: item) equals: 2.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 11:04:34'!
test06CartCanAddManyOfTheSameItemAtOnce

	| cart item |
	
	cart _ self createCart.
	item _ self item1SoldByStore.
	
	cart add: 4 of: item.
	cart add: item.
		
	self assert: cart isEmpty not.
	self assert: (cart occurrencesOf: item) equals: 5.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 11:13:53'!
test07RemovingAUnitOfAnItemDecreasesItsOcurrencesByOne
	
	| cart item1 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	
	cart add: item1.
	cart add: item1.
	cart remove: item1.
	
	self
		assert: (cart occurrencesOf: item1)
		equals: 1.! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 11:13:59'!
test08CartDoesNotIncludeItemAfterRemovingAllItsOcurrences
	
	| cart item1 item2 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	item2 _ self item2SoldByStore.
	
	cart add: item1.
	cart add: item1.
	cart add: item1.
	cart add: item2.
	cart remove: item1.
	cart remove: item1.
	cart remove: item1.
	
	self assert: (cart includes: item1) not.
	self assert: (cart includes: item2).! !

!CartTest methodsFor: 'testing' stamp: 'FB 10/27/2017 11:14:04'!
test09CanNotRemoveAnItemFromCartThatWasNotAdded

	| cart item1 item2 |
	
	cart _ self createCart.
	item1 _ self item1SoldByStore.
	item2 _ self item2SoldByStore.
	
	cart add: item1.
	
	self
		should: [ cart remove: item2. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cart itemNotInCartErrorMessage.
			self assert: (cart includes: item1).
			self assert: (cart includes: item2) not ].

	! !


!CartTest methodsFor: 'cart creation' stamp: 'FB 10/27/2017 10:52:20'!
createCart
	^ Cart withCatalogue: self defaultCatalogue.! !

!CartTest methodsFor: 'cart creation' stamp: 'FB 10/27/2017 10:59:46'!
defaultCatalogue
	^ Set with: self item1SoldByStore with: self item2SoldByStore.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'FB 10/28/2017 13:28:03'!
test01CanNotCheckoutEmptyCart

	| cart cashier card |
	
	cashier _ self createCashier.
	cart _ cashier cart.
	card _ self createValidCreditCard.
	
	self
		should: [ cashier checkout: cart withCreditCard: card ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartCheckoutErrorMessage.
			"Assert no payment was charged"]! !

!CashierTest methodsFor: 'testing' stamp: 'FB 10/28/2017 14:33:21'!
test02CanNotCheckoutCartWithExpiredCreditCard

	| cart cashier card |
	
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	card _ self createExpiredCreditCard.
	
	self
		should: [ cashier checkout: cart withCreditCard: card ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardCheckoutErrorMessage.
			"Assert no payment was charged"]! !


!CashierTest methodsFor: 'cashier creation' stamp: 'FB 10/28/2017 11:58:13'!
createCashier

	^Cashier for: self createCart.! !


!CashierTest methodsFor: 'cart creation' stamp: 'FB 10/27/2017 11:22:51'!
createCart

	^CartTest new createCart.! !


!CashierTest methodsFor: 'items' stamp: 'FB 10/28/2017 14:34:09'!
item1SoldByStore

	^CartTest new item1SoldByStore.! !


!CashierTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:20:12'!
createExpiredCreditCard
	
	^CreditCardTest new createExpiredCreditCard.! !

!CashierTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:20:53'!
createValidCreditCard
	
	^CreditCardTest new createValidCreditCard.! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'owner number expirationMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'FB 10/28/2017 13:14:55'!
test01CanNotCreateCreditCardWithNameLongerThan30Characters

	self
		should: [ self createCreditCardWithInvalidName ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard tooManyCharactersInOwnerNameErrorMessage ] ! !

!CreditCardTest methodsFor: 'testing' stamp: 'FB 10/28/2017 13:25:32'!
test02CreditCardNumberMustHave16Digits
	
	"Esto solo testea que no falla con 15 digitos. Seria bueno testear que tampoco funcione con 17, asi cubrimos los casos borde"
	
	self
		should: [ self createCreditCardWithInvalidNumber ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidNumberErrorMessage ] ! !

!CreditCardTest methodsFor: 'testing' stamp: 'FB 10/28/2017 13:34:43'!
test03ExpiredCreditCardKnowsItHasExpired
	
	"Buscar mejor nombre para el test"
	
	| card |
	
	card _ self createExpiredCreditCard.
	
	self assert: card isExpired.! !


!CreditCardTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:18:27'!
createCreditCardWithInvalidName
	
	"Preguntar si contamos los espacios en blanco como caracteres"
	
	^CreditCard withOwner: 'Name is too long to put in card' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !

!CreditCardTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 12:48:52'!
createCreditCardWithInvalidNumber

	^CreditCard withOwner: 'Juan Perez' withNumber: '540000000000000' withExpiration: Date tomorrow month.! !

!CreditCardTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:40:54'!
createExpiredCreditCard
	
	| today lastMonth |
	
	today _ Date today.
	lastMonth _ Month month: ((today monthIndex - 1)) year: today yearNumber. "Probablemente hay una forma mas facil de hacer esto"
	
	^CreditCard withOwner: 'Juan Perez' withNumber: '5400000000000001' withExpiration: lastMonth.! !

!CreditCardTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:19:12'!
createValidCreditCard

	^CreditCard withOwner: 'Juan Perez' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding items' stamp: 'FB 10/27/2017 10:50:17'!
add: anItem
	
	(catalogue includes: anItem) ifFalse: [ ^self invalidItemErrorMessage ].
	items add: anItem.
	! !

!Cart methodsFor: 'adding items' stamp: 'FB 10/27/2017 11:05:32'!
add: quantity of: anItem
	
	(catalogue includes: anItem) ifFalse: [ ^self invalidItemErrorMessage ].
	items add: anItem withOccurrences: quantity.
	! !


!Cart methodsFor: 'initialization' stamp: 'FB 10/27/2017 10:35:46'!
initializeWithCatalogue: aCatalogue

	items _ Bag new.
	catalogue _ aCatalogue.! !


!Cart methodsFor: 'inspection' stamp: 'FB 10/28/2017 11:57:22'!
catalogue

	^catalogue.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/27/2017 10:36:46'!
includes: anItem

	^items includes: anItem.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/26/2017 19:59:10'!
isEmpty

	^items isEmpty.! !

!Cart methodsFor: 'inspection' stamp: 'FB 10/27/2017 11:01:38'!
occurrencesOf: anItem

	^items occurrencesOf: anItem.! !


!Cart methodsFor: 'removing items' stamp: 'FB 10/27/2017 11:13:42'!
remove: anItem
	
	"Implementacion desactualizada. Dejar para mas adelante, no esta en la especificacion"
	
	items remove: anItem ifAbsent: [^Error signal: self class itemNotInCartErrorMessage ].! !


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


!Cart class methodsFor: 'instance creation' stamp: 'FB 10/27/2017 10:52:20'!
withCatalogue: aCatalogue
	^ self basicNew initializeWithCatalogue: aCatalogue.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'FB 10/28/2017 14:29:54'!
checkout: aShoppingCart withCreditCard: aCreditCard

	aShoppingCart isEmpty ifTrue: [ ^Error signal: self class emptyCartCheckoutErrorMessage. ].
	aCreditCard isExpired ifTrue: [ ^Error signal: self class expiredCardCheckoutErrorMessage. ].! !


!Cashier methodsFor: 'initialization' stamp: 'FB 10/28/2017 11:57:11'!
initializeFor: aShoppingCart

	cart _ aShoppingCart.
	catalogue _ cart catalogue.! !


!Cashier methodsFor: 'inspection' stamp: 'FB 10/28/2017 11:59:30'!
cart

	^cart.! !

!Cashier methodsFor: 'inspection' stamp: 'FB 10/28/2017 11:59:45'!
catalogue

	^catalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FB 10/27/2017 11:27:39'!
emptyCartCheckoutErrorMessage

	^'Error: can not checkout empty cart'.! !

!Cashier class methodsFor: 'error messages' stamp: 'FB 10/28/2017 13:30:38'!
expiredCardCheckoutErrorMessage
	
	^'Error: can not checkout with expired credit card'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'FB 10/28/2017 11:55:59'!
for: aShoppingCart

	^self basicNew initializeFor: aShoppingCart.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationMonthAndYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FB 10/28/2017 14:14:53'!
initializeWithOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear
	
	owner _ anOwnerName.
	number _ aCreditCardNumber.
	expirationMonthAndYear _ anExpirationMonthAndYear.! !


!CreditCard methodsFor: 'status' stamp: 'FB 10/28/2017 14:27:58'!
isExpired
	
	^(expirationMonthAndYear yearNumber < Month current yearNumber or: [ expirationMonthAndYear monthIndex < Month current monthIndex. ]).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FB 10/28/2017 14:15:08'!
withOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear
	
	anOwnerName size > 30 ifTrue: [ ^Error signal: self tooManyCharactersInOwnerNameErrorMessage ].
	aCreditCardNumber size ~= 16 ifTrue: [ ^Error signal: self invalidNumberErrorMessage ].
	
	^self basicNew initializeWithOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear.! !


!CreditCard class methodsFor: 'error messages' stamp: 'FB 10/28/2017 12:42:54'!
invalidNumberErrorMessage

	^'Error: credit card number must have 16 digits'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'FB 10/28/2017 12:42:07'!
tooManyCharactersInOwnerNameErrorMessage

	^'Error: credit card owner name must have at most 30 characters'.! !
