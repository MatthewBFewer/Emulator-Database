# backend

from flask import flash, Flask, render_template, request, redirect, url_for
import sqlite3
from contextlib import contextmanager

app = Flask(__name__)
DATABASE = "ultimate_retro_game_archive.db"
app.secret_key = "dev"

@contextmanager
def db():
    conn = get_db_connection()
    try:
        yield conn
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


def query_all(query, params=()):
    with db() as conn:
        return conn.execute(query, params).fetchall()


def query_one(query, params=()):
    with db() as conn:
        return conn.execute(query, params).fetchone()

# Database connection helper function
def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON") #enforces foreign key correctness
    return conn

# Initialize DB (this isnt called, it is just used for testing)
def init_db():
    with get_db_connection() as conn:
        for file in ("create_tables.sql", "populate_tables.sql"):
            with open(file) as f:
                conn.executescript(f.read())

# Home Page
@app.route("/")
def index(): return render_template("index.html")

# consoles (read-only, we only need a SELECT statement)
@app.route("/consoles")
def consoles():
    consoles = query_all("""
        SELECT c.company, c.name AS console, c.console_id,
               GROUP_CONCAT(DISTINCT e.name) AS emulator_names,
               GROUP_CONCAT(DISTINCT e.emulator_id) AS emulator_ids
        FROM consoles c
        LEFT JOIN emu_compatibility ec ON c.console_id = ec.console_id
        LEFT JOIN emulators e ON ec.emulator_id = e.emulator_id
        GROUP BY c.console_id, c.company, c.name
        ORDER BY c.company, c.name
    """)
    return render_template("consoles.html", consoles=consoles)

# emulators CRUD
@app.route("/emulators")
def emulators():
    return render_template("emulators.html", emulators=query_all("SELECT * FROM emulators"))

@app.route("/emulator/<int:emulator_id>")
def emulator_detail(emulator_id):
    emulator = query_one("SELECT * FROM emulators WHERE emulator_id = ?", (emulator_id,))
    roms = query_all("""
        SELECT r.* FROM roms r
        JOIN rom_compatibility rc ON r.rom_id = rc.rom_id
        WHERE rc.emulator_id = ?
    """, (emulator_id,))
    consoles = query_all("""
        SELECT c.name FROM consoles c
        JOIN emu_compatibility ec ON c.console_id = ec.console_id
        WHERE ec.emulator_id = ?
    """, (emulator_id,))
    return render_template("emulator_detail.html", emulator=emulator, roms=roms, consoles=consoles)

@app.route("/emulator/create", methods=("GET", "POST"))
def create_emulator():
    with get_db_connection() as conn:
        if request.method == "POST":
            name, link = request.form["name"], request.form["link"]
            year, console_ids = request.form.get("year"), request.form.getlist("console_ids")
            try:
                conn.execute("BEGIN")
                emulator_id = conn.execute(
                    "INSERT INTO emulators (name, link, year) VALUES (?, ?, ?)",
                    (name, link, year)
                ).lastrowid
                conn.executemany(
                    "INSERT INTO emu_compatibility (emulator_id, console_id) VALUES (?, ?)",
                    [(emulator_id, cid) for cid in console_ids]
                )
                conn.commit()
                return redirect(url_for("emulators"))
            except Exception as e:
                conn.rollback()
                flash(f"Error creating emulator: {str(e)}")
        consoles = conn.execute("SELECT console_id, name FROM consoles ORDER BY name").fetchall()
        return render_template("create_emulator.html", consoles=consoles)

@app.route("/emulator/edit/<int:emulator_id>", methods=("GET", "POST"))
def edit_emulator(emulator_id):
    with get_db_connection() as conn:
        emulator = conn.execute("SELECT * FROM emulators WHERE emulator_id = ?", (emulator_id,)).fetchone()
        current_console_ids = [r["console_id"] for r in conn.execute(
            "SELECT console_id FROM emu_compatibility WHERE emulator_id=?", (emulator_id,)
        )]

        if request.method == "POST":
            name, link = request.form["name"], request.form["link"]
            year, console_ids = request.form.get("year"), request.form.getlist("console_ids")
            try:
                conn.execute("BEGIN")
                conn.execute("UPDATE emulators SET name=?, link=?, year=? WHERE emulator_id=?",
                             (name, link, year, emulator_id))
                conn.execute("DELETE FROM emu_compatibility WHERE emulator_id=?", (emulator_id,))
                conn.executemany(
                    "INSERT INTO emu_compatibility (emulator_id, console_id) VALUES (?, ?)",
                    [(emulator_id, cid) for cid in console_ids]
                )
                conn.commit()
                return redirect(url_for("emulators"))
            except Exception as e:
                conn.rollback()
                flash(f"Error updating emulator: {str(e)}")

        consoles = conn.execute("SELECT console_id, name FROM consoles ORDER BY name").fetchall()
        return render_template("edit_emulator.html", emulator=emulator,
                               consoles=consoles, current_console_ids=current_console_ids)

