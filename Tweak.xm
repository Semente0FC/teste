%hook SKPaymentQueue

- (void)addPayment:(SKPayment *)payment {
    NSLog(@"[FakePurchase] Intercepted addPayment for product: %@", payment.productIdentifier);

    // Transação falsa
    SKMutablePayment *fakePayment = [SKMutablePayment paymentWithProductIdentifier:payment.productIdentifier];
    id fakeTransaction = [[NSClassFromString(@"SKPaymentTransaction") alloc] init];

    if ([fakeTransaction respondsToSelector:@selector(setTransactionState:)]) {
        [fakeTransaction setValue:@1 forKey:@"transactionState"]; // SKPaymentTransactionStatePurchased
        [fakeTransaction setValue:fakePayment forKey:@"payment"];
        [fakeTransaction setValue:[NSDate date] forKey:@"transactionDate"];
    }

    if ([self.delegate respondsToSelector:@selector(paymentQueue:updatedTransactions:)]) {
        [self.delegate paymentQueue:self updatedTransactions:@[fakeTransaction]];
    } else {
        NSLog(@"[FakePurchase] Delegate não respondeu ao seletor paymentQueue:updatedTransactions:");
    }
}

%end

%ctor {
    @autoreleasepool {
        NSLog(@"[FakePurchase] .dylib carregada com sucesso");
    }
}
