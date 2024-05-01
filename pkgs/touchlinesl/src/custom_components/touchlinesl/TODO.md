- Exception handling for logins/api interactions
- Pass `hass` session into module/account client? :

```python
from homeassistant.helpers.aiohttp_client import (
    async_create_clientsession,
    async_get_clientsession,
)

# ...
session = async_get_clientsession(hass)
```

- Humidity support
- Set temp support
- Schedules/presets support
- Type annotations
- Unit tests
