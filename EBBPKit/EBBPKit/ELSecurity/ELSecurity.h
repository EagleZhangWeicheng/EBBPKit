//
//  EBLSecurity.h
//  EagleBasicLib
//
//  Created by Mac on 2018/6/29.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSException.h>


#pragma mark - EBLSecurityResult
@interface EBLSecurityResult : NSObject

@property (strong, nonatomic, readonly) NSData *data;
@property (strong, nonatomic, readonly) NSString *utf8String;
@property (strong, nonatomic, readonly) NSString *hex;
@property (strong, nonatomic, readonly) NSString *hexLower;
@property (strong, nonatomic, readonly) NSString *base64;

- (id)initWithBytes:(unsigned char[])initData length:(NSUInteger)length;

@end


#pragma mark - EBLSecurity
@interface EBLSecurity : NSObject
#pragma mark - AES Encrypt
+ (EBLSecurityResult *)aesEncrypt:(NSString *)data key:(NSString *)key;
+ (EBLSecurityResult *)aesEncrypt:(NSString *)data hexKey:(NSString *)key hexIv:(NSString *)iv;
+ (EBLSecurityResult *)aesEncrypt:(NSString *)data key:(NSData *)key iv:(NSData *)iv;
+ (EBLSecurityResult *)aesEncryptWithData:(NSData *)data key:(NSData *)key iv:(NSData *)iv;

#pragma mark AES Decrypt
+ (EBLSecurityResult *)aesDecryptWithBase64:(NSString *)data key:(NSString *)key;
+ (EBLSecurityResult *)aesDecryptWithBase64:(NSString *)data hexKey:(NSString *)key hexIv:(NSString *)iv;
+ (EBLSecurityResult *)aesDecryptWithBase64:(NSString *)data key:(NSData *)key iv:(NSData *)iv;
+ (EBLSecurityResult *)aesDecryptWithData:(NSData *)data key:(NSData *)key iv:(NSData *)iv;

#pragma mark - MD5
+ (EBLSecurityResult *)md5:(NSString *)hashString;
+ (EBLSecurityResult *)md5WithData:(NSData *)hashData;

#pragma mark HMAC-MD5
+ (EBLSecurityResult *)hmacMd5:(NSString *)hashString hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacMd5WithData:(NSData *)hashData hmacKey:(NSString *)key;

#pragma mark - SHA
+ (EBLSecurityResult *)sha1:(NSString *)hashString;
+ (EBLSecurityResult *)sha1WithData:(NSData *)hashData;
+ (EBLSecurityResult *)sha224:(NSString *)hashString;
+ (EBLSecurityResult *)sha224WithData:(NSData *)hashData;
+ (EBLSecurityResult *)sha256:(NSString *)hashString;
+ (EBLSecurityResult *)sha256WithData:(NSData *)hashData;
+ (EBLSecurityResult *)sha384:(NSString *)hashString;
+ (EBLSecurityResult *)sha384WithData:(NSData *)hashData;
+ (EBLSecurityResult *)sha512:(NSString *)hashString;
+ (EBLSecurityResult *)sha512WithData:(NSData *)hashData;

#pragma mark HMAC-SHA
+ (EBLSecurityResult *)hmacSha1:(NSString *)hashString hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha1WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha224:(NSString *)hashString hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha224WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha256:(NSString *)hashString hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha256WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha384:(NSString *)hashString hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha384WithData:(NSData *)hashData hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha512:(NSString *)hashString hmacKey:(NSString *)key;
+ (EBLSecurityResult *)hmacSha512WithData:(NSData *)hashData hmacKey:(NSString *)key;
@end


#pragma mark - EBLSecurityEncoder
@interface EBLSecurityEncoder : NSObject
- (NSString *)base64:(NSData *)data;
- (NSString *)hex:(NSData *)data useLower:(BOOL)isOutputLower;
@end


#pragma mark - EBLSecurityDecoder
@interface EBLSecurityDecoder : NSObject
- (NSData *)base64:(NSString *)data;
- (NSData *)hex:(NSString *)data;
@end
