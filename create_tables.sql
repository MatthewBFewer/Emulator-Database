BEGIN TRANSACTION;
-- Main tables
CREATE TABLE IF NOT EXISTS consoles (
    console_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    year INTEGER,
    company TEXT
);

CREATE TABLE IF NOT EXISTS emulators (
    emulator_id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    name TEXT,
    year INTEGER
);

CREATE TABLE IF NOT EXISTS roms (
    rom_id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    title TEXT,
    year INTEGER,
    genre TEXT,
    publisher TEXT,
    region TEXT
);

CREATE TABLE IF NOT EXISTS manuals (
    manual_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pdf_link TEXT NOT NULL,
    title TEXT,
    language TEXT,
    rom_link TEXT,
    rom_id INTEGER,
    FOREIGN KEY (rom_id) REFERENCES roms(rom_id) ON DELETE CASCADE
);

-- junction tables
CREATE TABLE IF NOT EXISTS emu_compatibility (
    emulator_id INTEGER NOT NULL,
    console_id INTEGER NOT NULL,
    PRIMARY KEY (emulator_id, console_id),
    FOREIGN KEY (emulator_id) REFERENCES emulators(emulator_id) ON DELETE CASCADE,
    FOREIGN KEY (console_id) REFERENCES consoles(console_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rom_compatibility (
    rom_id INTEGER NOT NULL,
    emulator_id INTEGER NOT NULL,
    PRIMARY KEY (rom_id, emulator_id),
    FOREIGN KEY (rom_id) REFERENCES roms(rom_id) ON DELETE CASCADE,
    FOREIGN KEY (emulator_id) REFERENCES emulators(emulator_id) ON DELETE CASCADE
);

COMMIT;