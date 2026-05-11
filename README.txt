
--Languages/tech stack--
Database: SQLite
Backend: Flask
Frontend/Templates: HTML/Jinja2/CSS

Database file name: ultimate_retro_game_archive.db

database table names:
consoles
emulators
roms
manuals
emu_compatibility
rom_compatibility

instructions for running locally:
- Ensure you have a recent version of Python installed (this was made and
  tested with 3.12.6, other patches should probably work)
- you will also need to run the following command:
  `py -m pip install flask` (alternatively `python -m pip install flask`)
- open up a terminal and navigate to the project's directory
- run the command:
    `py app.py` (alternatively `python app.py`)
- open http://127.0.0.1:5000/ in your browser
