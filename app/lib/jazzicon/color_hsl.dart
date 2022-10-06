import 'dart:math';
import 'dart:ui';

Map<String, double> colorToHSL(Color color) {
  // Convert hex to RGB first
  double r = color.red.toDouble();
  double g = color.green.toDouble();
  double b = color.blue.toDouble();
  // Then to HSL
  r /= 255;
  g /= 255;
  b /= 255;
  double cmin = min(min(r, g), b), cmax = max(max(r, g), b), delta = cmax - cmin, h = 0, s = 0, l = 0;

  if (delta == 0)
    h = 0;
  else if (cmax == r)
    h = ((g - b) / delta) % 6;
  else if (cmax == g)
    h = (b - r) / delta + 2;
  else
    h = (r - g) / delta + 4;

  // h = round(h * 60);
  h = (h * 60).roundToDouble();

  if (h < 0) h += 360;

  l = (cmax + cmin) / 2;
  s = delta == 0 ? 0 : delta / (1 - (2 * l - 1).abs());
  // s = +(s * 100).toFixed(1);
  s = double.parse((s * 100).toStringAsFixed(1));
  // l = +(l * 100).toFixed(1);
  l = double.parse((l * 100).toStringAsFixed(1));

  return {
    "h": h,
    "s": s,
    "l": l,
  };
}


Color HSLToColor(Map<String, double> hsl) {
  // var {h, s, l} = hsl
  double h = hsl["h"]??0;
  double s = hsl["s"]??0;
  double l = hsl["l"]??0;

  s /= 100;
  l /= 100;

  double c = (1 - (2 * l - 1).abs()) * s,
  x = c * (1 - ((h / 60) % 2 - 1).abs()),
  m = l - c/2,
  r = 0,
  g = 0,
  b = 0;

  if (0 <= h && h < 60) {
  r = c; g = x; b = 0;
  } else if (60 <= h && h < 120) {
  r = x; g = c; b = 0;
  } else if (120 <= h && h < 180) {
  r = 0; g = c; b = x;
  } else if (180 <= h && h < 240) {
  r = 0; g = x; b = c;
  } else if (240 <= h && h < 300) {
  r = x; g = 0; b = c;
  } else if (300 <= h && h < 360) {
  r = c; g = 0; b = x;
  }
  // Having obtained RGB, convert channels to hex
  int _r = ((r + m) * 255).round();
  int _g = ((g + m) * 255).round();
  int _b = ((b + m) * 255).round();

  return Color.fromARGB(0xff, _r, _g, _b);
  }


Color colorRotate(Color color, double degrees) {
  Map<String, double> hsl = colorToHSL(color);
  double hue = hsl["h"]??0;
  hue = (hue + degrees) % 360;
  hue = hue < 0 ? 360 + hue : hue;
  hsl["h"] = hue;
  return HSLToColor(hsl);
}