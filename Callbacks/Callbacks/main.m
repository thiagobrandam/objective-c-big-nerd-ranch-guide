//
//  main.m
//  Callbacks
//
//  Created by thiago on 5/24/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"
#import "BNRObserver.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BNRLogger *logger = [[BNRLogger alloc] init];
        
//        [[NSNotificationCenter defaultCenter] addObserver:logger
//                                                 selector:@selector(zoneChange:)
//                                                     name:NSSystemTimeZoneDidChangeNotification
//                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserverForName:NSSystemTimeZoneDidChangeNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *note) {
                                                          NSLog(@"The system zone has changed!");
                                                      }];
        
        
        
        NSURL *url = [NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
       __unused NSURLConnection *fetchConn
            = [[NSURLConnection alloc] initWithRequest:request
                                              delegate:logger
                                      startImmediately:YES];
        
       __unused NSTimer *timer
            = [NSTimer scheduledTimerWithTimeInterval:2.0
                                               target:logger
                                             selector:@selector(updateLastTime:)
                                             userInfo:nil
                                              repeats:YES];
        __unused BNRObserver *observer
        = [[BNRObserver alloc] init];
        
        [logger addObserver:observer
                 forKeyPath:@"lastTimeString"
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                    context:nil];        
        
        [[NSRunLoop currentRunLoop] run];
        
        
    }
    return 0;
}

