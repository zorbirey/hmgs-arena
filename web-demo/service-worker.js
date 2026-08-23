importScripts('./version.js?v=20260823-02');

const CACHE_NAME = `hmgs-arena-${self.HMGS_PWA_VERSION}`;
const APP_SHELL = [
  './?pwa=20260823-02',
  './index.html?pwa=20260823-02',
  './styles.css?v=20260823-02',
  './version.css?v=20260823-02',
  './version.js?v=20260823-02',
  './app.js?v=20260823-02',
  './manifest.webmanifest?v=20260823-02',
  './assets/visual-20260823-02/entry-zeus-20260823-02.png',
  './assets/visual-20260823-02/brand-zeus-20260823-02.png',
  './assets/visual-20260823-02/watermark-zeus-20260823-02.png',
  './assets/visual-20260823-02/icon-64-20260823-02.png',
  './assets/visual-20260823-02/icon-180-20260823-02.png',
  './assets/visual-20260823-02/icon-192-20260823-02.png',
  './assets/visual-20260823-02/icon-512-20260823-02.png',
  './assets/visual-20260823-02/icon-maskable-512-20260823-02.png'
];

self.addEventListener('install', event => {
  event.waitUntil(caches.open(CACHE_NAME).then(cache => cache.addAll(APP_SHELL)));
  self.skipWaiting();
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(key => key.startsWith('hmgs-arena-') && key !== CACHE_NAME).map(key => caches.delete(key))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  if (event.request.method !== 'GET') return;
  event.respondWith(
    fetch(event.request)
      .then(response => {
        const copy = response.clone();
        caches.open(CACHE_NAME).then(cache => cache.put(event.request, copy));
        return response;
      })
      .catch(() => caches.match(event.request).then(cached => cached || caches.match('./index.html')))
  );
});
