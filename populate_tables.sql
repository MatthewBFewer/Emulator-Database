BEGIN TRANSACTION;

--extra layer of safety
DELETE FROM rom_compatibility;
DELETE FROM emu_compatibility;
DELETE FROM manuals;
DELETE FROM roms;
DELETE FROM emulators;
DELETE FROM consoles;


--ROM data
INSERT OR IGNORE INTO roms (link, title, year, genre, publisher, region)
VALUES
('https://vimm.net/vault/1652', 'Super Mario World', 1991, 'Platformer', 'Nintendo', 'US'),
('https://vimm.net/vault/1653', 'Super Mario World 2: Yoshi''s Island', 1995, 'Platformer', 'Nintendo', 'US'),
('https://vimm.net/vault/834', 'Super Mario Bros', 1985, 'Platformer', 'Nintendo', 'World'),
('https://vimm.net/vault/1169', 'Donkey Kong Country', 1994, 'Platformer', 'Nintendo', 'US'),
('https://vimm.net/vault/1199', 'EarthBound', 1995, 'Role-playing', 'Nintendo', 'US'),
('https://vimm.net/vault/504', 'Legend of Zelda, The', 1986, 'Action-adventure', 'Nintendo', 'US'),
('https://vimm.net/vault/1346', 'Legend of Zelda: A Link to the Past, The', 1992, 'Action-adventure', 'Nintendo', 'US'),
('https://vimm.net/vault/558', 'Metroid', 1986, 'Action-adventure', 'Nintendo', 'US'),
('https://vimm.net/vault/1654', 'Super Metroid', 1994, 'Action-adventure', 'Nintendo', 'US/JP'),
('https://vimm.net/vault/76627', 'Mega Man 2', 1988, 'Platformer', 'Capcom', 'EU'),
('https://vimm.net/vault/1386', 'Mega Man X', 1993, 'Platformer', 'Capcom', 'US'),
('https://vimm.net/vault/157', 'Castlevania', 1987, 'Action', 'Konami', 'US'),
('https://vimm.net/vault/19288', 'Mario Kart DS', 2005, 'Racing', 'Nintendo', 'US/AU'),
('https://vimm.net/vault/17746', 'Mario Kart Wii', 2008, 'Racing', 'Nintendo', 'US'),
('https://vimm.net/vault/78696', 'Call of Duty: Black Ops', 2010, 'Shooter', 'Activision', 'US/EU'),
('https://vimm.net/vault/1127', 'Chrono Trigger', 1995, 'Role-playing', 'Square', 'US'),
('https://vimm.net/vault/19596', 'Pokemon: Platinum version', 2009, 'Role-playing', 'Nintendo', 'US'),
('https://vimm.net/vault/1609', 'Street Fighter II turbo', 1993, 'Fighting', 'Capcom', 'US'),
('https://vimm.net/vault/51763', 'Street Fighter Alpha 3', 1998, 'Fighting', 'Capcom', 'EU'),
('https://vimm.net/vault/1407', 'Mortal Kombat', 1993, 'Fighting', 'Midway', 'US'),
('https://vimm.net/vault/8435', 'Grand Theft Auto: Vice City', 2002, 'Role-Playing', 'Rockstar', 'US'),
('https://vimm.net/vault/8427', 'Gran Turismo 4', 2005, 'Racing', 'Sony', 'US/CA'),
('https://vimm.net/vault/8933', 'Need for Speed: Underground', 2003, 'Racing', 'EA', 'US/CA'),
('https://vimm.net/vault/7395', 'F-Zero GX', 2003, 'Racing', 'Nintendo', 'US'),
('https://vimm.net/vault/2795', 'Wave Race 64', 1996, 'Racing', 'Nintendo', 'US'),
('https://vimm.net/vault/2764', 'Super Mario 64', 1996, 'Platformer', 'Nintendo', 'US'),
('https://vimm.net/vault/7818', 'Super Smash Bros. Melee', 2001, 'Fighting', 'Nintendo', 'US'),
('https://vimm.net/vault/78231', 'Halo 3', 2007, 'Shooter', 'Microsoft', 'US/EU'),
('https://vimm.net/vault/1173', 'Doom', 1993, 'Shooter', 'id Software', 'US'),
('https://vimm.net/vault/6855', 'Quake II', 1997, 'Shooter', 'id Software', 'US'),
('https://vimm.net/vault/79837', 'Minecraft: Xbox 360 Edition', 2011, 'Sandbox', '4J Studios', 'World'),
('https://vimm.net/vault/9108', 'Resident Evil 4', 2005, 'Survival horror', 'Capcom', 'US'),
('https://vimm.net/vault/66448', 'Silent Hill 2', 2001, 'Survival horror', 'Konami', 'EU'),
('https://vimm.net/vault/5943', 'Metal Gear Solid', 1998, 'Stealth', 'Konami', 'US'),
('https://vimm.net/vault/18177', 'Super Smash Bros. Brawl', 2008, 'Fighting', 'Nintendo', 'US'),
('https://vimm.net/vault/6229', 'Tony Hawk''s Pro Skater 2', 2000, 'Sports', 'Activision', 'US'),
('https://vimm.net/vault/7492', 'Luigi''s Mansion', 2001, 'Action-Adventure', 'Nintendo', 'US/CA'),
('https://vimm.net/vault/1420', 'NBA Jam', 1993, 'Sports', 'Midway', 'US'),
('https://vimm.net/vault/3454', 'Pokemon: Red Version', 1998, 'Role-playing', 'Nintendo', 'US/EU'),
('https://vimm.net/vault/4231', 'Pokemon: Gold Version', 2000, 'Role-playing', 'Nintendo', 'US/EU'),
('https://vimm.net/vault/5625', 'Pokemon: Emerald Version', 2005, 'Role-playing', 'Nintendo', 'US/EU'),
('https://vimm.net/vault/79814', 'Shaun White Skateboarding', 2010, 'Sports', 'Ubisoft', 'US/EU'),
('https://vimm.net/vault/1336', 'Kirby Super Star', 1996, 'Platformer', 'Nintendo', 'US'),
('https://vimm.net/vault/2754', 'Star Fox 64', 1997, 'Shooter', 'Nintendo', 'US'),
('https://vimm.net/vault/40323', 'Banjo-Kazooie', 1998, 'Platformer', 'Rare', 'EU'),
('https://vimm.net/vault/5953', 'Crash Bandicoot', 1996, 'Platformer', 'Sony', 'US'),
('https://vimm.net/vault/3472', 'Tetris', 1989, 'Puzzle', 'Nintendo', 'World'),
('https://vimm.net/vault/6040', 'Spyro the Dragon', 1998, 'Platformer', 'Sony', 'US');


