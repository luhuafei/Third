#import "Kiwi.h"
#import "YFKiwiSample.h"

SPEC_BEGIN(SpecName)

describe(@"ClassName", ^{
    registerMatchers(@"BG"); // 注册 BGTangentMatcher, BGConvexMatcher 等.
    
    context(@"a state the component is in", ^{
        let(variable, ^{ // 在每个包含的 "it" 执行前执行执行一次.
            return [[YFKiwiSample alloc]init];
        });
        
        beforeAll(^{ // 执行一次
            NSLog(@"beforAll");
        });
        
        afterAll(^{ // Occurs once
            NSLog(@"afterAll");
        });
        
        beforeEach(^{ // 在每个包含的 "it" 执行前,都执行一次.
            NSLog(@"beforeEach");
        });
        
        afterEach(^{ // 在每个包含的 "it" 执行后,都执行一次.
            NSLog(@"afterEach");
        });
        
        it(@"should do something", ^{
            NSLog(@"should do something");
//            [[variable should] meetSomeExpectation];
        });
        
        specify(^{
            NSLog(@"specify");
            [[variable shouldNot] beNil];
        });
        
        context(@"inner context", ^{
            NSLog(@"inner context");
            it(@"does another thing", ^{
                NSLog(@"does another thing");
            });
            
            pending(@"等待实现的东西", ^{
                NSLog(@"等待实现的东西");
            });
        });
    });
});

SPEC_END