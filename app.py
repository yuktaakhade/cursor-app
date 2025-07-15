import logging
from dotenv import load_dotenv
from flask import Flask
from models import db
from routes import bp
import os

load_dotenv()

def create_app() -> Flask:
    """Application factory for Flask app."""
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI', 'sqlite:///products.db')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)
    app.register_blueprint(bp)
    with app.app_context():
        db.create_all()
    return app

if __name__ == '__main__':
    app = create_app()
    debug_mode = os.getenv('FLASK_DEBUG', 'True') == 'True'
    app.run(debug=debug_mode) 