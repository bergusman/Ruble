//
//  ViewController.m
//  Ruble
//
//  Created by Vitaly Berg on 17/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (strong, nonatomic) AVQueuePlayer *player;

@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) double usd;
@property (assign, nonatomic) double eur;

@property (weak, nonatomic) IBOutlet UILabel *USDLabel;
@property (weak, nonatomic) IBOutlet UILabel *EURLabel;

@property (weak, nonatomic) IBOutlet UILabel *USDTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *EURTitleLabel;

@property (strong, nonatomic) NSArray *items;

@end

@implementation ViewController

- (void)fire:(NSTimer *)timer {
    NSURL *url = [NSURL URLWithString:@"https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDRUB,EURRUB%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    double usd = [json[@"query"][@"results"][@"rate"][0][@"Rate"] doubleValue];
                    double eur = [json[@"query"][@"results"][@"rate"][1][@"Rate"] doubleValue];
                    
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.decimalSeparator = @",";
                    formatter.minimumFractionDigits = 2;
                    formatter.maximumFractionDigits = 2;
                    
                    self.USDLabel.text = [formatter stringFromNumber:@(usd)];
                    self.EURLabel.text = [formatter stringFromNumber:@(eur)];
                    
                    if (usd > self.usd) {
                        self.USDLabel.textColor = [UIColor colorWithRed:(202/255.0) green:(239/255.0) blue:(175/255.0) alpha:0.8];
                    } else {
                        self.USDLabel.textColor = [UIColor colorWithRed:(239/255.0) green:(175/255.0) blue:(175/255.0) alpha:0.8];
                    }
                    
                    if (eur > self.eur) {
                        self.EURLabel.textColor = [UIColor colorWithRed:(202/255.0) green:(239/255.0) blue:(175/255.0) alpha:0.8];
                    } else {
                        self.EURLabel.textColor = [UIColor colorWithRed:(239/255.0) green:(175/255.0) blue:(175/255.0) alpha:0.8];
                    }
                    
                    NSShadow *shadow = [[NSShadow alloc] init];
                    shadow.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
                    shadow.shadowBlurRadius = 3;
                    
                    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.USDLabel.text attributes:@{NSShadowAttributeName: shadow}];
                    self.USDLabel.attributedText = attributedText;
                    
                    attributedText = [[NSAttributedString alloc] initWithString:self.EURLabel.text attributes:@{NSShadowAttributeName: shadow}];
                    self.EURLabel.attributedText = attributedText;
                    
                    self.USDTitleLabel.textColor = self.USDLabel.textColor;
                    self.EURTitleLabel.textColor = self.EURLabel.textColor;
                    
                    attributedText = [[NSAttributedString alloc] initWithString:self.USDTitleLabel.text attributes:@{NSShadowAttributeName: shadow}];
                    self.USDTitleLabel.attributedText = attributedText;
                    
                    attributedText = [[NSAttributedString alloc] initWithString:self.EURTitleLabel.text attributes:@{NSShadowAttributeName: shadow}];
                    self.EURTitleLabel.attributedText = attributedText;
                    
                    self.usd = usd;
                    self.eur = eur;
                });
            }
        }
    }] resume];
}

- (void)didEndPlay:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:notification.object];
    
    NSArray *videos = @[@"natasha.mp4", @"vanessa.mp4", @"snejanna.mp4", @"girls.mp4", @"girl2.mp4", @"anya.mp4", @"katya.mp4", @"vera.mp4", @"marina.mp4"];
    NSMutableArray *playerItems = [NSMutableArray array];
    
    for (NSString *video in videos) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:video withExtension:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        [playerItems addObject:playerItem];
    }
    
    self.items = playerItems;
    
    AVPlayerItem *playerItem = [playerItems lastObject];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    self.player = [AVQueuePlayer queuePlayerWithItems:self.items];
    self.player.volume = 0;
    
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)self.view.layer;
    playerLayer.player = self.player;
    
    [self.player play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *videos = @[@"natasha.mp4", @"vanessa.mp4", @"snejanna.mp4", @"girls.mp4", @"girl2.mp4", @"anya.mp4", @"katya.mp4", @"vera.mp4", @"marina.mp4"];
    NSMutableArray *playerItems = [NSMutableArray array];
    
    for (NSString *video in videos) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:video withExtension:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        [playerItems addObject:playerItem];
    }
    
    self.items = playerItems;
    
    AVPlayerItem *playerItem = [playerItems lastObject];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];

    self.player = [AVQueuePlayer queuePlayerWithItems:playerItems];
    self.player.volume = 0;
    
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)self.view.layer;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerLayer.player = self.player;
    
    [self.player play];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    [self fire:nil];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    //self.playerLayer.frame = CGRectMake(0, 0, size.width, size.height);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
