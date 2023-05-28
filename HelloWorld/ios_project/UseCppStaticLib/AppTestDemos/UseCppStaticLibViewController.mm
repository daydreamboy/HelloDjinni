//
//  UseCppStaticLibViewController.m
//  HelloDjinni
//
//  Created by wesley_chen on 2023/5/28.
//

#import "UseCppStaticLibViewController.h"
#import "HelloWorld.hpp"

@interface UseCppStaticLibViewController ()

@end

@implementation UseCppStaticLibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test];
}

- (void)test {
    std::shared_ptr<HelloDjinni::HelloWorld> ptr = HelloDjinni::HelloWorld::create();
    std::string cppString = ptr->helloFromCpp();
    NSLog(@"%@", [NSString stringWithUTF8String:cppString.c_str()]);
}

@end
