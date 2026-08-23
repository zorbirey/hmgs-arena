const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
const web = path.join(root, 'web-demo');
const buildId = '20260823-04';
const activeFiles = ['index.html', 'styles.css', 'version.css', 'visual-theme.css', 'version.js', 'app.js', 'manifest.webmanifest', 'service-worker.js'];
const text = Object.fromEntries(activeFiles.map(file => [file, fs.readFileSync(path.join(web, file), 'utf8')]));
const manifest = JSON.parse(text['manifest.webmanifest']);

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

for (const file of ['index.html', 'version.css', 'visual-theme.css', 'version.js', 'app.js', 'manifest.webmanifest', 'service-worker.js']) {
  assert(text[file].includes(buildId), `${file} PWA ID içermiyor`);
}
assert(manifest.version === buildId, 'Manifest sürümü PWA ID ile eşleşmiyor');
assert(text['service-worker.js'].includes('hmgs-arena-${self.HMGS_PWA_VERSION}'), 'Cache adı sürüm değişkenini kullanmıyor');

const legacyPatterns = [
  'visual-20260823-03',
  '../assets/hmgs_arena_icon.svg',
  '../assets/zeus_hmgs.svg',
  '../native-android',
  'assets/app-icon.png',
  'assets/splash-arena.png',
  'assets/zeus.png',
];
for (const pattern of legacyPatterns) {
  for (const [file, body] of Object.entries(text)) {
    assert(!body.includes(pattern), `${file} eski canlı görsel referansı içeriyor: ${pattern}`);
  }
}

const visualDirectory = path.join(web, 'assets', `visual-${buildId}`);
const expectedPngs = new Map([
  [`entry-zeus-${buildId}.png`, [1080, 1920]],
  [`watermark-zeus-${buildId}.png`, [900, 1350]],
  [`icon-64-${buildId}.png`, [64, 64]],
  [`icon-180-${buildId}.png`, [180, 180]],
  [`icon-192-${buildId}.png`, [192, 192]],
  [`icon-512-${buildId}.png`, [512, 512]],
  [`icon-maskable-512-${buildId}.png`, [512, 512]],
]);
const pngSignature = '89504e470d0a1a0a';
for (const [file, [width, height]] of expectedPngs) {
  const fullPath = path.join(visualDirectory, file);
  assert(fs.existsSync(fullPath), `Görsel eksik: ${file}`);
  const buffer = fs.readFileSync(fullPath);
  assert(buffer.subarray(0, 8).toString('hex') === pngSignature, `PNG imzası geçersiz: ${file}`);
  assert(buffer.readUInt32BE(16) === width && buffer.readUInt32BE(20) === height, `PNG boyutu geçersiz: ${file}`);
  const livePath = `assets/visual-${buildId}/${file}`;
  assert(Object.values(text).some(body => body.includes(livePath)), `Görsel canlı referans grafiğinde yok: ${file}`);
  assert(text['service-worker.js'].includes(`./${livePath}`), `Görsel cache listesinde yok: ${file}`);
}

for (const icon of manifest.icons) {
  assert(icon.type === 'image/png', `Manifest ikonu PNG değil: ${icon.src}`);
  assert(fs.existsSync(path.join(web, icon.src)), `Manifest ikonu eksik: ${icon.src}`);
}
assert(manifest.icons.some(icon => icon.sizes === '192x192'), '192x192 PWA ikonu eksik');
assert(manifest.icons.some(icon => icon.sizes === '512x512' && icon.purpose === 'any'), '512x512 PWA ikonu eksik');
assert(manifest.icons.some(icon => icon.sizes === '512x512' && icon.purpose === 'maskable'), 'Maskable ikon eksik');

console.log(`PWA ${buildId}: ${expectedPngs.size} PNG, manifest, canlı referanslar ve cache grafiği doğrulandı.`);
