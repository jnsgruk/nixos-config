import asyncio
import json
import os
from dataclasses import dataclass

import aiohttp

# from .const import API_URL
API_URL = "https://roth-touchlinesl.com/api/v1"

THERMOSTAT_MODES = ["constantTemp", "globalSchedule", "localSchedule"]


@dataclass
class LoginResponse:
    authenticated: bool
    user_id: int
    access_google_home: bool
    token: str


@dataclass
class TouchlineSLZone:
    id: str
    name: str


@dataclass
class TouchlineSLSchedule:
    id: str
    name: str


class TouchlineSLAccount:
    def __init__(self, *, username, password):
        self.username = username
        self.password = password
        self.auth = None

    async def login(self):
        async with aiohttp.ClientSession() as session:
            data = {"username": self.username, "password": self.password}
            r = await session.post(f"{API_URL}/authentication", json=data)

        if r.status == 200:
            response_json = await r.json()
            self.auth = LoginResponse(**response_json)
            return LoginResponse(**response_json)
        else:
            return None

    async def authenticated(self) -> bool:
        if self.auth is None:
            return False

        async with aiohttp.ClientSession() as session:
            r = await session.get(
                f"{API_URL}/authentication",
                headers={"authorization": "Bearer " + self.auth.token},
            )
            response_json = await r.json()
            return response_json.get("authenticated", False)

    async def modules(self):
        if self.auth is None:
            raise Exception("not authenticated")

        async with aiohttp.ClientSession() as session:
            r = await session.get(
                f"{API_URL}/users/{self.auth.user_id}/modules",
                headers={"authorization": "Bearer " + self.auth.token},
            )

        return await r.json()


class TouchlineSLModule:
    def __init__(self, *, user_id, token, module_id):
        self.token = token
        self.user_id = user_id
        self.module_id = module_id
        self.info = None

    async def update(self):
        self.info = await self._module_info()

    async def _module_info(self):
        async with aiohttp.ClientSession() as session:
            r = await session.get(
                f"{API_URL}/users/{self.user_id}/modules/{self.module_id}",
                headers={"authorization": "Bearer " + self.token},
            )
            return await r.json()

    def zones(self):
        elements = self.info["zones"]["elements"]
        return [
            TouchlineSLZone(id=z["zone"]["id"], name=z["description"]["name"])
            for z in elements
            if z["zone"]["zoneState"] != "zoneOff"
        ]

    def zone_name(self, zone_id):
        elements = self.info["zones"]["elements"]
        zone = next((z for z in elements if z["zone"]["id"] == zone_id))
        return zone["description"]["name"]

    def zone_current_temperature(self, zone_id):
        elements = self.info["zones"]["elements"]
        zone = next((z for z in elements if z["zone"]["id"] == zone_id))
        return float(int(zone["zone"]["currentTemperature"]) / 10)

    def zone_target_temperature(self, zone_id):
        elements = self.info["zones"]["elements"]
        zone = next((z for z in elements if z["zone"]["id"] == zone_id))
        return float(int(zone["zone"]["setTemperature"]) / 10)

    def schedules(self):
        elements = self.info["zones"]["globalSchedules"]["elements"]
        return [TouchlineSLSchedule(id=s["id"], name=s["name"]) for s in elements]


async def test(account):
    auth = await account.login()

    module = TouchlineSLModule(
        user_id=auth.user_id,
        token=auth.token,
        module_id="a7d227f31fc45c64c0c8eb83dc8d60ac",
    )
    await module.update()

    with open("dump.json", "w+") as f:
        f.write(json.dumps(await module._module_info(), indent=2))

    for zone in module.zones():
        print(zone.id, zone.name)

    for s in module.schedules():
        print(s.id, s.name)


if __name__ == "__main__":
    account = TouchlineSLAccount(
        username=os.getenv("TOUCHLINESL_LOGIN", ""),
        password=os.getenv("TOUCHLINESL_PASSWORD", ""),
    )
    loop = asyncio.get_event_loop()
    session = loop.run_until_complete(test(account))
