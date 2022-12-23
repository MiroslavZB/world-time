#ifndef FLUTTER_PLUGIN_WORLDTIME_PLUGIN_H_
#define FLUTTER_PLUGIN_WORLDTIME_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace worldtime {

class WorldtimePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WorldtimePlugin();

  virtual ~WorldtimePlugin();

  // Disallow copy and assign.
  WorldtimePlugin(const WorldtimePlugin&) = delete;
  WorldtimePlugin& operator=(const WorldtimePlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace worldtime

#endif  // FLUTTER_PLUGIN_WORLDTIME_PLUGIN_H_
