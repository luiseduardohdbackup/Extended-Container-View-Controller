#import "ContainerViewController.h"

@interface ContainerViewController ()

@property(strong, nonatomic) NSString *currentSegueIdentifier;
@end

@implementation ContainerViewController {
    NSMutableArray      *_segues;
    NSMutableDictionary *_segue_map;
}

- (void)awakeFromNib; {
    [super awakeFromNib];

    _segues = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *templates = [self performSelector:NSSelectorFromString(@"storyboardSegueTemplates")];
    [templates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *identifier = [obj performSelector:NSSelectorFromString(@"identifier")];
        NSLog(@"%@", identifier);

        [_segues addObject:identifier];
    }];

    [self segueToIndex:0];
}

- (void)segueToIndex:(NSUInteger)i; {
    [self segueToIdentifier:_segues[i]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if (!_segue_map) {
        _segue_map = [NSMutableDictionary new];
    }

    if ([_currentSegueIdentifier isEqualToString:segue.identifier]) {
        return;
    }

    if (!_segue_map[segue.identifier]) {
        _segue_map[segue.identifier] = segue.destinationViewController;
    }

    if (self.childViewControllers.count > 0) {
        UIViewController *previous = _segue_map[_currentSegueIdentifier];
        UIViewController *next     = _segue_map[segue.identifier];

        //568, 280  480 280
        next.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

        [self addChildViewController:next];
        [previous willMoveToParentViewController:nil];

        [self transitionFromViewController:previous
              toViewController:next
              duration:.3
              options:UIViewAnimationOptionTransitionFlipFromRight
              animations:nil
              completion:^(BOOL finished) {

                  [previous removeFromParentViewController];
                  [next didMoveToParentViewController:self];

              }];
    } else {
        [self addChildViewController:segue.destinationViewController];
        //480, 280
        ((UIViewController *) segue.destinationViewController).view.frame = CGRectMake(
                0, 0, self.view.frame.size.width, self.view.frame.size.height);

        [self.view addSubview:((UIViewController *) segue.destinationViewController).view];
        [segue.destinationViewController didMoveToParentViewController:self];

    }

    _currentSegueIdentifier = segue.identifier;

}

- (void)viewWillLayoutSubviews; {
    [super viewWillLayoutSubviews];

    NSLog(@"");
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key; {

    if ([value isKindOfClass:[NSString class]] && [((NSString *) value) isEqualToString:@"segue"]) {

        [_segues addObject:key];
    } else {
        [super setValue:value forUndefinedKey:key];
    }
}

- (void)viewWillAppear:(BOOL)animated; {
    [super viewWillAppear:animated];

}

- (void)segueToIdentifier:(NSString *)name; {
    [self performSegueWithIdentifier:name sender:nil];
}

@end
