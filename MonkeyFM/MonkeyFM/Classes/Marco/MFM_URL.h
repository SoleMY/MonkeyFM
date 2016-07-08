//
//  MFM_URL.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#ifndef MFM_URL_h
#define MFM_URL_h

#define shuffing_recommend_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=104&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337465&channel=appstore&action=11&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466571728&sessionid=3CA1D5ABBD054C81B1CD156659740F36&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029170&page=200014&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689%20"
#define shuffing_radio_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=107&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337643&channel=appstore&action=51&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466579318&sessionid=0F32EA11BE2443A2A5D80DAB0C91EF2F&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029255&page=200014&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define shuffing_host_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=105&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337643&channel=appstore&action=55&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466579560&sessionid=0F32EA11BE2443A2A5D80DAB0C91EF2F&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029255&page=200011&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689%20"

#define Host_detaile_BaseURL @"http://api.kaolafm.com/api/v4/"
#define Host_detaile_AppendURLOne @"/other?pagenum=1&othersuid="
#define Host_detaile_AppendURLTwo @"&pagesize=10&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337467&channel=appstore&action=4041&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467101732&sessionid=BC932CF9CC844DE7AD6DDA87541C25BA&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029196&page=200030&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

#define PLAY_LIST_DETAILE_BASEURL @"http://api.kaolafm.com/api/v4/albumdetail/get?albumid="
#define PLAY_LIST_ABOUT_BASEURL @"http://api.kaolafm.com/api/v4/relatedalbum/list?id="
#define PLAY_LIST_DETAILE_APPENDURL @"&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337482&channel=appstore&action=4787&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467293521&sessionid=D4E794CBD72041AC94DB80CCB40BB130&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029219&page=200003&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define PLAY_LIST_PROGRAM_BASEURL @"http://api.kaolafm.com/api/v4/audios/list?id="
#define PLAY_LIST_PROGRAM_APPEND @"&sorttype=1&pagesize=10&pagenum="
#define PLAY_LIST_PROGRAM_APPENDTWO @"&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337350&channel=appstore&action=5120&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467339948&sessionid=AA4B9C223EAD45CBB001B8CA0322383D&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029123&page=200003&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

#define PLAY_LIST_COMMENT_BASEURL @"http://api.kaolafm.com/api/v4/comment/new?resourceid="
#define PLAY_LIST_COMMENT_APPENDONE @"&resourcetype=0&pagenum="
#define PLAY_LIST_COMMENT_APPENDTWO @"&pagesize=20&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337350&channel=appstore&action=5183&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1467340302&sessionid=AA4B9C223EAD45CBB001B8CA0322383D&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029123&page=200023&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

// ============================================================================
#define classification_Url @"http://api.kaolafm.com/api/v4/category/listofall?pagenum=1&pagesize=10&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337465&channel=appstore&action=14&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466571728&sessionid=3CA1D5ABBD054C81B1CD156659740F36&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029170&page=200022&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define Host_Base_URL @"http://api.kaolafm.com/api/v4/anchor/search?"

#define Host_append_URL @"&pagesize=20&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337513&channel=appstore&action=3629&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466831237&sessionid=4521DE6A94AE46F6814F2ADFCE49CB90&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029162&page=200047&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

#define Host_detailed_Base_URL @"http://api.kaolafm.com/api/v4/user/other/info?othersuid="

#define Host_detailed_append_URL @"&lock=1&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337524&channel=appstore&action=3850&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466991451&sessionid=FF3215FD5B874F54AB81DA8683899B9D&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029213&page=200030&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

#define classification_NEWS_ALL @"http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid=706&installid=00034w5l&appid=0&operator=2&playid=8D7114F8C3CD42B0BA0DBBC42456B259&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598807&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

// 新闻segment接口，包含传值ID
#define classification_NEWS_Segment @"http://api.kaolafm.com/api/v4/category/list?fid=706&installid=00034w5l&appid=0&operator=2&playid=1C12414783304DF49649664FE118A859&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2007&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598173&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

