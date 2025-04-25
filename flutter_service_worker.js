'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "20c8dbdbe69cac08ba57bf5963b11df2",
".git/config": "c75bfa7c250c5276cddad22687249565",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "36d2e6bfefea098ed28d3260f6fd2002",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "15aca3418f7368ccc5acdbe5cf8521c9",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "fc15eca5cf37c1d255a7c3eb3956949d",
".git/logs/refs/heads/deploy": "bb38f49cbc3f8b18c9d166a177e145c0",
".git/logs/refs/heads/gh-pages": "bfb245906f86e222daa13e6d04fa4e4d",
".git/logs/refs/heads/gh-ppppp": "b211cbc10ec0db7a03f27a607222fa16",
".git/logs/refs/heads/master": "7f0f2d5d3b428f1ce320e060da177753",
".git/logs/refs/remotes/origin/deploy": "0074eec67edbf85b3771c6139f19655c",
".git/objects/03/2fe904174b32b7135766696dd37e9a95c1b4fd": "80ba3eb567ab1b2327a13096a62dd17e",
".git/objects/06/694ddd412d5cd5434e07cc9187c904920cd32a": "c56b16287bd1a89e484468275cb09bf4",
".git/objects/1f/5864634bc6eb75f2e46c7b77e6a9c0732f12a6": "4ac881069000ebece5310d3a87ddd426",
".git/objects/25/9a97969c8ef5a2130b02a5f88ba1b575e97e6b": "348a8194bcd38590a61287a92d6a1fb5",
".git/objects/2f/435779a5a519b927c4f3f3cccd6d239f33ea2b": "22b720fd9db147b2b82806c676061071",
".git/objects/33/31d9290f04df89cea3fb794306a371fcca1cd9": "e54527b2478950463abbc6b22442144e",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/3b/845c393339cdeeb1f1fd622e87060d2d0e9c2f": "c4f4577bc86d565dc361a5b9439d48fa",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/48/f17af6e7f6b046479b5738ac23d7ddad606b1b": "a90688e5de49a03ad79ca21c43cc67ca",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/4c/08ac98076d7f58e854a2643255a8ca0a77af41": "de28f135faa8b355e1366d867226ee48",
".git/objects/4e/bc0d7e46144b0cd4016d8fd6203974aa61c227": "6365abc99370e6fc047f6018fcdb8d7a",
".git/objects/4f/02e9875cb698379e68a23ba5d25625e0e2e4bc": "254bc336602c9480c293f5f1c64bb4c7",
".git/objects/4f/d838426a5c9818bea8367901c0e5d56095bdcb": "207a2c767adbfa471968707ea89b2fb1",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/5a/13bd5a18e506d22647433b1980295ce67bcebe": "50b077c2b68b737800ac0d99a322b746",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/64/5116c20530a7bd227658a3c51e004a3f0aefab": "f10b5403684ce7848d8165b3d1d5bbbe",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6f/871fed6ae5b8b998aae5a9bebc6b8bd8e5743d": "2c8ac8cbce750fc4281a31cdf2912c18",
".git/objects/78/cc884fbc66cf5ad5c8d87eed2be4daf9d0edab": "d01a37b8b41a8e6b442ae5513ec79ffe",
".git/objects/7b/3151dce9bd9291ebb243ea9816d71786af287e": "fbd7b8a02af860628fb336de42c905ac",
".git/objects/80/636f8e7c4bfc59b27e6790a55b04161d531712": "67626d8a6e487c2446cea683feb437d5",
".git/objects/83/dae174dbf972cccf0eab19bf9e2833ef974c1a": "298af59abf89f7172e9151dcfe120708",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/88/d3be7befbff06e7db9f49f7d333edbff051807": "fcf2e62256b4d6273ad2b3e3fdad19ed",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8c/5262f2c64e3e48c23fe28ac7d7f6cbbb2418d4": "b5324c95c155a28c64e541f243cd2e98",
".git/objects/91/3c9b8405fb4e9c53741890af5bc3bdab2cbc07": "501f30143f5ddfa9fee1dce1e303c17e",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/91/80cff04670d0da2cce0fb3d063ebe1793b4866": "b149e63790aeb27b51c12300c67c625a",
".git/objects/94/7eb0b63a067562ab03995d403d40915e560850": "20cb038248b578e022bc960388ba4152",
".git/objects/9f/167ba7401c38c5e70aad09095bc207d5770367": "8c199f3ea183adbe69e51a887b675035",
".git/objects/a3/887fdb17982359b3d89f36e74b0983de1d1100": "8124fe722876fe5503bbb1aa5745ed7c",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/a8/0d27b766e9e58b8957f72c527303a0c416c397": "6b5889bd1c429a460ddd3db314c8579a",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/a9/91f51138ffe059d588003dc7936aff059a0428": "b73a35563fa129bd884d8b5c53ee9231",
".git/objects/ad/2f90b78480aeb6608226d9db4ecbd3ec06aaeb": "4add97a99941aa0e9eed0f2173416ade",
".git/objects/ad/2faaa29bbe880e37fd479e8fbee594fe88252e": "9a475e98e695e96286575ff4d1ca4db8",
".git/objects/ad/37e2c2c9d586095623ec6b10e8eccbeb6e36d3": "b88a51a355cc925a9bdc18509ccf1ba3",
".git/objects/af/ab72339ce3bd448f06d7f2864a9d00ac8242f9": "283716761018b8b68d92faf6fe83d00d",
".git/objects/b1/021c06c0fbd3e916c79e2cadc19814fbdfb4fe": "89f19bb4836fe54c44ac93919caaf00d",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/bc/a42c0aa887d50c0f373397b7af5a60d8f0386d": "88ae5d61137d24c4504ba9ad96afece3",
".git/objects/cc/80be999613b26ae31b9f24e9e3485048e96cb4": "290225ea446188f8ddbe3fa5d21cde3f",
".git/objects/cc/f86fd28a07e2800f8ec02e9862318731dedcde": "88e4e8cea151bf664dd75ef478ff6308",
".git/objects/cc/fab74c1f56c330985060e2247607eaedb3c7d7": "ad5b6117df489509af208438785f208b",
".git/objects/d0/101e197a6e0f96d21d0ccf61d6e78d2656c764": "e7ab2363191e31ba02430d1f959fe04a",
".git/objects/d1/ee8bfd61afccd09b47cefdae3f4302922c5b85": "de4255756b8cb311c03d70d60bde5502",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/a2f0781ee5a36307b3c43118d475c6b58ba880": "53d6837ff17d6761d1bf5714146b2938",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/db/6cbf2a6d2cfa8e36f1c01ab0b1e5e3eede80f9": "226543f841d48d0a2d640d40b7874546",
".git/objects/df/b83b578790e6a9b4e96b45854abf7ce2f2f142": "250d391950c97a66fa3783ae32da4243",
".git/objects/e8/55ab1ce2bb00c6c52893a1d9cf627b8849824a": "8c12625dc3b531c30ac1d6c44336c719",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/fa/cfb2db5c74627f3fdafeefd0d7843bd5f87ab0": "cad5aeac12e97c765e9807db181e48d0",
".git/objects/fe/adc5bd5abc4d64cba5f7a14b7b80acaadf0b33": "18971071a110b869bfbe3800bd60fa16",
".git/objects/fe/fb10fffa6486072025ec1f3c436cfd380c1979": "2d692e22bdb6fb4ecb8a8de5c3e9d560",
".git/refs/heads/deploy": "d6117130b09f2db3619d6d951736e802",
".git/refs/heads/gh-pages": "340c0ae33bed008ef6e37df25de8f22d",
".git/refs/heads/gh-ppppp": "340c0ae33bed008ef6e37df25de8f22d",
".git/refs/heads/master": "334a9ba9190a482c9bffa24555fbd6eb",
".git/refs/remotes/origin/deploy": "d6117130b09f2db3619d6d951736e802",
"assets/AssetManifest.bin": "16d26eb519f4e9e3ea9a403f56480427",
"assets/AssetManifest.bin.json": "88c715dcec5c7b4a4156f7da76617f6d",
"assets/AssetManifest.json": "0d8be223df64f684a30d1c7caf8e5489",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "5b20bf4d97bbf811becb02a997a7efd5",
"assets/NOTICES": "d08f8a00c588fc094fe9e6a771978678",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "5857552edd1f31fdde47ebd1da44efc6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2116eefdf989c4ed6c58d6df128ab810",
"/": "2116eefdf989c4ed6c58d6df128ab810",
"main.dart.js": "4978354a109ea77632608f6226a7d2c3",
"manifest.json": "a8929032806c4fafc36217e7af704ca8",
"version.json": "ec333363eb3f44248854e401a0dddcc2",
"_redirects": "c62c109df475b368db5e075d5e2f0052"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
