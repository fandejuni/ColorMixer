//
//  ColorMixerAppDelegate.h
//  ColorMixer
//
//  Created by Thibault Dardinier on 20/05/11.
//  Copyright 2011 Aucune. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface ColorMixerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end
