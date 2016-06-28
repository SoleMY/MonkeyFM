//
//  MFM_URL.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#ifndef MFM_URL_h
#define MFM_URL_h

#define shuffing_recommend_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=104&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337465&channel=appstore&action=11&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466571728&sessionid=3CA1D5ABBD054C81B1CD156659740F36&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029170&page=200014&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689%20HTTP/1.1"
#define shuffing_radio_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=107&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337643&channel=appstore&action=51&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466579318&sessionid=0F32EA11BE2443A2A5D80DAB0C91EF2F&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029255&page=200014&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define shuffing_host_URL @"http://api.kaolafm.com/api/v4/pagecontent/list?pageid=105&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337643&channel=appstore&action=55&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466579560&sessionid=0F32EA11BE2443A2A5D80DAB0C91EF2F&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029255&page=200011&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689%20HTTP/1.1"

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


#define RADIO_CLASSIFY_SEGMENTED_URL @"http://api.kaolafm.com/api/v4/broadcast/classify?support=1&installid=00034w5l&appid=0&operator=2&playid=D55B8F7E8E184C75B8B6B4A158BC025B&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337548&channel=appstore&action=2150&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466601527&sessionid=91E5622C9B684B148A00A24D2278859A&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029209&page=200040&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define RADIO_CLASSIFY_BASE_URL @"http://api.kaolafm.com/api/v4/broadcast/search?classifyid="
#define RADIO_CLASSIFY_TAIL_URL @"&pagenum=1&pagesize=20&installid=00034w5l&appid=0&operator=2&playid=D55B8F7E8E184C75B8B6B4A158BC025B&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337548&channel=appstore&action=2152&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466601528&sessionid=91E5622C9B684B148A00A24D2278859A&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029209&page=200041&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"
#define RADIO_CLASSIFY_LIST_URL(BASE,ID,AREA,TYPE,TAIL) [NSString stringWithFormat:@"%@%@&area=%@&type=%@%@", BASE, ID, AREA, TYPE, TAIL]





#endif /* MFM_URL_h */
