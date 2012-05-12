//
//  BrainpageHTTP.m
//  HttpApiDemo
//
//  Created by Jonathan Palley on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrainpageHTTP.h"
#define POST_URL    @"http://localhost:8080/v1/api/sensors/%@/data"
#define API_TOKEN   @"token"
#define API_SECRET_KEY  @"secret"
@implementation BrainpageHTTP
-(id)init{
    _buffer = [NSMutableArray arrayWithCapacity:30];
    _posted_buffer = [NSMutableArray arrayWithCapacity:30];
    return self;
}
//////////////////////////////
// postData (without timestamp)
// See documentation for postData below
// This version of the function simply does not require a timestamp
-(void)postData:(NSDictionary *)data for:(NSString *)uuid buffer:(int)bufferNum
{
    long timestamp = (long)[[NSDate date] timeIntervalSince1970];
    [self postData:data at:timestamp for:uuid buffer:bufferNum];
}

///////////////////////////////
// postData: Posts sensor data to server. Automatically keeps buffer
// data: NSDictionary object containing {feature, value} pairs.  
// timestamp: UTC timestamp
// buffer: number of items to keep in buffer before sending to server.  Can save bandwidth/battery/etc. if lots of data is being collected rapidly
//
// NOTES:
// 1. A "feature" is essentially an attribute of a sensor being tracked.
// 1. New "features" are automatically added by the server.  Max of 255 features.
// 2. "Value" can either by a string or integer.  Multiple decime numbers and cast as integer.  Decimal values will cause undefined results
///////////////////////////////
-(void)postData:(NSDictionary *)data at:(long)timestamp for:(NSString *)uuid buffer:(int)bufferNum{
   
    NSDictionary *data_packet = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLong:timestamp], @"timestamp",data, @"data", nil];
    
    [_buffer addObject:data_packet];
    if ([_buffer count] >= bufferNum) {
        
        //This isn't entirely safe, but hopefully good enough for now.
        //We don't want to clear the buffer until the server returns 200, but we also
        //do not want to clear out new data that arrived while waiting.
        [_posted_buffer addObjectsFromArray:_buffer];
        [_buffer removeAllObjects];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_posted_buffer options:nil error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(jsonString);
        NSString *URL = [NSString stringWithFormat:POST_URL, uuid];
        NSLog(URL);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:jsonData];
        [request setValue:API_TOKEN forHTTPHeaderField:@"api_token"];
        [request setValue:API_SECRET_KEY forHTTPHeaderField:@"api_secret_key"];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    
    }
   

}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_posted_buffer removeAllObjects];
}
@end
