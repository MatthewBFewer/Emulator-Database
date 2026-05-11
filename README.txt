COMP 3005 Project
Matthew Fewer - 101338805
Due: April 8th, 2026

Youtube video link:
https://youtu.be/N-kQRnIoObQ

--Languages/tech stack--
Database: SQLite (don't worry, I did not use MongoDB)
Backend: Flask (a web framework for python)
Frontend/Templates: HTML/Jinja2/CSS

Database file name: ultimate_retro_game_archive.db

table names for grading/querying from the command line:
consoles
emulators
roms
manuals
emu_compatibility
rom_compatibility

Run instructions:
- Ensure you have a recent version of Python installed (this was made and
  tested with 3.12.6, other patches should probably work)
- you will also need to run the following command:
  `py -m pip install flask` (alternatively `python -m pip install flask`)
- open up a terminal and navigate to the project's directory
- run the command:
    `py app.py` (alternatively `python app.py`)
- open http://127.0.0.1:5000/ in your browser