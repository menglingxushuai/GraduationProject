//
//  BiShe_URL.h
//  GraduationProject
//
//  Created by 郑淮予 on 2017/4/27.
//  Copyright © 2017年 郑淮予. All rights reserved.
//

#ifndef BiShe_URL_h
#define BiShe_URL_h

// FM的网址
#define FM_URL @"http://api.kaolafm.com/api/v4/category/list?fid=1&installid=00034w5l&appid=0&operator=2&playid=1C12414783304DF49649664FE118A859&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2007&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598173&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
// FM详情
#define FM_Detail_BaseUrl @"http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid="
#define FM_Detail_AppendingUrl @"&installid=00034w5l&appid=0&operator=2&playid=85C6753E388745BBADB885EFC5C8076F&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598913&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

// 节目
#define FM_Programe_BaseUrl @"http://api.kaolafm.com/api/v4/audios/list?id="
#define FM_Programe_AppendNumUrl @"&sorttype=1&pagesize=10&pagenum="
#define FM_Programe_Last @"&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337350&channel=appstore&action=5120&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467339948&sessionid=AA4B9C223EAD45CBB001B8CA0322383D&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029123&page=200003&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
// 评论
#define FM_Comment_BaseUrl @"http://api.kaolafm.com/api/v4/comment/new?resourceid="
#define FM_Comment_AppendNumUrl @"&resourcetype=0&pagenum="
#define FM_Comment_Last @"&pagesize=20&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337350&channel=appstore&action=5183&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467340302&sessionid=AA4B9C223EAD45CBB001B8CA0322383D&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029123&page=200023&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
// 详情
#define FM_SegDetail_BaseUrl @"http://api.kaolafm.com/api/v4/albumdetail/get?albumid="
#define FM_SegDetail_AppendUrl @"&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337482&channel=appstore&action=4787&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467293521&sessionid=D4E794CBD72041AC94DB80CCB40BB130&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029219&page=200003&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

// 文章
#define Essay_Url @"http://c.m.163.com/nc/article/list/T1348649580692/"

#pragma mark - 文章闻详情
// photoset
#define Essay_PHOTOSET_DETAIL_URL(newsType, newsID) [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json", newsType, newsID]
// article
#define Essay_ARTICLE_DETAIL_URL(postid) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html", postid]
// special
#define Essay_SPECIAL_DETAIL_URL(skipID) [NSString stringWithFormat:@"http://c.m.163.com/nc/special/%@.html", skipID]

#endif /* BiShe_URL_h */
