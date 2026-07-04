import os
import socket

import psycopg2
from flask import Flask, jsonify

app = Flask(__name__)

DB_HOST = os.environ.get("DB_HOST", "db")
DB_PORT = os.environ.get("DB_PORT", "5432")
DB_NAME = os.environ.get("DB_NAME", "playground")
DB_USER = os.environ.get("DB_USER", "playground")
DB_PASSWORD = os.environ.get("DB_PASSWORD", "playground")


def get_connection():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
    )


@app.get("/healthz")
def healthz():
    return jsonify(status="ok")


@app.get("/api/visits")
def visits():
    conn = get_connection()
    try:
        with conn:
            with conn.cursor() as cur:
                cur.execute("INSERT INTO visits DEFAULT VALUES")
                cur.execute("SELECT count(*) FROM visits")
                count = cur.fetchone()[0]
    finally:
        conn.close()

    return jsonify(count=count, served_by=socket.gethostname())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
