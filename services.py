from models import db, Product

class ProductService:
    @staticmethod
    def get_all_products():
        return Product.query.all()

    @staticmethod
    def create_product(data):
        product = Product(
            name=data['name'],
            price=data['price'],
            description=data.get('description')
        )
        db.session.add(product)
        db.session.commit()
        return product

    @staticmethod
    def update_product(product, data):
        product.name = data.get('name', product.name)
        product.price = data.get('price', product.price)
        product.description = data.get('description', product.description)
        db.session.commit()
        return product

    @staticmethod
    def delete_product(product):
        db.session.delete(product)
        db.session.commit() 