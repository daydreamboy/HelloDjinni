//
//  UseCppStaticLibViewController.m
//  HelloDjinni
//
//  Created by wesley_chen on 2023/5/28.
//

#import "UseDjinniOCInterfaceViewController.h"
#import "WCHelloWorld.h"

@interface UseDjinniOCInterfaceViewController ()

@end

@implementation UseDjinniOCInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test];
}

- (void)test {
    WCHelloWorld *helloDjinniInterface = [WCHelloWorld create];
    NSString *helloDjinni = [helloDjinniInterface helloFromCpp];
    NSLog(@"%@", helloDjinni);
}

@end
