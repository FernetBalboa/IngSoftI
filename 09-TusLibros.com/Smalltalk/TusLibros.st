!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'items' stamp: 'FB 10/30/2017 19:03:09'!
item1SoldByStore
	^ 'Item 1 sold by store'.! !

!TusLibrosTest methodsFor: 'items' stamp: 'FB 10/30/2017 19:03:15'!
item2SoldByStore
	^ 'Item 2 sold by store'.! !

!TusLibrosTest methodsFor: 'items' stamp: 'FB 10/26/2017 21:43:18'!
itemNotSoldByStore

	^'Item not sold by store'.! !


!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/26/2017 21:23:33'!
test01NewCartIsEmpty

	| cart |
	
	cart _ self createCart.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 10:54:30'!
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

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 10:57:45'!
test03CartIsNotEmptyAfterAddingAnItem
	| cart |
	cart _ self createCart.
	cart add: self item1SoldByStore.
	self assert: cart isEmpty not.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:00:04'!
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

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:02:32'!
test05CartCanAddSameItemMoreThanOnce

	| cart item |
	
	cart _ self createCart.
	item _ self item1SoldByStore.
	
	cart add: item.
	cart add: item.
		
	self assert: cart isEmpty not.
	self assert: (cart occurrencesOf: item) equals: 2.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:04:34'!
test06CartCanAddManyOfTheSameItemAtOnce

	| cart item |
	
	cart _ self createCart.
	item _ self item1SoldByStore.
	
	cart add: 4 of: item.
	cart add: item.
		
	self assert: cart isEmpty not.
	self assert: (cart occurrencesOf: item) equals: 5.! !

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:13:53'!
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

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:13:59'!
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

!TusLibrosTest methodsFor: 'cart test' stamp: 'FB 10/27/2017 11:14:04'!
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


!TusLibrosTest methodsFor: 'cart creation' stamp: 'FB 10/30/2017 19:04:05'!
createCart
	^ Cart withCatalogue: self defaultCatalogue.! !

!TusLibrosTest methodsFor: 'cart creation' stamp: 'FB 10/30/2017 21:02:50'!
createSalesBook

	^ Dictionary new.! !

!TusLibrosTest methodsFor: 'cart creation' stamp: 'FB 10/30/2017 18:19:25'!
defaultCatalogue
	
	| catalogue |
	catalogue _ Dictionary new.
	catalogue at: (self item1SoldByStore) put: 10 * peso.
	catalogue at: (self item2SoldByStore) put: 30 * peso.
	^catalogue.
	! !


!TusLibrosTest methodsFor: 'credit card test' stamp: 'FB 10/31/2017 09:48:06'!
test10CanNotCreateCreditCardWithEmptyName
	
	| register |
	
	register _ self createCreditCardsRegister.
	
	self
		should: [ register add: self createCreditCardWithEmptyName ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard emptyOwnerNameErrorMessage.
			self assert: register isEmpty ].! !

!TusLibrosTest methodsFor: 'credit card test' stamp: 'FB 10/31/2017 09:49:02'!
test11CreditCardNumberMustHave16Digits
	"Esto solo testea que no falla con 15 digitos. Seria bueno testear que tampoco funcione con 17, asi cubrimos los casos borde"
	
	| register |
	
	register _ self createCreditCardsRegister.
	
	self
		should: [ register add: self createCreditCardWithInvalidNumber ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumberErrorMessage.
			self assert: register isEmpty ].! !

!TusLibrosTest methodsFor: 'credit card test' stamp: 'FB 10/31/2017 09:50:19'!
test12ExpiredCreditCardKnowsItHasExpired
	"Buscar mejor nombre para el test"
	| card register |
	
	register _ self createCreditCardsRegister.
	card _ self createExpiredCreditCard.
	
	register add: card.
	
	self assert: (card isExpiredAtDate: Date today).
	self assert: (register includes: card).! !


!TusLibrosTest methodsFor: 'cashier creation' stamp: 'FB 10/28/2017 11:58:13'!
createCashier

	^Cashier for: self createCart.! !


!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:30:38'!
createCreditCardWithEmptyName
	
	"Preguntar si contamos los espacios en blanco como caracteres"
	"Este metodo no corresponde aca, deberia moverse a la interfaz mas adelante"
	
	^CreditCard withOwner: ' ' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:28:55'!
createCreditCardWithInvalidName
	
	"Preguntar si contamos los espacios en blanco como caracteres"
	"Este metodo no corresponde aca, deberia moverse a la interfaz mas adelante"
	
	^CreditCard withOwner: 'Name is too long to put in card' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 12:48:52'!
createCreditCardWithInvalidNumber

	^CreditCard withOwner: 'Juan Perez' withNumber: '540000000000000' withExpiration: Date tomorrow month.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:46:59'!
createCreditCardsRegister

	^OrderedCollection new.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/31/2017 09:27:54'!
