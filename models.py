from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Product(db.Model):
    """SQLAlchemy model for a product."""
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    price = db.Column(db.Float, nullable=False)
    description = db.Column(db.String(200), nullable=True)

    def to_dict(self) -> dict:
        """Serialize the product to a dictionary."""
        return {
            'id': self.id,
            'name': self.name,
            'price': self.price,
            'description': self.description
        } 