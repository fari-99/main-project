# Custom Plugin

# Creating Custom Golang Plugin
1. copy folder `template_go_plugins` on `./servers/kong/plugins/template_go_plugins`
2. change `template_go_plugins` to your plugin name
3. add your plugin to [Dockerfile](../Dockerfile)
4. add your plugin to [plugins.env](./plugins.env) [DON'T FORGET TO ADD TO [plugins.env.example](./plugins.env.example)]
5. rebuild kong

# Adding Environment
There is 3 environment you need to know
1. `KONG_PLUGINS`: this is collection of plugin name, this env also will enabled your plugin, without this, you will not see your plugin in plugin list
2. `KONG_PLUGINSERVER_NAMES`: this is collection of plugin names
3. `KONG_PLUGINSERVER_[PLUGIN_NAME_WITH_UNDERSCORE]_[SOCKET/QUERY_CMD/START_CMD]`: this is where you put your plugin path

> NOTE: if path to your binary is not on "/usr/local/bin" then you need to add START and SOCKET environment, please check your Dockerfile where your plugin installed

> default .socket file is on `/usr/local/kong/plugin_name.socket`

## Example
```
KONG_PLUGINS=bundled,test_plugin
KONG_PLUGINSERVER_NAMES=test_plugin

KONG_PLUGINSERVER_TEST_PLUGIN_SOCKET=/usr/local/kong/test_plugin.socket
KONG_PLUGINSERVER_TEST_PLUGIN_START_CMD=/usr/local/bin/test_plugin
KONG_PLUGINSERVER_TEST_PLUGIN_QUERY_CMD=/usr/local/bin/test_plugin -dump
```