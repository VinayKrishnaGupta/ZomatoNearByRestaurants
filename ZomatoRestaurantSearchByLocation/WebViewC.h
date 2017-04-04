//
//  WebViewC.h
//  ZomatoRestaurantSearchByLocation
//
//  Created by IAUGMENTOR on 04/04/17.
//  Copyright © 2017 Vinay Krishna Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewC : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,retain) NSString *URLString;

@end