/**********************************电台页面接口*************************************************/
#define RADIO_POPULARITEM_BASE_URL @"http://api.kaolafm.com/api//v4/labelinfo/more?labelid="
#define RADIO_POPULARITEM_TAIL_URL @"&installid=00034w5l&appid=0&operator=2&playid=4EF8DCF02A2443CCAEB3DF5DDB489DD6&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337548&channel=appstore&action=2456&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466603842&sessionid=91E5622C9B684B148A00A24D2278859A&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029209&page=200040&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define RADIO_POPULARITEM_LIST_URL(base,ID,tail) [NSString stringWithFormat:@"%@%@%@", base, ID, tail]

#define RADIO_CLISSIFY_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/search?classifyid="
#define RADIO_CLISSIFY_TAIL_URL @"&pagenum=1&pagesize=40&installid=00034w5l&appid=0&operator=2&playid=D55B8F7E8E184C75B8B6B4A158BC025B&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337548&channel=appstore&action=2152&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466601528&sessionid=91E5622C9B684B148A00A24D2278859A&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029209&page=200041&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define RADIO_CLISSIFY_LIST_URL(BASE,ID,AREA,TYPE,TAIL) [NSString stringWithFormat:@"%@%@&area=%@&type=%@%@", BASE, ID, AREA, TYPE, TAIL]
//
//http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid=1002&installid=00034w5l&appid=0&operator=2&playid=85C6753E388745BBADB885EFC5C8076F&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598913&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689
// 分类传值基地址
#define classification_Base_URL @"http://api.kaolafm.com/api/v4/category/list?fid="
// 分类拼接地址
#define classification_Appending_URL @"&installid=00034w5l&appid=0&operator=2&playid=1C12414783304DF49649664FE118A859&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2007&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598173&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

#define RADIO_CLASSIFY_SEGMENTED_URL @"http://api.kaolafm.com/api/v4/broadcast/classify?support=1&installid=00034w5l&appid=0&operator=2&playid=D55B8F7E8E184C75B8B6B4A158BC025B&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337548&channel=appstore&action=2150&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466601527&sessionid=91E5622C9B684B148A00A24D2278859A&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029209&page=200040&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define RADIO_CLASSIFY_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/search?classifyid="
#define RADIO_CLASSIFY_TAIL_URL @"&pagenum=1&pagesize=40&installid=00034w5l&appid=0&operator=2&playid=D55B8F7E8E184C75B8B6B4A158BC025B&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337548&channel=appstore&action=2152&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466601528&sessionid=91E5622C9B684B148A00A24D2278859A&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029209&page=200041&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define RADIO_CLASSIFY_LIST_URL(BASE,ID,AREA,TYPE,TAIL) [NSString stringWithFormat:@"%@%ld&area=%ld&type=%ld%@", BASE, ID, AREA, TYPE, TAIL]

#define kBaseURL @"http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid="
#define kAppendingURL @"&installid=00034w5l&appid=0&operator=2&playid=85C6753E388745BBADB885EFC5C8076F&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598913&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"


#define RADIO_AREA_URL @"http://api.kaolafm.com/api/v4/broadcast/arealist?timezone=28800&resolution=640*1136&osversion=9.1&devicename=iPod%20touch%205G&screensize=320*568&version=4.8.1&udid=66f5ad1f7920c28abea929c92fb35b66&channel=appstore&lon=116.337449&playid=&sessionid=F5FAFA7A14814F408AAA7F368F80111B&action=701&sign=cb39865d48a5df9bb515bf5235dd5e0d&operator=0&idfv=AAF4BDEA-DC14-40C3-8CA9-965A5EE4E58E&installid=00035BDN&suppermode=0&mac=020000000000&uid=&appid=0&timestamp=1467269334&devicetype=1&usertype=0&idfa=3FF1EDAA-41A4-4EF5-9A6B-2B1C34FDE52A&producer=apple&page=200041&lat=40.029193&network=1"


#define RADIO_DISPLAY_LIST_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/list?&id="
#define RADIO_DISPLAY_LIST_TAIL_URL @"&timezone=28800&installid=00034wu2&uid=2951383&udid=1c1b7cfae453ec10077f8c2d734085d4&sessionid=1c1b7cfae453ec10077f8c2d734085d41467343864881&imsi=460013924616707&operator=2&lon=116.344188&lat=40.030353&network=1&timestamp=1467343882&sign=e3c4197890795b12fc5ba17232c77c89&resolution=1080*1794&devicetype=0&channel=B-hicloud&version=4.8.3&appid=0&token=token2239b88800dde6d4d908799c6fb5acf7&"
#define RADIO_DISPLAY_LIST_EMPTY_URL(BASE, ID, type, classifyid,TAIL) [NSString stringWithFormat:@"%@%@&pagesize=40&type=%ld&classifyid=%ld%@", BASE, ID, type, classifyid, TAIL]

