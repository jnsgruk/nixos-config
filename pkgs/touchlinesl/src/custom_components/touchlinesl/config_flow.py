import homeassistant.helpers.config_validation as cv
import voluptuous as vol
from homeassistant import config_entries
from homeassistant.helpers.selector import selector

from .const import (
    CONF_AUTH_TOKEN,
    CONF_MODULE,
    CONF_PASSWORD,
    CONF_USER_ID,
    CONF_USERNAME,
    CONFIG_ENTRY_VERSION,
    DOMAIN,
)
from .touchline import TouchlineSLAccount


# TODO: Add some errors/exceptions around the login and module listing
class TouchlineSLConfigFlow(config_entries.ConfigFlow, domain=DOMAIN):
    """Config flow handler for Touchline SL."""

    VERSION = CONFIG_ENTRY_VERSION

    def __init__(self):
        self.touchline_account = None
        self.data = {}

    async def async_step_user(self, user_input=None):
        """Enter username and password for touchlinesl web service."""

        if user_input is not None:
            self.data.update(user_input)
            return await self.async_step_module(user_input)

        data_schema = {
            vol.Required(CONF_USERNAME): cv.string,
            vol.Required(CONF_PASSWORD): cv.string,
        }

        return self.async_show_form(
            step_id="user",
            data_schema=vol.Schema(data_schema),
        )

    async def async_step_module(self, user_input=None):
        modules = []
        if user_input is not None:
            username = user_input.get(CONF_USERNAME)
            password = user_input.get(CONF_PASSWORD)
            module_id = user_input.get(CONF_MODULE)
            self.data.update(user_input)

            self.touchline_account = TouchlineSLAccount(
                username=username, password=password
            )

            if username and password:
                auth = await self.touchline_account.login()
                if auth:
                    self.data[CONF_USER_ID] = auth.user_id
                    self.data[CONF_AUTH_TOKEN] = auth.token
                    modules = await self.touchline_account.modules()

            if module_id:
                return self.async_create_entry(
                    title=self.data[CONF_USERNAME], data=self.data
                )

        data_schema = {
            CONF_MODULE: selector(
                {
                    "select": {
                        "options": [
                            {"label": s["name"], "value": s["udid"]} for s in modules
                        ]
                    }
                }
            )
        }

        return self.async_show_form(
            step_id="module",
            data_schema=vol.Schema(data_schema),
        )