@app.route("/emulator/delete/<int:emulator_id>", methods=("POST",))
def delete_emulator(emulator_id):
    with get_db_connection() as conn:
        for tbl in ("emu_compatibility", "rom_compatibility"):
            conn.execute(f"DELETE FROM {tbl} WHERE emulator_id=?", (emulator_id,))
    return redirect(url_for("emulators"))

# roms CRUD
@app.route("/roms")
def roms():
    #filters

    query, params = "SELECT * FROM roms WHERE 7=7", []

    #for text fields
    for field in ("title", "genre", "publisher", "region"):
        if val := request.args.get(field):
            query += f" AND {field} LIKE ?"
            params.append(f"%{val}%")

    #for year (the only integer field)
    if val := request.args.get("year"):
        query += " AND year = ?"; params.append(val)

    return render_template("roms.html", roms=query_all(query, params))

@app.route("/rom/create", methods=("GET", "POST"))
def create_rom():
    if request.method == "POST":
        with get_db_connection() as conn:
            conn.execute("""
                INSERT OR IGNORE INTO roms (link, title, year, genre, publisher, region)
                VALUES (?, ?, ?, ?, ?, ?)
            """, tuple(request.form.get(k) for k in
                        ("link", "title", "year", "genre", "publisher", "region")))
        return redirect(url_for("roms"))
    return render_template("create_rom.html")

@app.route("/rom/edit/<int:rom_id>", methods=("GET", "POST"))
def edit_rom(rom_id):
    with get_db_connection() as conn:
        rom = conn.execute("SELECT * FROM roms WHERE rom_id = ?", (rom_id,)).fetchone()
        if request.method == "POST":
            try:
                conn.execute("BEGIN")
                conn.execute("""
                    UPDATE roms SET title=?, year=?, genre=?, publisher=?, region=?, link=?
                    WHERE rom_id=?
                """, (*[request.form.get(k) for k in
                        ("title", "year", "genre", "publisher", "region", "link")], rom_id))
                conn.commit()
            except Exception as e:
                conn.rollback(); flash(f"Error updating ROM: {str(e)}")
            return redirect(url_for("roms"))
    return render_template("edit_rom.html", rom=rom)

@app.route("/rom/delete/<int:rom_id>", methods=["POST"])
def delete_rom(rom_id):
    with get_db_connection() as conn:
        try:
            conn.execute("BEGIN")
            conn.execute("DELETE FROM rom_compatibility WHERE rom_id = ?", (rom_id,))
            conn.execute("DELETE FROM roms WHERE rom_id = ?", (rom_id,))
            conn.commit()
        except Exception as e:
            conn.rollback(); flash(f"Error deleting ROM: {str(e)}")
    return redirect(url_for("roms"))

# manuals CRUD
@app.route("/manuals")
def manuals():
    return render_template("manuals.html", manuals=query_all("SELECT * FROM manuals"))

@app.route("/manual/create", methods=("GET", "POST"))
def create_manual():
    with get_db_connection() as conn:
        if request.method == "POST":
            try:
                conn.execute("""
                    INSERT INTO manuals (pdf_link, title, language, rom_link)
                    VALUES (?, ?, ?, ?)
                """, tuple(request.form.get(k) for k in
                            ("pdf_link", "title", "language", "rom_link")))
                conn.commit()
                return redirect(url_for("manuals"))
            except sqlite3.IntegrityError:
                flash("Error: Manual already exists or invalid data.")
        return render_template("create_manual.html")

@app.route("/manual/edit/<int:manual_id>", methods=("GET", "POST"))
def edit_manual(manual_id):
    with get_db_connection() as conn:
        manual = conn.execute("SELECT * FROM manuals WHERE manual_id = ?", (manual_id,)).fetchone()
        if request.method == "POST":
            try:
                conn.execute("BEGIN")
                conn.execute("""
                    UPDATE manuals SET title=?, language=?, rom_link=?, pdf_link=?
                    WHERE manual_id=?
                """, (*[request.form.get(k) for k in
                        ("title", "language", "rom_link", "pdf_link")], manual_id))
                conn.commit()
                return redirect(url_for("manuals"))
            except Exception as e:
                conn.rollback(); flash(f"Error updating manual: {str(e)}")
        return render_template("edit_manual.html", manual=manual)

@app.route("/manual/delete/<int:manual_id>", methods=["POST"])
def delete_manual(manual_id):
    with get_db_connection() as conn:
        try:
            conn.execute("BEGIN")
            conn.execute("DELETE FROM manuals WHERE manual_id = ?", (manual_id,))
            conn.commit()
        except Exception as e:
            conn.rollback(); flash(f"Error deleting manual: {str(e)}")
    return redirect(url_for("manuals"))

# Run the app
if __name__ == "__main__":
    # init_db()
    app.run()