createExpiredCreditCard
	
	| lastMonth |
	
	lastMonth _ Date today month previous.
	
	^CreditCard withOwner: 'Juan Perez' withNumber: '5400000000000001' withExpiration: lastMonth.! !

!TusLibrosTest methodsFor: 'credit card creation' stamp: 'FB 10/28/2017 13:19:12'!
createValidCreditCard

	^CreditCard withOwner: 'Juan Perez' withNumber: '5400000000000001' withExpiration: Date tomorrow month.! !


!TusLibrosTest methodsFor: 'cashier test' stamp: 'FB 10/30/2017 21:03:53'!
test13CanNotCheckoutEmptyCart
	| cashier card salesBook |
	cashier _ self createCashier.
	card _ self createValidCreditCard.
	salesBook _ self createSalesBook.
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartCheckoutErrorMessage ].! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'FB 10/30/2017 21:04:25'!
test14CanNotCheckoutCartWithExpiredCreditCard
	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	card _ self createExpiredCreditCard.
	salesBook _ self createSalesBook.
	
	self
		should: [ cashier checkoutWithCreditCard: card registerOn: salesBook .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardCheckoutErrorMessage ].! !

!TusLibrosTest methodsFor: 'cashier test' stamp: 'FB 10/30/2017 21:16:22'!
test15CashierCalculatesTheRightAmountToDebit
	| cart cashier card salesBook |
	cashier _ self createCashier.
	cart _ cashier cart.
	cart add: self item1SoldByStore.
	cart add: self item1SoldByStore.
	cart add: self item2SoldByStore.
	cart add: self item2SoldByStore.
	card _ self createValidCreditCard.
	
	salesBook _ self createSalesBook.
		
	self assert: (cashier checkoutWithCreditCard: card registerOn: salesBook) = (80 * peso).! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding items' stamp: 'FB 10/30/2017 18:21:19'!
add: anItem
	
	(catalogue includesKey: anItem) ifFalse: [ ^self invalidItemErrorMessage ].
	items add: anItem.
	! !

!Cart methodsFor: 'adding items' stamp: 'FB 10/30/2017 18:21:42'!
add: quantity of: anItem
	
	(catalogue includesKey: anItem) ifFalse: [ ^self invalidItemErrorMessage ].
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

!Cart methodsFor: 'inspection' stamp: 'FB 10/30/2017 18:27:22'!
items

	^items.! !

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

!Cashier methodsFor: 'checkout' stamp: 'FB 10/31/2017 09:51:48'!
checkoutWithCreditCard: aCreditCard registerOn: aSalesBook

	| totalAmount |
	cart isEmpty ifTrue: [ ^Error signal: self class emptyCartCheckoutErrorMessage. ].
	(aCreditCard isExpiredAtDate: Date today) ifTrue: [ ^Error signal: self class expiredCardCheckoutErrorMessage. ].
	
	totalAmount _ 0 * peso.
	cart items do: [:anItem | totalAmount  _ self updateAmount: totalAmount andRegisterSaleOf: anItem on: aSalesBook].
	self debit: totalAmount from: aCreditCard.
	
	^totalAmount.
	! !

!Cashier methodsFor: 'checkout' stamp: 'FB 10/30/2017 18:31:42'!
debit: anAmountToDebit from: aCreditCard

	
	! !


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


!Cashier methodsFor: 'as yet unclassified' stamp: 'FB 10/30/2017 20:59:02'!
registerSaleOf: anItem on: aSalesBook 

	aSalesBook at: anItem put: (catalogue at: anItem) ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'FB 10/30/2017 21:18:01'!
updateAmount: anAmount andRegisterSaleOf: anItem on: aSalesBook

	aSalesBook at: anItem put: (catalogue at: anItem). 
	^anAmount  + (catalogue at: anItem).	! !

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


!CreditCard methodsFor: 'status' stamp: 'FB 10/31/2017 09:26:07'!
isExpiredAtDate: aDate
	
	^expirationMonthAndYear start < aDate month start.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FB 10/31/2017 09:43:51'!
withOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear
	
	| letters |
	
	letters _ 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	
	(anOwnerName includesAnyOf: letters) ifFalse: [ ^Error signal: self emptyOwnerNameErrorMessage ].
	aCreditCardNumber size ~= 16 ifTrue: [ ^Error signal: self invalidNumberErrorMessage ].
	
	^self basicNew initializeWithOwner: anOwnerName withNumber: aCreditCardNumber withExpiration: anExpirationMonthAndYear.! !


!CreditCard class methodsFor: 'error messages' stamp: 'FB 10/31/2017 09:32:15'!
emptyOwnerNameErrorMessage

	^'Error: credit card owner name can not be empty'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'FB 10/28/2017 12:42:54'!
invalidNumberErrorMessage

	^'Error: credit card number must have 16 digits'.! !
