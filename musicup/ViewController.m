//
//  ViewController.m
//  musicup
//
//  Created by ビザンコムマック０７ on 2014/10/20.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ボタンを押されると呼ばれるメソッド
- (IBAction)upload:(id)sender {
        
        //NSBundleを取得
        NSBundle *bundle = [NSBundle mainBundle];
        //glass.mp3のパスを取得する
        NSString *path = [bundle pathForResource:@"glass" ofType:@"mp3"];
        //パスからデータを取得
        NSData *musicdata = [[NSData alloc]initWithContentsOfFile:path];
        //ファイルをサーバーにアップするためのプログラムのURLを生成
        NSURL *url = [NSURL URLWithString:@"http://bizanshinobu.miraiserver.com/file.php"];
        //urlをもとにしたリクエストを生成
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //リクエストメッセージのbody部分を作るための変数
        NSMutableData *body = [NSMutableData data];
    //バウンダリ文字列(仕切線)を格納している変数
        NSString *boundary = @"---------------------------168072824752491622650073";
    //Content-typeヘッダに設定する情報を格納する変数
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        //POST形式の通信を行うようにする
        [request setHTTPMethod:@"POST"];
    //bodyの最初にバウンダリ文字列(仕切線)を追加
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //サーバー側に送るファイルの項目名をsample
    //送るファイル名を1.mp3と設定
        [body appendData:[@"Content-Disposition: form-data; name=\"sample\"; filename=\"1.mp3\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //送るファイルのデータのタイプを設定する情報を追加
        [body appendData:[@"Content-Type: audio/mpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //音楽ファイルのデータを追加
        [body appendData:musicdata];
    //最後にバウンダリ文字列を追加
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //ヘッダー情報を追加
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    //リクエストのボディ部分に変数bodyをセット
        [request setHTTPBody:body];
        NSURLResponse *response;
        NSError *err = nil;
    //サーバーとの通信を行う
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //サーバーからのデータを文字列に変換
        NSString *datastring = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",datastring);
            self.label.text = @"ファイルアップ完了";
}
@end
