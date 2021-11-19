//
//  gmsslv3.m
//  gmsslv3
//
//  Created by ChrisGuo on 2021/11/18.
//

#import "gmsslv3.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <gmssl/sm2.h>

@implementation gmsslv3
+ (void)testsm {

    SM2_KEY key;
    SM2_SIGN_CTX ctx;
    uint8_t msg[] = "Hello World!";
    uint8_t sig[128] = {0};
    size_t siglen = sizeof(sig);
    int i;
    int r;

    sm2_keygen(&key);
    sm2_key_print(stdout, &key, 0, 0);

    sm2_sign_init(&ctx, &key, SM2_DEFAULT_ID);
    sm2_sign_update(&ctx, msg, sizeof(msg));
    sm2_sign_finish(&ctx, sig, &siglen);

    printf("signature:\n");
    sm2_print_signature(stdout, sig, siglen, 0, 2);

    sm2_verify_init(&ctx, &key, SM2_DEFAULT_ID);
    sm2_verify_update(&ctx, msg, sizeof(msg));
    r = sm2_verify_finish(&ctx, sig, siglen);
    printf("verify %s\n", r > 0 ? "success" : "failed");
}
@end
