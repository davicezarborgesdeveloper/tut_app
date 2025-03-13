import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';

const cacheHomeKey = "CACHE_HOME_KEY";
const cacheStoreDetailsKey = "CACHE_STORE_DETAILS_KEY";
const cacheHomeInterval = 60 * 1000; // 1 MINUTE IM MILLIS
const cacheStoreInterval = 30 * 1000; // 30s in millis

abstract class LocalDataSource {
  HomeResponse getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);

  StoreDetailsResponse getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = {};

  @override
  HomeResponse getHome() {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];
    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      return cachedItem.data;
      // return the response from cache
    } else {
      // return error that cache is not valid
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  StoreDetailsResponse getStoreDetails() {
    CachedItem? cachedItem = cacheMap[cacheStoreDetailsKey];

    if (cachedItem != null && cachedItem.isValid(cacheStoreInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(response) async {
    cacheMap[cacheStoreDetailsKey] = CachedItem(response);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().microsecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    // expirationtime in 60 secs
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch; // time now is 1:00:00 pm

    bool isCacheValid = currentTimeInMillis - expirationTime <
        cacheTime; // cache time was in 12:59:30
    // false if current time > 1:00:30
    // true if current time < 1:00:30
    return isCacheValid;
  }
}
