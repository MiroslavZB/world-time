#include "include/worldtime/worldtime_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "worldtime_plugin.h"

void WorldtimePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  worldtime::WorldtimePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
