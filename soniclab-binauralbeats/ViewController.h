//
//  ViewController.h
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/24/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLAudioController.h"

@interface ViewController : UIViewController{
    SLAudioController *audioController;
}

@property(strong, nonatomic) UILabel* channelLLabel;
@property(strong, nonatomic) UILabel* channelRLabel;

@property(strong, nonatomic) UISlider* channelLSlider;
@property(strong, nonatomic) UISlider* channelRSlider;



@end

