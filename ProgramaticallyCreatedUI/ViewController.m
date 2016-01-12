//
//  ViewController.m
//  ProgramaticallyCreatedUI
//
//  Created by Imran on 1/8/16.
//  Copyright © 2016 Fazle Rab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createLabel];
    [self createButton];
    [self createSegmentControl];
    [self createImageView];
    [self createScrollView];
    [self layoutAllViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createLabel {
    self.headerLabel = [[UILabel alloc] init];
    self.headerLabel.text = @"Header Message Label";
    self.headerLabel.font = [UIFont fontWithName:@"Futura-Bold" size:18.0];
    self.headerLabel.textColor = [UIColor whiteColor];
    self.headerLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.headerLabel];
}

- (void)createButton {
    self.headerButton = [[UIButton alloc] init];
    [self.headerButton setTitle:@"Header Button" forState:UIControlStateNormal];
    self.headerButton.backgroundColor = [UIColor lightGrayColor];
    
    [self.headerButton addTarget:self
                          action:@selector(handleHeaderButton:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.headerButton];
    
}

- (void)createSegmentControl {
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Ball", @"Bird"]];
    self.segmentControl.backgroundColor  = [UIColor cyanColor];
    [self.segmentControl addTarget:self action:@selector(handleSegmentControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
    
}

- (void) createImageView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageView];
}

- (void) createScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"README" withExtension:@"txt"];
    NSString *text = [[NSString alloc] initWithContentsOfFile:fileURL.path encoding:NSUTF8StringEncoding error:nil];
    
    UILabel *textContent = [[UILabel alloc] init];
    textContent.lineBreakMode = NSLineBreakByWordWrapping;
    textContent.numberOfLines = 0;
    [textContent setText:text];
    [textContent sizeToFit];
    
    [self.scrollView addSubview:textContent];
    [self.scrollView setContentSize:textContent.frame.size];
    
    [self.view addSubview:self.scrollView];
}

- (void) layoutAllViews {
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // *** Auto-Layout using LayoutAnchor *** //
    UILayoutGuide *margin = [self.view layoutMarginsGuide];
    
    // headerLabel.top = 1.0 * superView.topMargin + 20.0
    [self.headerLabel.topAnchor constraintEqualToAnchor:margin.topAnchor constant:20.0].active = YES;
    
    // headerLabel.centerX = 1.0 * superView.centerX + 0.0
    [self.headerLabel.centerXAnchor constraintEqualToAnchor:margin.centerXAnchor].active = YES;

    // *** Auto-Layout using NSLayoutConstraint *** //
    
    // headerButton.top = 1.0 * headerLabel.bottom + 20
    [NSLayoutConstraint constraintWithItem:self.headerButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.headerLabel
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:20.0].active = YES;
    
    // headerButton.leading = 1.0 * superView.leadingMargin + 0
    [NSLayoutConstraint constraintWithItem:self.headerButton
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // segmentControl.bottom = 1.0 * superView.centerY - 8.0
    [NSLayoutConstraint constraintWithItem:self.segmentControl
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:-8.0].active = YES;
    
    // segmentControl.trailing = 1.0 * superView.centerY + 4.0
    [NSLayoutConstraint constraintWithItem:self.segmentControl
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:4.0].active = YES;
    
    
    // *** Auto-Layout using Visual Format Language *** //
    NSDictionary *viewDict = @{@"segmentControl":self.segmentControl,
                               @"imageView"     :self.imageView,
                               @"scrollView"    :self.scrollView};
    
    NSMutableArray<NSLayoutConstraint *> *allConstraint = [[NSMutableArray alloc] init];
    NSArray<NSLayoutConstraint *> *constraints;
    
    // segmentControl.trailing = 1.0 * imageView.leading - standard
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[segmentControl]-[imageView]"
                                                          options:NSLayoutFormatAlignAllLeading
                                                          metrics:nil
                                                            views:viewDict];
    [allConstraint addObjectsFromArray:constraints];
    
    // scrollView.leading = 1.0 * superView.leadingMargin + 0.0
    // imageView.leading = 1.0 * scrollView.trailing + standard
    // superView.trailing >= 1.0 * imageView.trailing + 8.0
    // imageView.top = 1.0 * scrollView.top + 0.0
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[scrollView]-[imageView]-(>=8)-|"
                                                          options:NSLayoutFormatAlignAllTop
                                                          metrics:nil
                                                            views:viewDict];
    [allConstraint addObjectsFromArray:constraints];

    // superView.trailing = 1.0 *scrollView.trailing + 20.0
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[scrollView]-20-|"
                                                          options:NSLayoutFormatAlignAllTrailing
                                                          metrics:nil
                                                            views:viewDict];
    [allConstraint addObjectsFromArray:constraints];
    
    [NSLayoutConstraint activateConstraints:allConstraint];
}

- (void)handleHeaderButton:(UIButton *)sender {
    self.headerLabel.text = @"Header Button Pressed";
    
    self.headerLabel.backgroundColor = [UIColor blackColor];
    self.headerLabel.textColor = [UIColor whiteColor];
    
}

- (void)handleSegmentControl:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.headerLabel.text = @"Ball segement button pressed";
            self.headerLabel.backgroundColor = [UIColor blueColor];
            self.imageView.image = [UIImage imageNamed:@"soccerball.jpg"];
            break;
        case 1:
            self.headerLabel.text = @"Bird segement button pressed";
            self.headerLabel.backgroundColor = [UIColor magentaColor];
            self.imageView.image = [UIImage imageNamed:@"hummingBird.jpg"];
            break;
        default:
            break;
    }
}

@end
