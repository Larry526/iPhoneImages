//
//  ViewController.m
//  iPhoneImages
//
//  Created by Larry Luk on 2017-11-20.
//  Copyright © 2017 Larry Luk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (strong, nonatomic) NSArray <NSString *>* imageArrayURL;
@property (assign, nonatomic) NSInteger imageIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArrayURL = @[@"https://imgur.com/bktnImE.png", @"https://imgur.com/zdwdenZ.png", @"https://imgur.com/CoQ8aNl.png", @"https://imgur.com/2vQtZBb.png", @"https://imgur.com/y9MIaCS.png"];
    
    [self getImageData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomPressed:(id)sender {
    
    self.imageIndex = arc4random_uniform(5);
    NSLog(@"%li", self.imageIndex);
    [self getImageData];
    
}

-(void) getImageData {
    
    NSURL *url = [NSURL URLWithString:self.imageArrayURL[self.imageIndex]]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
        
    }]; // 4
    
    [downloadTask resume]; // 5
    
}


@end
