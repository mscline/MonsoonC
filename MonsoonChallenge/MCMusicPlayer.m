//
//  MCMusicPlayer.m
//  MCMusic
//
//  Created by xcode on 1/19/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

#import "MCMusicPlayer.h"
#import <AVFoundation/AVFoundation.h>


@interface MCMusicPlayer()

  @property AVAudioPlayer *musicAndPlayer;

@end

@implementation MCMusicPlayer
  @synthesize musicAndPlayer, repeatAlways, repeatXNumberOfTimes, volume, songNameAndExtention, startAtBeginingOrXSecondsIn, resumeFromWhereLeftOffWhenReopen, resumeWhenReturnFromBackground;


#pragma mark SETUP

-(instancetype)init
{
    self = [super init];

    if(self){


        [self addObserverToMinitorWhenAppSentToOrReturnedFromBackground];

    }

    return self;

}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    // do not call [super initWithCoder: ], NSObject does not implement, so just do it here
    if (self) {

    }
    return self;
}

-(void)addObserverToMinitorWhenAppSentToOrReturnedFromBackground
{

    // add Observer - want to be able to respond to application events, eg, incoming data
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector( appActivated: )
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object: nil];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector( appDeActivated: )
                                                 name: UIApplicationWillResignActiveNotification
                                               object: nil];

}

-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self ];

}


#pragma mark RESPOND TO ACTIVATION / DEACTIVATION

- (void)appActivated:(NSNotification *)note
{

    if(resumeWhenReturnFromBackground){

        [self playMusic];  // thus, creating a new instance of music player

    }

}

- (void)appDeActivated:(NSNotification *)note
{

    // save where we are at in the song
    startAtBeginingOrXSecondsIn = musicAndPlayer.currentTime;

    // when deactivated, Apple looses the pointer to the music player
    // so we need to get rid of the music player and create a new one when return

    [musicAndPlayer stop];
    musicAndPlayer = nil;

}


#pragma mark PLAYING MUSIC

-(void)playMusic
{

    NSError *error;

    musicAndPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self getURLForSongWithNameAndExtention:songNameAndExtention] error:&error];

    // if error
    if (musicAndPlayer == nil) {
        NSLog(@"%@",[error description]);
        return;
    }

    [self setMusicPlayerSettings];
    [musicAndPlayer play];


}

-(void)setMusicPlayerSettings
{

    // settings - should repeat
    musicAndPlayer.numberOfLoops = repeatXNumberOfTimes;

    if(repeatAlways){

        musicAndPlayer.numberOfLoops = -1;  // -1 means will loop

    }

    // settings - volume
    if(volume == 0 ){

        [musicAndPlayer setVolume: .6];
        
    }

    // settings - start at time (default = start at begining, ie zereo seconds)
    musicAndPlayer.currentTime = startAtBeginingOrXSecondsIn;   // start from begining?  ie, t=0

}

-(NSURL *)getURLForSongWithNameAndExtention:(NSString *)theSongName
{

    // get file from the app bundle (it is not in the documents folder)
    NSString *tempStr = [NSString stringWithFormat:@"%@/", [[NSBundle mainBundle] resourcePath]];
    tempStr = [NSString stringWithFormat:@"%@%@", tempStr, theSongName];
    NSURL *url = [NSURL fileURLWithPath:tempStr];

    return url;
}


#pragma mark SAVE FILE

// ??? http://stackoverflow.com/questions/22060806/save-song-to-document-directory-from-ios-music-library

-(void)saveFileNamed:(NSString *)name nsData:(NSData *)music
{
    // check to see if file name already taken ????

    NSURL *url = [self getURLForSongWithNameAndExtention:name];
    [music writeToURL:url atomically:YES];

}

-(void)deleteFileNamed:(NSString *)name
{

}


#pragma mark STOP MUSIC

-(void)fadeMusicThenPause
{

    musicAndPlayer.volume -= .1;

    if (musicAndPlayer.volume <= 0) {

        [musicAndPlayer pause];

    }else{

        [self performSelector:@selector(fadeMusicThenPause) withObject:nil afterDelay:.3];
    }
    
    
}

-(void)fadeMusicThenStop
{

    musicAndPlayer.volume -= .1;

    if (musicAndPlayer.volume <= 0) {

        [musicAndPlayer stop];

    }else{

        [self performSelector:@selector(fadeMusicThenPause) withObject:nil afterDelay:.3];
    }
    
    
}

-(void)pauseMusic
{

    [musicAndPlayer pause];

}

-(void)unpauseMusic
{
    
    [self setMusicPlayerSettings];      // if fade out, need to reset volumne
    [musicAndPlayer play];              // will resume from where was

}

-(void)stopMusic
{

    [musicAndPlayer stop];
    musicAndPlayer = nil;
    
}


#pragma mark NSCODING




@end

