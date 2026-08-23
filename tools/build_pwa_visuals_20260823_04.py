from pathlib import Path

from PIL import Image, ImageOps


ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "web-demo" / "assets" / "visual-20260823-04"
ASSETS.mkdir(parents=True, exist_ok=True)


def open_rgba(name: str) -> Image.Image:
    return Image.open(ASSETS / name).convert("RGBA")


entry = ImageOps.fit(
    open_rgba("source-entry-zeus-20260823-04.png"),
    (1080, 1920),
    Image.Resampling.LANCZOS,
    centering=(0.5, 0.5),
)
entry.convert("RGB").save(
    ASSETS / "entry-zeus-20260823-04.png", format="PNG", optimize=True
)

watermark = open_rgba("source-watermark-zeus-20260823-04.png")
watermark.thumbnail((900, 1350), Image.Resampling.LANCZOS)
watermark.save(
    ASSETS / "watermark-zeus-20260823-04.png", format="PNG", optimize=True
)

icon_source = ImageOps.fit(
    open_rgba("source-icon-zeus-20260823-04.png"),
    (1024, 1024),
    Image.Resampling.LANCZOS,
)
background = Image.new("RGBA", icon_source.size, "#050607")
background.alpha_composite(icon_source)

for size in (64, 180, 192, 512):
    background.resize((size, size), Image.Resampling.LANCZOS).convert("RGB").save(
        ASSETS / f"icon-{size}-20260823-04.png", format="PNG", optimize=True
    )

maskable = Image.new("RGBA", (512, 512), "#050607")
safe_icon = background.resize((360, 360), Image.Resampling.LANCZOS)
maskable.alpha_composite(safe_icon, (76, 76))
maskable.convert("RGB").save(
    ASSETS / "icon-maskable-512-20260823-04.png", format="PNG", optimize=True
)
