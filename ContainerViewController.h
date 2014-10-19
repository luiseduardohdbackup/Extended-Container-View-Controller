//
//  ContainerViewController.h
//  EmbeddedSwapping
//
//  Created by Michael Luton on 11/13/12.
//  Copyright (c) 2012 Sandmoose Software. All rights reserved.
//

@interface ContainerViewController : UIViewController

    @property (nonatomic, strong) NSMutableArray *segues;

    -(void)segueToIndex:(NSUInteger)i;
    -(void)segueToIdentifier:(NSString *)name;
@end
