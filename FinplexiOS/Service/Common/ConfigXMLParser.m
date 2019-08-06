//
//  ConfigXMLParser.m
//  demoApp
//
//  Created by agilet-ryu on 2019/7/17.
//  Copyright © 2019 fujitsu. All rights reserved.
//

#import "ConfigXMLParser.h"
#import "InfoDatabase.h"

@interface ConfigXMLParser ()
@property (strong, nonatomic) NSMutableDictionary *configDic;
@property (strong, nonatomic) NSString *currentTagName;
@property (strong, nonatomic) NSString *dataName;
@property (strong, nonatomic) NSString *dataValue;
@end

@implementation ConfigXMLParser

/**
 設定ファイルパラメータ展開
 */
- (void)start {
    
    // 設定ファイルを取得する
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // NSXMLParser初期化
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - <#NSXMLParserDelegate#>

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    // NSXMLParser起動の時、受信のDictionaryを初期化する
    self.configDic = [NSMutableDictionary new];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // カレント要素を取得する
    _currentTagName = elementName;
}

//
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // カレント要素がnilの時、戻る
    if ([string isEqualToString:@""]) {
        return;
    }
    if (![self.currentTagName isEqualToString:@"properties"]) {
        [self.configDic setObject:string forKey:self.currentTagName];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // 受信のDictionaryを設定する時、nilにカレント要素を設定する
    self.currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    // 設定ファイルデータ初期化
    CONFIG_FILE_DATA *configModel = [[CONFIG_FILE_DATA alloc] init];
    
    // 設定ファイルデータを設定する
    for (NSString *key in self.configDic) {
        id value = self.configDic[key];
        [configModel setValue:value forKeyPath:key];
    }
    
    // 設定ファイルの読み取りを完了する時を、設定ファイルデータを共通領域に格納する
    [[InfoDatabase shareInfoDatabase] setConfigFileData:configModel];
}
@end
