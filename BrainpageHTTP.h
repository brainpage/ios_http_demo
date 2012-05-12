//
//  BrainpageHTTP.h
//  HttpApiDemo
//
//  Created by Jonathan Palley on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrainpageHTTP : NSObject
{
    NSMutableArray *_buffer;
    NSMutableArray *_posted_buffer;
 
}
-(id)init;
-(void)postData:(NSDictionary *)data for:(NSString *)uuid buffer:(int)bufferNum;
-(void)postData:(NSDictionary *)data at:(long)timestamp for:(NSString *)uuid buffer:(int)bufferNum;
@end
