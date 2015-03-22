//
//  MCMusicPlayer.h
//  MCMusic
//
//  Created by xcode on 1/19/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

#import <UIKit/UIKit.h>

// to implement:
//
//    player.songNameAndExtention = "Highstrung.mp3"
//    player.playMusic()
//

@interface MCMusicPlayer : NSObject


  @property NSString *songNameAndExtention;  // this will pull out of app bundle, may wish to allow to get elsewhere?
  @property float startAtBeginingOrXSecondsIn;  // how many seconds in do you want to start?
  @property float volume;
  @property BOOL repeatAlways;
  @property int repeatXNumberOfTimes;

  @property BOOL resumeWhenReturnFromBackground;
  @property BOOL resumeFromWhereLeftOffWhenReopen;  // not implemented (just save to NSUserDefaults)


  -(void)playMusic;

  -(void)fadeMusicThenPause;
  -(void)fadeMusicThenStop;
  -(void)stopMusic;
  -(void)pauseMusic;
  -(void)unpauseMusic;


@end
