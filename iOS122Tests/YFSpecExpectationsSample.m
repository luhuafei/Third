#import "Kiwi.h"
#import "YFKiwiCar.h"
#import "YFKiwiFlyingMachine.h"

SPEC_BEGIN(CarSpec)

describe(@"YFKiwiCar", ^{
    it(@"A Car Rule", ^{
        
        id car = [YFKiwiCar new];
        [[car should] beKindOfClass:[YFKiwiCar class]];
        [[car shouldNot] conformToProtocol:@protocol(NSCopying)];
        [[[car should] have:4] wheels];
        
        [[theValue([(YFKiwiCar *)car speed]) should] equal:theValue(42.0f)];
        [[car should] receive:@selector(changeToGear:) withArguments: theValue(3)]; 
        
        [car changeToGear: 3];
    });
    
    it(@"Scalar packing",^{
        [[theValue(1 + 1) should] equal:theValue(2)];
        [[theValue(YES) shouldNot] equal:theValue(NO)];
        [[theValue(20u) should] beBetween:theValue(1) and:theValue(30.0)];
        
        YFKiwiCar * car = [YFKiwiCar new];
        [[theValue(car.speed) should] beGreaterThan:theValue(40.0f)];
    });
    
    it(@"Message Pattern", ^{
        YFKiwiCar * cruiser = [[YFKiwiCar alloc]init];
        
        [[cruiser should] receive:@selector(jumpToStarSystemWithIndex:) withArguments: theValue(3)];
        
        [cruiser jumpToStarSystemWithIndex: 3];
    });
    
    it(@"Expectations: Count changes", ^{
        NSMutableArray * array = [NSMutableArray arrayWithCapacity: 42];
        
        [[theBlock(^{
            [array addObject:@"foo"];
        }) should] change:^{
            return (NSInteger)[array count];
        } by:+1];
        
        [[theBlock(^{
            [array addObject:@"bar"];
            [array removeObject:@"foo"];
        }) shouldNot] change:^{ return (NSInteger)[array count]; }];
        
        [[theBlock(^{
            [array removeObject:@"bar"];
        }) should] change:^{ return (NSInteger)[array count]; } by:-1];
    });
    
    it(@"Selector", ^{
        id car = [[YFKiwiCar alloc] init];
        
        [[car should] receive:@selector(jumpToStarSystemWithIndex:)];
        
        [[car should]receive: @selector(jumpToStarSystemWithIndex:) withArguments:theValue(2)];
        
        [car jumpToStarSystemWithIndex: 2];
    });
    
    it(@"Notification", ^{
        [[@"自定义通知" should] bePosted];
        
        NSNotification *myNotification = [NSNotification notificationWithName:@"自定义通知"
                                                                       object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:myNotification];
    });
    
    it(@"shouldEventually", ^{
        id car = [[YFKiwiCar alloc] init];
        
        
        [[car shouldEventually] receive: @selector(jumpToStarSystemWithIndex:)];
        
        [car jumpToStarSystemWithIndex:2.0];
    });
    
    it(@"Mock", ^{
        id carMock = [YFKiwiCar mock];
        [ [carMock should] beMemberOfClass:[YFKiwiCar class]];
        [ [carMock should] receive:@selector(currentGear) andReturn:theValue(3)];
        [ [theValue([carMock currentGear]) should] equal:theValue(3)];
        
        id carNullMock = [YFKiwiCar nullMock];
        [ [theValue([carNullMock currentGear]) should] equal:theValue(0)];
        [carNullMock applyBrakes];
        
        id flyerMock = [KWMock mockForProtocol:@protocol(YFKiwiFlyingMachine)];
        [ [flyerMock should] conformToProtocol:@protocol(YFKiwiFlyingMachine)];
        [flyerMock stub:@selector(dragCoefficient) andReturn:theValue(17.0f)];
        
        id flyerNullMock = [KWMock nullMockForProtocol:@protocol(YFKiwiFlyingMachine)];
        [flyerNullMock takeOff];
    });
    
    it(@"stub", ^{
       	id robotMock = [KWMock nullMockForClass:[YFKiwiCar class]];
        KWCaptureSpy *spy = [robotMock captureArgument:@selector(speak:afterDelay:whenDone:) atIndex:2];
        
        [[robotMock should] receive:@selector(speak:) withArguments:@"Goodbye"];
        
        [robotMock speak:@"Hello" afterDelay:2 whenDone:^{
            [robotMock speak:@"Goodbye"];
        }];
        
        void (^block)(void) = spy.argument;
        block();
    });
});

SPEC_END