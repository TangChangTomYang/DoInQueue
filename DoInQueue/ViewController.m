//
//  ViewController.m
//  DoInQueue
//
//  Created by edz on 2020/8/1.
//  Copyright © 2020 EDZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
}


static const void * const Kqueue1_abc = &Kqueue1_abc;
-(void)test{
    /**
        1. dispatch_queue_set_specific 用于给一个队列设置相关的上下文数据
        2. dispatch_get_specific用于获取队列相关的上下文数据。
        最重要的是dispatch_get_specific获取的是当前执行队列的相关数据，而不仅仅与 key 对应这一个条件。
            
        上面的这几句话, 有点难理解, 我们直接看例子
     */

    
         
    // 1. 创建一个名为 queue_1 的队列
    dispatch_queue_t queue1 = dispatch_queue_create("queue_1", NULL);
    // 2. 给队列 queue1 关联一个对象: @"abc", 并取一个关联的名字为: Kqueue1_abc
    NSString *abc = @"abcStr";
    dispatch_queue_set_specific(queue1, Kqueue1_abc,(__bridge void *)abc, NULL);
    NSLog(@"-存---%@",abc );

    // 3. 取出通过关联的key:"queue1_abc_key" 在 queue1队列中取出 关联的 对象@"abc"
    dispatch_async(queue1, ^{ // 这个block中的代码 会在 queue1 队列中执行
    void *abcd = dispatch_get_specific(Kqueue1_abc);
    NSLog(@"-取1---%@", abcd);
    });
    
    void *abcde = dispatch_get_specific(Kqueue1_abc);
    NSLog(@"-取2---%@", abcde);
    
       
}


/** 含义解释:
    在指定的队列 queue 中, 通过一个key, 关联一个对象context
 */
void dispatch_queue_set_specific(dispatch_queue_t queue,
                                 const void *key,
                                 void *_Nullable context,
                                 dispatch_function_t _Nullable destructor);

/** 取出当前队列中 key 关联的对象, 返回值可能为空
    当前队列, 就是当前代码执行的队列
        如果当前队列中没有通过key关联过对象, 取出的值就位空
 */
void *_Nullable dispatch_get_specific(const void *key);


/** 从队列 queue 中取出key 关联的对象, 可能为空
 */
void *_Nullable dispatch_queue_get_specific(dispatch_queue_t queue,
                                            const void *key);


// 以上这三个方法通常用来判断 队列死锁 FBDababaseQueue

@end
