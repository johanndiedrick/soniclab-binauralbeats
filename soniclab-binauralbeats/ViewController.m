//
//  ViewController.m
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/24/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    audioController = [[SLAudioController alloc] init];
    [audioController createOscillators];
    [audioController initAudioController];
    [audioController startAudioUnit];
    
    //  Add a button to the main view to toggle playback
    UIButton* playbackToggleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playbackToggleButton setFrame:CGRectMake(20, 20, 280, 80)];
    [playbackToggleButton setTitle:@"Toggle Playback" forState:UIControlStateNormal];
    [playbackToggleButton addTarget:self action:@selector(togglePlayback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbackToggleButton];
    
}

-(void)togglePlayback   {
    [audioController togglePlayback];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