-- Consoles
INSERT OR IGNORE INTO consoles (name, year, company) VALUES
('NES', 1983, 'Nintendo'),
('SNES', 1990, 'Nintendo'),
('Virtual Boy', 1995, 'Nintendo'),
('N64', 1996, 'Nintendo'),
('GameCube', 2001, 'Nintendo'),
('Wii', 2006, 'Nintendo'),
('Wii U', 2012, 'Nintendo'),
('Game Boy', 1989, 'Nintendo'),
('Game Boy Color', 1998, 'Nintendo'),
('Game Boy Advance', 2001, 'Nintendo'),
('DS', 2004, 'Nintendo'),
('3DS', 2011, 'Nintendo'),
('PlayStation', 1994, 'Sony'),
('PlayStation 2', 2000, 'Sony'),
('PlayStation 3', 2006, 'Sony'),
('PSP', 2004, 'Sony'),
('PSVita', 2011, 'Sony'),
('Xbox', 2001, 'Microsoft'),
('Xbox 360', 2005, 'Microsoft'),
('Genesis', 1988, 'Sega'),
('Saturn', 1994, 'Sega'),
('Dreamcast', 1998, 'Sega'),
('Game Gear', 1990, 'Sega');


-- Emulators
INSERT OR IGNORE INTO emulators (link, name, year) VALUES
('https://www.snes9x.com/', 'Snex9x', 1999),
('https://dolphin-emu.org/', 'Dolphin', 2008),
('https://nestopia.sourceforge.net/', 'Nestopia', 2003),
('https://www.mupen64plus.org/', 'Mupen64Plus', 2007),
('https://melonds.kuribo64.net/', 'melonDS', 2016),
('https://www.epsxe.com/', 'ePSXe', 2000),
('https://pcsx2.net/', 'PCSX2', 2002),
('https://xenia.jp/', 'Xenia', 2013),
('https://visualboyadvance-m.org/', 'VisualBoyAdvance-M', 2004),
('https://mgba.io/', 'mGBA', 2013);

-- Manuals
INSERT OR IGNORE INTO manuals (pdf_link, title, language, rom_link, rom_id)
VALUES
('https://vimm.net/manual/4770', 'Super Mario World Manual', 'English', 'https://vimm.net/vault/1652',
    (SELECT rom_id FROM roms WHERE title='Super Mario World')),
