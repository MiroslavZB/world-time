#include "include/worldtime/worldtime_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define WORLDTIME_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), worldtime_plugin_get_type(), \
                              WorldtimePlugin))

struct _WorldtimePlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(WorldtimePlugin, worldtime_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void worldtime_plugin_handle_method_call(
    WorldtimePlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  fl_method_call_respond(method_call, response, nullptr);
}

static void worldtime_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(worldtime_plugin_parent_class)->dispose(object);
}

static void worldtime_plugin_class_init(WorldtimePluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = worldtime_plugin_dispose;
}

static void worldtime_plugin_init(WorldtimePlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  WorldtimePlugin* plugin = WORLDTIME_PLUGIN(user_data);
  worldtime_plugin_handle_method_call(plugin, method_call);
}

void worldtime_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  WorldtimePlugin* plugin = WORLDTIME_PLUGIN(
      g_object_new(worldtime_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "worldtime",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
