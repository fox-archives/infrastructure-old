instance-id: {{ container.name }}
local-hostname: {{ config_get("user.hostname", "localhost") }}
{{ config_get("user.meta-data", "") }}
