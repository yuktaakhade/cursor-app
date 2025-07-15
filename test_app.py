import unittest
import json
from app import create_app, db
from models import Product

class ProductApiTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['TESTING'] = True
        self.app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
        self.client = self.app.test_client()
        with self.app.app_context():
            db.create_all()

    def tearDown(self):
        with self.app.app_context():
            db.session.remove()
            db.drop_all()

    def test_create_product(self):
        response = self.client.post('/products', json={
            'name': 'Test Product',
            'price': 9.99,
            'description': 'A test product.'
        })
        self.assertEqual(response.status_code, 201)
        data = response.get_json()
        self.assertEqual(data['name'], 'Test Product')

    def test_get_products(self):
        with self.app.app_context():
            db.session.add(Product(name='P1', price=1.0))  # type: ignore
            db.session.commit()
        response = self.client.get('/products')
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertTrue(isinstance(data, list))
        self.assertGreaterEqual(len(data), 1)

    def test_update_product(self):
        with self.app.app_context():
            p = Product(name='P2', price=2.0)  # type: ignore
            db.session.add(p)
            db.session.commit()
            pid = p.id
        response = self.client.put(f'/products/{pid}', json={'name': 'P2-updated', 'price': 3.0})
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertEqual(data['name'], 'P2-updated')
        self.assertEqual(data['price'], 3.0)

    def test_delete_product(self):
        with self.app.app_context():
            p = Product(name='P3', price=3.0)  # type: ignore
            db.session.add(p)
            db.session.commit()
            pid = p.id
        response = self.client.delete(f'/products/{pid}')
        self.assertEqual(response.status_code, 204)
        # Ensure it's gone
        response = self.client.get('/products')
        data = response.get_json()
        self.assertFalse(any(prod['id'] == pid for prod in data))

if __name__ == '__main__':
    result = unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(ProductApiTestCase))
    if result.wasSuccessful():
        print('unit test pass')
    else:
        print('unit test fail') 