**Extended-Container-View-Controller**

It allows to use multiple child controllers inside the storyboard.You just bound empty segues to container view controller then switch between them.

![Sample Usage](https://github.com/away4m/Extended-Container-View-Controller/blob/master/Screen%20Shot%202014-10-20%20at%202.11.29%20AM.png)

```
 -(void)segueToIndex:(NSUInteger)i;
-(void)segueToIdentifier:(NSString *)name;

```
