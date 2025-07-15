from models import db, Product

class ProductService:
    """Service class for product operations."""
    @staticmethod
    def get_all_products() -> list:
        """Return all products from the database."""
        return Product.query.all()

    @staticmethod
    def create_product(data: dict) -> Product:
        """Create and persist a new product."""
        try:
            product = Product(
                name=data['name'],
                price=data['price'],
                description=data.get('description')
            )
            db.session.add(product)
            db.session.commit()
            return product
        except Exception as e:
            db.session.rollback()
            raise e

    @staticmethod
    def update_product(product: Product, data: dict) -> Product:
        """Update an existing product with new data."""
        try:
            product.name = data.get('name', product.name)
            product.price = data.get('price', product.price)
            product.description = data.get('description', product.description)
            db.session.commit()
            return product
        except Exception as e:
            db.session.rollback()
            raise e

    @staticmethod
    def delete_product(product: Product) -> None:
        """Delete a product from the database."""
        try:
            db.session.delete(product)
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e 