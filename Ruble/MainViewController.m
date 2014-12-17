//
//  MainViewController.m
//  Ruble
//
//  Created by Vitaly Berg on 18/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "MainViewController.h"

#import "Quotes.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *usdLabel;
@property (weak, nonatomic) IBOutlet UILabel *eurLabel;

@property (weak, nonatomic) IBOutlet UILabel *quoteTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *quoteWhoLabel;
@property (weak, nonatomic) IBOutlet UILabel *quoteJobLabel;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSNumber *usd;
@property (strong, nonatomic) NSNumber *eur;

@property (strong, nonatomic) NSNumberFormatter *rateFormatter;

@end

@implementation MainViewController

#pragma mark - Helper

- (void)setText:(NSString *)text asAttributedToLabel:(UILabel *)label {
    NSMutableAttributedString *string = [label.attributedText mutableCopy];
    [string replaceCharactersInRange:NSMakeRange(0, label.attributedText.length) withString:text];
    label.attributedText = string;
}

#pragma mark - Setups

- (void)setupRateFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.decimalSeparator = @",";
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    self.rateFormatter = formatter;
}

#pragma mark - Content

- (void)fillQuote {
    Quote *quote = [[Quotes quotesFromJSONWithName:@"Quotes.json"] randomQuote];
    [self setText:quote.text asAttributedToLabel:self.quoteTextLabel];
    [self setText:quote.job asAttributedToLabel:self.quoteJobLabel];
    self.quoteWhoLabel.text = quote.who;
}

- (void)loadRatesWithCompletion:(void (^)(NSNumber *usd, NSNumber *eur, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDRUB,EURRUB%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (completion) {
                    completion(nil, nil, error);
                }
            }
            
            if (data) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (json) {
                    double usd = [json[@"query"][@"results"][@"rate"][0][@"Rate"] doubleValue];
                    double eur = [json[@"query"][@"results"][@"rate"][1][@"Rate"] doubleValue];
                    if (completion) {
                        completion(@(usd), @(eur), nil);
                    }
                } else {
                    if (completion) {
                        completion(nil, nil, nil);
                    }
                }
            } else {
                if (completion) {
                    completion(nil, nil, nil);
                }
            }
        });
        
        if (data) {
            
        }
    }] resume];
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
}

- (void)timerDidFire:(NSTimer *)timer {
    [self loadAndFillRates];
}

- (void)loadAndFillRates {
    [self loadRatesWithCompletion:^(NSNumber *usd, NSNumber *eur, NSError *error) {
        if (usd && eur) {
            self.shareButton.enabled = YES;
            
            self.usdLabel.text = [self.rateFormatter stringFromNumber:usd];
            self.eurLabel.text = [self.rateFormatter stringFromNumber:eur];
            
            self.usd = usd;
            self.eur = eur;
        }
    }];
}

- (void)trash {
    /*
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
     */
}

- (void)shareRates {
    NSString *text = [NSString stringWithFormat:@"Доллар — %@\nЕвро — %@\nСкачай приложение «Курс валют» в AppStore.", [self.rateFormatter stringFromNumber:self.usd], [self.rateFormatter stringFromNumber:self.eur]];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)shareButtonTouchUpInside:(id)sender {
    [self shareRates];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shareButton.enabled = NO;
    
    [self setupRateFormatter];
    [self fillQuote];
    [self startTimer];
    [self loadAndFillRates];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
