//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <bitsdojo_window_linux/bitsdojo_window_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) bitsdojo_window_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BitsdojoWindowPlugin");
  bitsdojo_window_plugin_register_with_registrar(bitsdojo_window_linux_registrar);
}