('https://vimm.net/manual/4771', 'Super Mario World 2 Manual', 'English', 'https://vimm.net/vault/1653',
    (SELECT rom_id FROM roms WHERE title='Super Mario World 2: Yoshi''s Island')),
('https://vimm.net/manual/2720', 'Need for Speed: Underground Manual', 'English', 'ttps://vimm.net/vault/8933',
    (SELECT rom_id FROM roms WHERE title='Need for Speed: Underground'));


-- Emulator to Console compatibility

-- SNES
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='Snex9x'), (SELECT console_id FROM consoles WHERE name='SNES'));
-- Wii
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='Dolphin'), (SELECT console_id FROM consoles WHERE name='Wii'));
-- NES
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='Nestopia'), (SELECT console_id FROM consoles WHERE name='NES'));
-- N64
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='Mupen64Plus'), (SELECT console_id FROM consoles WHERE name='N64'));
-- GameCube (also dolphin)
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='Dolphin'), (SELECT console_id FROM consoles WHERE name='GameCube'));
-- DS
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='melonDS'), (SELECT console_id FROM consoles WHERE name='DS'));
-- PS1
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='ePSXe'), (SELECT console_id FROM consoles WHERE name='PlayStation'));
-- PS2
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='PCSX2'), (SELECT console_id FROM consoles WHERE name='PlayStation 2'));
-- Xbox 360
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='Xenia'), (SELECT console_id FROM consoles WHERE name='Xbox 360'));
-- GBA (for GBA, original, and GBC)
INSERT OR IGNORE INTO emu_compatibility (emulator_id, console_id) VALUES
((SELECT emulator_id FROM emulators WHERE name='mGBA'), (SELECT console_id FROM consoles WHERE name='Game Boy Advance')),
((SELECT emulator_id FROM emulators WHERE name='mGBA'), (SELECT console_id FROM consoles WHERE name='Game Boy')),
((SELECT emulator_id FROM emulators WHERE name='mGBA'), (SELECT console_id FROM consoles WHERE name='Game Boy Color'));


-- ROM to Emulator compatibility

-- SNES
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='Snex9x')
FROM roms WHERE title IN (
    'Super Mario World',
    'Super Mario World 2: Yoshi''s Island',
    'Donkey Kong Country',
    'EarthBound',
    'Legend of Zelda: A Link to the Past, The',
    'Super Metroid',
    'Mega Man X',
    'Chrono Trigger',
    'Street Fighter II turbo',
    'Kirby Super Star',
    'Mortal Kombat',
    'Doom',
    'NBA Jam'
);
-- NES
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='Nestopia')
FROM roms WHERE title IN (
    'Super Mario Bros',
    'Legend of Zelda, The',
    'Metroid',
    'Mega Man 2',
    'Castlevania'
);

-- N64
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='Mupen64Plus')
FROM roms WHERE title IN (
    'Wave Race 64',
    'Super Mario 64',
    'Star Fox 64',
    'Banjo-Kazooie'
);

-- GameCube + Wii
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='Dolphin')
FROM roms WHERE title IN (
    'Super Smash Bros. Melee',
    'Luigi''s Mansion',
    'F-Zero GX',
    'Mario Kart Wii',
    'Super Smash Bros. Brawl'
);

-- DS
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='melonDS')
FROM roms WHERE title IN (
    'Mario Kart DS',
    'Pokemon: Platinum version'
);

-- PS1
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='ePSXe')
FROM roms WHERE title IN (
    'Street Fighter Alpha 3',
    'Metal Gear Solid',
    'Tony Hawk''s Pro Skater 2',
    'Crash Bandicoot',
    'Spyro the Dragon',
    'Quake II'
);

-- PS2
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='PCSX2')
FROM roms WHERE title IN (
    'Grand Theft Auto: Vice City',
    'Gran Turismo 4',
    'Need for Speed: Underground',
    'Resident Evil 4',
    'Silent Hill 2'
);

-- Xbox 360
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='Xenia')
FROM roms WHERE title IN (
    'Halo 3',
    'Minecraft: Xbox 360 Edition',
    'Shaun White Skateboarding',
    'Call of Duty: Black Ops'
);

-- Game Boy ROMs (use mGBA)
INSERT OR IGNORE INTO rom_compatibility (rom_id, emulator_id)
SELECT rom_id, (SELECT emulator_id FROM emulators WHERE name='mGBA')
FROM roms WHERE title IN (
    'Pokemon: Red Version',
    'Pokemon: Gold Version',
    'Pokemon: Emerald Version',
    'Tetris'
);

COMMIT;