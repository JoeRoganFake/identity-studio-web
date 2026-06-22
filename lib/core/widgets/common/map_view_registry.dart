// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

void registerMapViewFactory() {
  ui_web.platformViewRegistry.registerViewFactory(
    'google-maps-iframe',
    (int viewId) {
      final iframe = html.IFrameElement()
        ..src =
            'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2624.47!2d17.1494781!3d48.168221!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x476c8ffc54e4ba73%3A0xa3da1de5712b7f89!2sIdentity%20studio!5e0!3m2!1sen!2ssk!4v1687654321'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true;
      return iframe;
    },
  );
}
