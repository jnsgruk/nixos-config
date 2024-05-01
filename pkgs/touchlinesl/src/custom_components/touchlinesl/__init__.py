"""The Roth Touchline SL integration."""

from __future__ import annotations

from homeassistant import config_entries
from homeassistant.config_entries import ConfigEntry
from homeassistant.const import Platform
from homeassistant.core import HomeAssistant
from homeassistant.helpers.typing import ConfigType

from .const import (
    CONF_AUTH_TOKEN,
    CONF_MODULE,
    CONF_PASSWORD,
    CONF_USER_ID,
    CONF_USERNAME,
    DOMAIN,
)


async def async_setup(hass: HomeAssistant, config: ConfigType) -> bool:
    """Roth TouclineSL configuration setup."""
    hass.data[DOMAIN] = {}

    if DOMAIN not in config:
        return True

    conf = config[DOMAIN]

    if not hass.config_entries.async_entries(DOMAIN):
        hass.async_create_task(
            hass.config_entries.flow.async_init(
                DOMAIN,
                context={"source": config_entries.SOURCE_IMPORT},
                data={
                    CONF_USERNAME: conf[CONF_USERNAME],
                    CONF_PASSWORD: conf[CONF_PASSWORD],
                    CONF_USER_ID: conf[CONF_USER_ID],
                    CONF_MODULE: conf[CONF_MODULE],
                    CONF_AUTH_TOKEN: conf[CONF_AUTH_TOKEN],
                },
            )
        )
    return True


async def async_setup_entry(hass: HomeAssistant, entry: ConfigEntry) -> bool:
    """Set up Roth TouchlineSL from a config entry."""
    hass.data.setdefault(DOMAIN, {})
    hass.data[DOMAIN][entry.entry_id] = entry.data
    hass.async_create_task(
        hass.config_entries.async_forward_entry_setup(entry, Platform.CLIMATE)
    )
    return True
