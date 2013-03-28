//
//  FakeChartboost.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import "FakeChartboost.h"

@implementation FakeChartboost

- (id)init
{
    self = [super init];
    if (self) {
        self.requestedLocations = [NSMutableArray array];
        self.cachedInterstitials = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)startSession
{
    self.didStartSession = YES;
}

- (void)cacheInterstitial:(NSString *)location
{
    [self.requestedLocations addObject:location ? location : [NSNull null]];
}

- (BOOL)hasCachedInterstitial:(NSString *)location
{
    return [[self.cachedInterstitials objectForKey:location ? location : [NSNull null]] boolValue];
}

- (void)showInterstitial:(NSString *)location
{
    // chartboost doesn't actually need a view controller
    // this is here as a proxy
    self.presentingViewController = [[[UIViewController alloc] init] autorelease];
}

- (void)simulateLoadingLocation:(NSString *)location
{
    [self.delegate didCacheInterstitial:location];
}

- (void)simulateFailingToLoadLocation:(NSString *)location
{
    [self.delegate didFailToLoadInterstitial:location];
}

- (void)simulateUserTap:(NSString *)location
{
    [self.delegate didClickInterstitial:location];
    [self simulateUserDismissingLocation:location]; //Chartboost always dismisses the ad when clicked
}

- (void)simulateUserDismissingLocation:(NSString *)location
{
    self.presentingViewController = nil;
    [self.delegate didDismissInterstitial:location];
    [self.cachedInterstitials removeObjectForKey:location ? location : [NSNull null]];
}

@end