//
//  ProviderDelegate.h
//  Noteabout-Chat
//
//  Created by UserHanet on 9/13/16.
//  Copyright © 2016 Noteabout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>
#import <TwilioVoiceClient/TwilioVoiceClient.h>

@interface ProviderDelegate : NSObject <CXProviderDelegate>
- (instancetype) init;
- (void) reportIncomingCall;
@property (strong, nonatomic) TVOIncomingCall * currentIncomingCall;
@property (weak, nonatomic)  id<TVOIncomingCallDelegate> weakDelegate;
@end
