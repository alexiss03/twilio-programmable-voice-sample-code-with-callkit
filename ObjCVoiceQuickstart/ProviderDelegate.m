//
//  ProviderDelegate.m
//  Mary Alexis Solis
//
//  Created by Mary Alexis Solis on 9/13/16.
//  Copyright © 2016 Noteabout. All rights reserved.
//

#import "ProviderDelegate.h"


@interface ProviderDelegate()

@property (strong, nonatomic) CXProvider *provider;
//@property (strong, nonatomic) VoiceVideoCallClientInteractor * callManager;
@property (strong, nonatomic) CXCallController* callController;


@end

@implementation ProviderDelegate

- (instancetype) init
{
    self = [super init];
    
    if (self) {
        
        _callController = [CXCallController  new];
        _provider = [[CXProvider alloc] initWithConfiguration:
                    [ProviderDelegate providerConfiguration]];
        [_provider setDelegate:self queue:nil];
    }

    return self;
}


+ (CXProviderConfiguration *) providerConfiguration {
    
    static CXProviderConfiguration * providerConfiguration;
    
    if (!providerConfiguration) {
        providerConfiguration = [[CXProviderConfiguration alloc] initWithLocalizedName:@"Noteabout Chat"];
        providerConfiguration.maximumCallGroups = 1;
        providerConfiguration.ringtoneSound = @"video-call-incoming.mp3";
        providerConfiguration.maximumCallsPerCallGroup = 1;
    }
    
    return providerConfiguration;
}


#pragma mark - Incoming Calls

- (void) reportIncomingCall
{
    
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        NSString *userId = @"Test User";
        NSUUID * uuid = [NSUUID UUID];
        BOOL hasVideo = YES;
        
        CXCallUpdate * update = [CXCallUpdate new];
        update.localizedCallerName = userId;
        update.hasVideo = hasVideo;
        
        [_provider reportNewIncomingCallWithUUID:uuid update:update completion:^(NSError * error){
            if (error == nil) {
                
            }
        }];
    }
}



#pragma mark - CXProviderDelegate

- (void) provider:(CXProvider *)provider performAnswerCallAction:(CXAnswerCallAction *) action
{
    if (self.currentIncomingCall) {
        [self.currentIncomingCall acceptWithDelegate:self.weakDelegate];
    }
    [action fulfill];
}


- (void) provider:(CXProvider *)provider performEndCallAction:(CXEndCallAction *) action
{
    
    [action fulfill];
    
}

- (void) providerDidReset:(CXProvider *)provider {
    
}

@end
