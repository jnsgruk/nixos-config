from homeassistant.components.climate import (
    ClimateEntity,
    ClimateEntityFeature,
    HVACMode,
)
from homeassistant.const import UnitOfTemperature

from .const import CONF_AUTH_TOKEN, CONF_MODULE, CONF_USER_ID, DOMAIN
from .touchline import TouchlineSLModule


async def async_setup_entry(hass, entry, async_add_entities):
    """Set up the Touchline devices."""

    config = hass.data[DOMAIN][entry.entry_id]

    module = TouchlineSLModule(
        user_id=config[CONF_USER_ID],
        token=config[CONF_AUTH_TOKEN],
        module_id=config[CONF_MODULE],
    )
    await module.update()

    async_add_entities(
        (TouchlineSLZone(id=z.id, name=z.name, module=module) for z in module.zones()),
        True,
    )


class TouchlineSLZone(ClimateEntity):
    """Roth TouchlineSL Zone."""

    _attr_temperature_unit = UnitOfTemperature.CELSIUS
    _attr_hvac_mode = HVACMode.HEAT
    _attr_hvac_modes = [HVACMode.HEAT]
    _attr_supported_features = ClimateEntityFeature.TARGET_TEMPERATURE

    def __init__(self, *, id, name, module):
        self.id = id
        self._module = module
        self._name = name

        self._attr_unique_id = f"touchlinesl-{self._module.module_id}-zone-{self.id}"

        self._current_temperature = None
        self._target_temperature = None
        self._current_operation_mode = None
        self._preset_mode = None

    async def async_update(self) -> None:
        """Update thermostat attributes."""
        await self._module.update()
        self._name = self._module.zone_name(self.id)
        self._current_temperature = self._module.zone_current_temperature(self.id)
        self._target_temperature = self._module.zone_target_temperature(self.id)

    @property
    def name(self):
        """Return the name of the climate device."""
        return self._name

    @property
    def current_temperature(self):
        """Return the current temperature."""
        return self._current_temperature

    @property
    def target_temperature(self):
        """Return the temperature we try to reach."""
        return self._target_temperature