#define RADIO_DISPLAY_AREA_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/search?type=1&pagesize=40&area="
#define RADIO_DISPLAY_AREA_TAIL_URL @"&pagenum=1&classifyid=2&timezone=28800&resolution=640*1136&osversion=9.1&devicename=iPod%20touch%205G&screensize=320*568&version=4.8.1&udid=66f5ad1f7920c28abea929c92fb35b66&channel=appstore&lon=116.337500&playid=&sessionid=5469953C514B453B8AE8F1E8CFCF7794&action=1896&sign=cb39865d48a5df9bb515bf5235dd5e0d&operator=0&idfv=AAF4BDEA-DC14-40C3-8CA9-965A5EE4E58E&installid=00035BDN&suppermode=0&mac=020000000000&uid=&appid=0&timestamp=1467443482&devicetype=1&usertype=0&idfa=3FF1EDAA-41A4-4EF5-9A6B-2B1C34FDE52A&producer=apple&page=200041&lat=40.029220&network=1"

#define RADIO_DISPLAY_AREA_EMPTY_URL(BASE, AREA, TAIL) [NSString stringWithFormat:@"%@%ld%@", BASE, AREA, TAIL]

#define RADIO_DISPLAY_CONTENT_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/list?type=2&id="
#define RADIO_DISPLAY_CONTENT_TAIL_URL @"&timezone=28800&resolution=640*1136&osversion=9.1&devicename=iPod%20touch%205G&screensize=320*568&version=4.8.1&udid=66f5ad1f7920c28abea929c92fb35b66&channel=appstore&lon=116.337500&playid=&sessionid=5469953C514B453B8AE8F1E8CFCF7794&action=1802&sign=cb39865d48a5df9bb515bf5235dd5e0d&operator=0&idfv=AAF4BDEA-DC14-40C3-8CA9-965A5EE4E58E&installid=00035BDN&suppermode=0&mac=020000000000&uid=&appid=0&timestamp=1467443082&devicetype=1&usertype=0&idfa=3FF1EDAA-41A4-4EF5-9A6B-2B1C34FDE52A&producer=apple&page=200041&lat=40.029220&network=1"
#define RADIO_DISPLAY_CONTENT_EMPTY_URL(BASE, ID, CLASSIFYID, TAIL) [NSString stringWithFormat:@"%@%ld&pagesize=40&area=&classifyid=%ld%@", BASE, ID, CLASSIFYID, TAIL]



#define RADIO_DISPLAY_PLAY_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/currentprogram?broadcastid="

#define RADIO_DISPLAY_PLAY_TAIL_URL @"&timezone=28800&resolution=640*1136&osversion=9.1&devicename=iPod%20touch%205G&screensize=320*568&version=4.8.1&udid=66f5ad1f7920c28abea929c92fb35b66&channel=appstore&lon=116.337500&playid=&sessionid=5469953C514B453B8AE8F1E8CFCF7794&action=1901&sign=cb39865d48a5df9bb515bf5235dd5e0d&operator=0&idfv=AAF4BDEA-DC14-40C3-8CA9-965A5EE4E58E&installid=00035BDN&suppermode=0&mac=020000000000&uid=&appid=0&timestamp=1467443484&devicetype=1&usertype=0&idfa=3FF1EDAA-41A4-4EF5-9A6B-2B1C34FDE52A&producer=apple&page=200042&lat=40.029220&network=1"

#define RADIO_DISPLAY_PLAY_EMPTY_URL(BASE,ID,TAIL) [NSString stringWithFormat:@"%@%@%@", BASE, ID,  TAIL]


#define kRecommend_Pic_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=104&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337465&channel=appstore&action=11&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466571728&sessionid=3CA1D5ABBD054C81B1CD156659740F36&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029170&page=200014&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"




















/*===================================================================================*/

#endif /* MFM_URL_h */
