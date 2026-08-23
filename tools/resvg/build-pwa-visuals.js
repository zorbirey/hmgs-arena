const fs = require('node:fs');
const path = require('node:path');
const { Resvg } = require('@resvg/resvg-js');
const { PNG } = require('pngjs');

const root = path.resolve(__dirname, '..', '..');
const output = path.join(root, 'web-demo', 'assets', 'visual-20260823-03');
fs.mkdirSync(output, { recursive: true });

function render(source, destination, width) {
  const svg = fs.readFileSync(path.join(root, source));
  const image = new Resvg(svg, { fitTo: { mode: 'width', value: width } }).render();
  fs.writeFileSync(path.join(output, destination), image.asPng());
}

render('native-android/app/src/main/assets/zeus_cover_v2.svg', 'entry-zeus-20260823-03.png', 1080);
render('assets/zeus_hmgs.svg', 'brand-zeus-20260823-03.png', 1080);
render('native-android/app/src/main/assets/zeus_watermark_v2.svg', 'watermark-zeus-20260823-03.png', 810);

for (const size of [64, 180, 192, 512]) {
  render('assets/hmgs_arena_icon.svg', `icon-${size}-20260823-03.png`, size);
}

const foreground = PNG.sync.read(
  new Resvg(fs.readFileSync(path.join(root, 'assets', 'hmgs_arena_icon.svg')), {
    fitTo: { mode: 'width', value: 368 },
  }).render().asPng()
);
const maskable = new PNG({ width: 512, height: 512 });
for (let y = 0; y < 512; y += 1) {
  for (let x = 0; x < 512; x += 1) {
    const i = (y * 512 + x) * 4;
    maskable.data[i] = 5;
    maskable.data[i + 1] = 6;
    maskable.data[i + 2] = 7;
    maskable.data[i + 3] = 255;
  }
}
PNG.bitblt(foreground, maskable, 0, 0, 368, 368, 72, 72);
fs.writeFileSync(
  path.join(output, 'icon-maskable-512-20260823-03.png'),
  PNG.sync.write(maskable)
);
