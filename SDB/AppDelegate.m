#define RESET_DOMAIN_EACH_TIME NO

#import "AppDelegate.h"


@interface AppDelegate() {
    //SDBOperation *currentOperation;
    int selectorIndex;
    NSMutableArray *selectors_;
}

- (void)doNext;

@end

@implementation AppDelegate

@synthesize window = _window;

#pragma mark - Example Code

- (void)startTest {
    if (RESET_DOMAIN_EACH_TIME) {
        [selectors_ insertObject:[NSValue valueWithPointer:@selector(createNewDomain)] atIndex:0];
        [selectors_ insertObject:[NSValue valueWithPointer:@selector(deleteDomain)] atIndex:0];
    }
    
    [self doNext];
}

- (void)doNext {
    selectorIndex++;
    
    if (selectorIndex <= selectors_.count) {
        SEL nextOperation = [[selectors_ objectAtIndex:selectorIndex-1] pointerValue];
        [self performSelector:nextOperation];
    }
    else
        NSLog(@"All Tests Complete!");
}

- (NSDictionary *)exampleItem {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:@"1" forKey:@"Attribute1"];
    [attributes setValue:@"2" forKey:@"Attribute2"];
    [attributes setValue:@"three" forKey:@"Attribute3"];
    return [NSDictionary dictionaryWithDictionary:attributes];
}

- (NSDictionary *)multiData {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]] forKey:@"Timestamp"];
    return [NSDictionary dictionaryWithDictionary:attributes];
}


- (NSDictionary *)exampleItems {
    NSMutableDictionary *items = [NSMutableDictionary dictionary];
    [items setValue:[self exampleItem] forKey:@"Item4"];
    [items setValue:[self exampleItem] forKey:@"Item5"];
    [items setValue:[self exampleItem] forKey:@"Item6"];
    return [NSDictionary dictionaryWithDictionary:items];
}


- (void)createNewDomain {
    [SDB createDomain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)deleteDomain {
    [SDB deleteDomain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)putItem1 {
    [SDB putItem:@"Item1" withAttributes:[self exampleItem] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)putItem2 {
    [SDB putItem:@"Item2" withAttributes:[self exampleItem] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)putItem3 {
    [SDB putItem:@"Item3" withAttributes:[self exampleItem] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)putMulti {
    [SDB putMultiItem:@"MultiItem" withAttributes:[self multiData] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)getMulti {
    [SDB getItem:@"MultiItem" withAttributes:[NSArray arrayWithObjects:nil] readMultiValue:YES domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)batchPutItems {
    [SDB putItems:[self exampleItems] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)listItems {
    [SDB selectWithExpression:@"select * from Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)getItem {
    [SDB getItem:@"Item1" withAttributes:[NSArray arrayWithObjects:@"Attribute1", @"Attribute2", nil] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)deleteItem {
    [SDB deleteItem:@"Item1" withAttributes:nil domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

- (void)batchDeleteItems {
    [SDB deleteItems:[self exampleItems] domain:@"Tester" block:^(NSDictionary *sdbData, SDBOperation* operation) {
        if (operation.failed)
            NSLog(@"Operation %@:\n%@", operation.class, sdbData);    
        else
            NSLog(@"Got data from %@:\n%@", operation.class, sdbData);
        
        [self doNext];
    }];
}

/**
 Example/Test for all SDBOperations
 */

- (void)sdbExample {
    [SDB setAccessKey:ACCESS_KEY andSecretKey:SECRET_KEY];
    
    if (![SDB accessKeysSet]) {
        NSLog(@"Add your API keys!");
        exit(0);
    }
    
    selectorIndex = 0;
    selectors_ = [NSMutableArray arrayWithObjects:
                  [NSValue valueWithPointer:@selector(putItem1)],
                  [NSValue valueWithPointer:@selector(putItem2)],
                  [NSValue valueWithPointer:@selector(putItem3)],
                  [NSValue valueWithPointer:@selector(batchPutItems)],
                  [NSValue valueWithPointer:@selector(listItems)], 
                  [NSValue valueWithPointer:@selector(getItem)], 
                  [NSValue valueWithPointer:@selector(deleteItem)], 
                  [NSValue valueWithPointer:@selector(listItems)],
                  [NSValue valueWithPointer:@selector(batchDeleteItems)],
                  [NSValue valueWithPointer:@selector(listItems)],
                  [NSValue valueWithPointer:@selector(putMulti)],
                  [NSValue valueWithPointer:@selector(putMulti)],  // note: putMulti is repeated
                  [NSValue valueWithPointer:@selector(getMulti)], 
                  nil];
    
    [self startTest];
}

#pragma mark - SDB Delegate

- (void)didReceiveSDBData:(NSDictionary *)sdbData fromOperation:(SDBOperation *)operation {

}

#pragma mark - App Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self sdbExample];
    return YES;
}

@end