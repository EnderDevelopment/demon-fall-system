# Demon Fall System

A powerful FiveM script for auto-killing mobs with cooldown and duration settings.

## Features

- Auto-kill mobs within a specified radius
- Cooldown and duration settings
- Player-specific cooldown tracking

## Requirements

- FiveM server
- ESX Framework
- MySQL-Async

## Installation

1. Download the script files.
2. Place the files in your FiveM server's resources folder.
3. Add `start DemonFallSystem` to your server.cfg file.
4. Import the database.sql file into your MySQL database.

## Usage

- Players can activate the demon fall by using the `/demonfall` command.
- The script will automatically kill mobs within the specified radius.
- The cooldown and duration settings can be adjusted in the config.lua file.

## Configuration

The script can be configured using the config.lua file. The following settings are available:

- `DemonFallCooldown`: Cooldown in seconds (default: 300)
- `DemonFallDuration`: Duration in seconds (default: 10)
- `DemonFallRadius`: Radius in meters (default: 50.0)
- `AutoKillMobs`: Enable or disable auto kill mobs (default: true)
- `AutoKillMobsInterval`: Interval in seconds (default: 5)
- `AutoKillMobsRadius`: Radius in meters (default: 100.0)

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=demon-fall-system&utm_content=bottom) — describe it in one sentence and get the full source code.