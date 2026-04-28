#!/usr/bin/env python3
# vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker


import argparse
import subprocess
from pathlib import Path
import xml.etree.ElementTree as ET


def scad_bool(v: bool) -> str:
    return "true" if v else "false"


def svg_size_mm(svg_path: Path) -> tuple[float, float]:
    tree = ET.parse(svg_path)
    root = tree.getroot()

    w = root.get("width")
    h = root.get("height")
    viewbox = root.get("viewBox")

    if w and h:
        return float(w.replace("mm", "")), float(h.replace("mm", ""))

    if viewbox:
        _, _, vw, vh = map(float, viewbox.split())
        return vw, vh

    raise ValueError("SVG has no width/height or viewBox")


def render_template(text: str, values: dict) -> str:
    for k, v in values.items():
        text = text.replace(f"@@{k}@@", str(v))
    return text


def main():
    p = argparse.ArgumentParser(
        description="Generate a framed sign STL from an SVG using OpenSCAD"
    )

    p.add_argument("svg", help="Input SVG")
    p.add_argument("--template", required=True, help="SCAD template (.scadt)")
    p.add_argument("-o", "--output", help="Output STL")

    p.add_argument("--margin", type=float, default=2.0)
    p.add_argument("--thickness", type=float, default=1.5)
    p.add_argument("--corners", type=float, default=8)

    p.add_argument("--border", action="store_true")
    p.add_argument("--border-width", type=float, default=1)
    p.add_argument("--border-height", type=float, default=1)

    p.add_argument("--holes", action="store_true")
    p.add_argument("--hole-d", type=float, default=5)
    p.add_argument("--hole-dist", type=float, default=10)

    p.add_argument("--openscad", default="openscad")

    args = p.parse_args()

    svg = Path(args.svg).resolve()
    tmpl = Path(args.template).resolve()

    if not svg.exists():
        raise SystemExit(f"SVG not found: {svg}")
    if not tmpl.exists():
        raise SystemExit(f"Template not found: {tmpl}")

    svg_w, svg_h = svg_size_mm(svg)

    out_stl = Path(args.output) if args.output else svg.with_suffix(".stl")
    out_scad = out_stl.with_suffix(".scad")

    values = {
        "SVG_FILE": svg.as_posix(),
        "SVG_W": svg_w,
        "SVG_H": svg_h,
        "MARGIN": args.margin,
        "THICKNESS": args.thickness,
        "CORNERS": args.corners,
        "BORDER": scad_bool(args.border),
        "BORDER_WIDTH": args.border_width,
        "BORDER_HEIGHT": args.border_height,
        "HOLES": scad_bool(args.holes),
        "HOLE_D": args.hole_d,
        "HOLE_DIST": args.hole_dist,
    }

    rendered = render_template(tmpl.read_text(), values)
    out_scad.write_text(rendered)

    subprocess.check_call([
        args.openscad,
        "-o", str(out_stl),
        str(out_scad),
    ])

    print(f"✅ STL written to {out_stl}")


if __name__ == "__main__":
    main()

