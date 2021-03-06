!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:28'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |
	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:06'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 3 = lines size.
	self assert: 'Deposito por 100' = (lines at: 1).
	self assert: 'Extraccion por 50' = (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FB 9/26/2017 12:44:15'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portfolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FB 9/26/2017 12:43:59'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortfolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'CM 9/26/2017 04:05:37'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^ AccountSummary accountSummary: aReceptiveAccount ! !

!PortfolioTest methodsFor: 'test support' stamp: 'FB 9/28/2017 13:04:13'!
accountTransferNetOf: aReceptiveAccount 
	
	^(NetTransfersBalance for: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'FB 9/28/2017 13:04:33'!
investmentEarningsOf: aReceptiveAccount 
	
	^(EarningsInvestmentsBalance for: aReceptiveAccount ) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'FB 9/28/2017 13:04:48'!
investmentNetOf: aReceptiveAccount 
	
	^(NetInvestmentsBalance for: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'CM 9/28/2017 15:50:53'!
portfolioTreeOf: aPortfolio namingAccountWith: aDictionary
	^ (AccountTreeViewer
		for: aPortfolio
		namingAccountWith: aDictionary) show.! !

!PortfolioTest methodsFor: 'test support' stamp: 'CM 9/28/2017 16:23:28'!
reversePortfolioTreeOf: aPortfolio namingAccountWith: aDictionary
	^ (AccountTreeViewer for: aPortfolio namingAccountWith: aDictionary) showReverse ! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'CM 9/26/2017 04:05:03'!
accountSummary: anAccount
	| lines | 
	
	lines  _ OrderedCollection new.
 	anAccount transactions do: [ :transaction | lines add: transaction accountSummaryLine ].
	^ lines 	! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'summary' stamp: 'CM 9/26/2017 04:33:52'!
accountSummaryLine

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'CM 9/26/2017 03:03:25'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'CM 9/26/2017 03:02:51'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction ! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'CM 9/26/2017 05:49:49'!
initializeRegister: aAmount during: aDaysLapse at: aPercentage on: anAccount

	tna _ aPercentage. 
	numberOfDays _ aDaysLapse.
	account _ anAccount.
	value _ aAmount.
	! !


!CertificateOfDeposit methodsFor: 'value' stamp: 'CM 9/26/2017 06:14:03'!
profit

	^ (value*(tna/360)*numberOfDays)! !


!CertificateOfDeposit methodsFor: 'account summary' stamp: 'CM 9/26/2017 06:32:34'!
accountSummaryLine

	^ 'Plazo fijo por ', value printString, ' durante ', numberOfDays printString, ' dias a una tna de ', (tna*100) printString,'%' ! !


!CertificateOfDeposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/14/2011 06:23'!
days
	
	^numberOfDays ! !

!CertificateOfDeposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/14/2011 05:14'!
earnings

	^ value*(tna/360)*numberOfDays
	! !

!CertificateOfDeposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/14/2011 06:24'!
tna
	^ tna! !


!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'FB 9/28/2017 12:23:59'!
balanceRequest: aConsultation

	^aConsultation manageCertificateOfDeposit: self.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'CM 9/26/2017 05:53:52'!
value

	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'CM 9/26/2017 05:52:28'!
register: aAmount during: aDaysLapse at: aPercentage on: anAccount
	
	| certificate |
	
	certificate  _ self new initializeRegister: aAmount during: aDaysLapse at: aPercentage on: anAccount.
	anAccount register: certificate.
	
	^ certificate ! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'account summary' stamp: 'CM 9/26/2017 03:44:32'!
accountSummaryLine

	^ 'Deposito por ', value printString! !


!Deposit methodsFor: 'evaluating' stamp: 'FB 9/28/2017 12:41:46'!
balanceRequest: aConsultation

	^aConsultation manageDeposit: self.! !

!Deposit methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'CM 9/26/2017 03:07:53'!
initializeFor: aTransfer

	transfer _ aTransfer ! !


!TransferDeposit methodsFor: 'account summary' stamp: 'CM 9/26/2017 04:02:49'!
accountSummaryLine

	^ 'Transferencia por ', self value printString! !


!TransferDeposit methodsFor: 'evaluating' stamp: 'CM 9/26/2017 03:25:11'!
affectBalance: balance 

	^ balance + self value! !

!TransferDeposit methodsFor: 'evaluating' stamp: 'FB 9/28/2017 12:41:58'!
balanceRequest: aConsultation

	^aConsultation manageTransferDeposit: self.! !

!TransferDeposit methodsFor: 'evaluating' stamp: 'CM 9/26/2017 03:19:53'!
value

	^transfer value.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'CM 9/26/2017 03:08:04'!
initializeFor: aTransfer

	transfer _ aTransfer ! !


!TransferWithdraw methodsFor: 'account summary' stamp: 'CM 9/26/2017 04:02:56'!
accountSummaryLine

	^ 'Transferencia por -', self value printString! !


!TransferWithdraw methodsFor: 'evaluating' stamp: 'CM 9/26/2017 03:25:27'!
affectBalance: balance 

	^ balance - self value! !

!TransferWithdraw methodsFor: 'evaluating' stamp: 'FB 9/28/2017 12:42:13'!
balanceRequest: aConsultation

	^aConsultation manageTransferWithdraw: self.! !

!TransferWithdraw methodsFor: 'evaluating' stamp: 'CM 9/26/2017 03:20:34'!
value

	^transfer value.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'account summary' stamp: 'CM 9/26/2017 03:50:14'!
accountSummaryLine

	^ 'Extraccion por ', value printString! !


!Withdraw methodsFor: 'evaluating' stamp: 'CM 9/25/2017 21:06:45'!
affectBalance: balance 

	^ balance - self value! !

!Withdraw methodsFor: 'evaluating' stamp: 'FB 9/28/2017 12:42:31'!
balanceRequest: aConsultation

	^aConsultation manageWithdraw: self.! !

!Withdraw methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!classDefinition: #AccountTreeViewer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTreeViewer
	instanceVariableNames: 'account names'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTreeViewer methodsFor: 'as yet unclassified' stamp: 'CM 9/28/2017 15:47:42'!
initializeFor: anSummarizingAccount namingAccountWith: aDictionaryOfAccounts 

	account _ anSummarizingAccount. 
	names _ aDictionaryOfAccounts .! !

!AccountTreeViewer methodsFor: 'as yet unclassified' stamp: 'CM 9/28/2017 16:11:20'!
show
	
	^account showWith: self andDepth: ''! !

!AccountTreeViewer methodsFor: 'as yet unclassified' stamp: 'CM 9/28/2017 16:20:59'!
showPortfolio: aPorfolio withDepth: anString
	| lines |
	lines _ OrderedCollection new.
	lines add:(anString, (names at: aPorfolio )). 
	(aPorfolio accounts) do: [ :anAccount | lines addAll: ( anAccount showWith: self andDepth: (anString ,' ')) ].
	^ lines
	! !

!AccountTreeViewer methodsFor: 'as yet unclassified' stamp: 'CM 9/28/2017 16:20:47'!
showReceptiveAccount: aReceptiveAccount withDepth: anString
	| lines |
	lines _ OrderedCollection new.
	lines add:(anString, (names at: aReceptiveAccount )).
	^ lines
	! !

!AccountTreeViewer methodsFor: 'as yet unclassified' stamp: 'CM 9/28/2017 16:22:27'!
showReverse
	
	^ self show reverse! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTreeViewer class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTreeViewer class
	instanceVariableNames: ''!

!AccountTreeViewer class methodsFor: 'as yet unclassified' stamp: 'CM 9/28/2017 15:45:00'!
for: anSummarizingAccount namingAccountWith: aDictionaryOfAccounts

	^ (self new initializeFor: anSummarizingAccount namingAccountWith: aDictionaryOfAccounts )! !


!classDefinition: #BalanceRequest category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #BalanceRequest
	instanceVariableNames: 'managedAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!BalanceRequest methodsFor: 'initialization' stamp: 'FB 9/28/2017 11:18:41'!
initializeFor: anAccount

	managedAccount _ anAccount.
	! !


!BalanceRequest methodsFor: 'balance calculation' stamp: 'FB 9/28/2017 12:54:56'!
value

	^managedAccount transactions inject: 0 into: [ :balance :transaction | balance + (transaction balanceRequest: self) ]! !


!BalanceRequest methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:28:33'!
manageCertificateOfDeposit: aCertificateOfDeposit

	^0.! !

!BalanceRequest methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:28:44'!
manageDeposit: aDeposit

	^0.! !

!BalanceRequest methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:29:45'!
manageTransferDeposit: aTransferDeposit

	^0.! !

!BalanceRequest methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:29:35'!
manageTransferWithdraw: aTransferWithdraw

	^0.! !

!BalanceRequest methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:29:15'!
manageWithdraw: aWithdraw

	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BalanceRequest class' category: #'PortfolioTreePrinter-Ejercicio'!
BalanceRequest class
	instanceVariableNames: ''!

!BalanceRequest class methodsFor: 'instance creation' stamp: 'FB 9/28/2017 11:20:14'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #EarningsInvestmentsBalance category: #'PortfolioTreePrinter-Ejercicio'!
BalanceRequest subclass: #EarningsInvestmentsBalance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!EarningsInvestmentsBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:52:28'!
manageCertificateOfDeposit: aCertificateOfDeposit

	^((aCertificateOfDeposit value*(aCertificateOfDeposit tna/360)* aCertificateOfDeposit days) )! !


!classDefinition: #NetInvestmentsBalance category: #'PortfolioTreePrinter-Ejercicio'!
BalanceRequest subclass: #NetInvestmentsBalance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!NetInvestmentsBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:35:11'!
manageCertificateOfDeposit: aCertificateOfDeposit
	
	^aCertificateOfDeposit value.! !


!classDefinition: #NetTransfersBalance category: #'PortfolioTreePrinter-Ejercicio'!
BalanceRequest subclass: #NetTransfersBalance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!NetTransfersBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:38:44'!
manageTransferDeposit: aTransferDeposit
	
	^aTransferDeposit value.! !

!NetTransfersBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 12:44:25'!
manageTransferWithdraw: aTransferWithdraw
	
	^(aTransferWithdraw value negated).! !


!classDefinition: #ReceptiveAccountBalance category: #'PortfolioTreePrinter-Ejercicio'!
BalanceRequest subclass: #ReceptiveAccountBalance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccountBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 14:07:00'!
manageCertificateOfDeposit: aCertificateOfDeposit

	^(aCertificateOfDeposit value negated).! !

!ReceptiveAccountBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 14:07:23'!
manageDeposit: aDeposit

	^aDeposit value.! !

!ReceptiveAccountBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 14:06:40'!
manageTransferDeposit: aTransferDeposit
	
	^aTransferDeposit value.! !

!ReceptiveAccountBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 14:06:47'!
manageTransferWithdraw: aTransferWithdraw
	
	^(aTransferWithdraw value negated).! !

!ReceptiveAccountBalance methodsFor: 'transaction types management' stamp: 'FB 9/28/2017 14:10:15'!
manageWithdraw: aWithdraw

	^(aWithdraw value negated).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccountBalance class' category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountBalance class
	instanceVariableNames: ''!

!ReceptiveAccountBalance class methodsFor: 'instance creation' stamp: 'FB 9/28/2017 14:04:09'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:22'!
manages: anAccount

	^ self = anAccount  or: [ accounts anySatisfy: [ :managedAccount | managedAccount manages: anAccount  ]  ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'FB 9/23/2017 16:11:18'!
initializeWith: aCollectionOfAccounts

	accounts := aCollectionOfAccounts.

	! !

!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'account manage' stamp: 'CM 9/28/2017 15:59:34'!
accounts

	^accounts copy! !

!Portfolio methodsFor: 'account manage' stamp: 'CM 9/28/2017 16:18:18'!
showWith: aViewer andDepth: anString

	^ aViewer showPortfolio: self withDepth: anString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:48'!
with: anAccount1 with: anAccount2

	^ self withAll: (Array with: anAccount1 with: anAccount2 )! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:40'!
withAll: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size ifFalse: [ self error: self accountAlreadyManagedErrorMessage  ].
	
	aCollectionOfAccounts do: [ :sourceAccount | 
		aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ]]]].
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'FB 9/28/2017 14:09:36'!
balance

	^(ReceptiveAccountBalance for: self) value.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'account manage' stamp: 'CM 9/28/2017 16:19:24'!
showWith: aViewer andDepth: anString

	^ aViewer showReceptiveAccount: self withDepth: anString ! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value sourceAccount targetAccount withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'CM 9/26/2017 03:21:45'!
value
	
	^value.! !


!Transfer methodsFor: 'legs' stamp: 'CM 9/28/2017 15:25:45'!
depositLeg
	
	^ TransferDeposit for: self ! !

!Transfer methodsFor: 'legs' stamp: 'CM 9/28/2017 15:25:59'!
withdrawLeg
	
	^ TransferWithdraw for: self ! !


!Transfer methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:43'!
initializeFor: aValue from: aSourceAccount to: aTargetAccount

	value := aValue.
	sourceAccount := aSourceAccount.
	targetAccount := aTargetAccount! !

!Transfer methodsFor: 'initialization' stamp: 'CM 9/26/2017 04:26:27'!
intializeRegister: aAmount from: aSourceAccount  to: aTargetAccount

	value _ aAmount.
	sourceAccount _ aSourceAccount.
	targetAccount  _ aTargetAccount.
	
	withdrawLeg _ TransferWithdraw register: self on: aSourceAccount.
	depositLeg _ TransferDeposit register: self on: aTargetAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'movements' stamp: 'CM 9/26/2017 02:37:09'!
register: aAmount from: aSourceAccount  to: aTargetAccount
	
	^self new intializeRegister: aAmount from: aSourceAccount  to: aTargetAccount.
! !


!Transfer class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
for: aValue from: sourceAccount to: targetAccount

	^ self new initializeFor: aValue from: sourceAccount to: targetAccount! !
