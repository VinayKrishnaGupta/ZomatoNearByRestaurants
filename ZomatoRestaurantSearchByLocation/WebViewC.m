//
//  WebViewC.m
//  ZomatoRestaurantSearchByLocation
//
//  Created by IAUGMENTOR on 04/04/17.
//  Copyright © 2017 Vinay Krishna Gupta. All rights reserved.
//

#import "WebViewC.h"

@interface WebViewC ()

@end

@implementation WebViewC

- (void)viewDidLoad {
    [super viewDidLoad];
   

    NSURL *url = [NSURL URLWithString:_URLString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    
}



@end
