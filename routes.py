import logging
from flask import Blueprint, request, jsonify, abort
from models import db, Product
from services import ProductService

bp = Blueprint('products', __name__)

logger = logging.getLogger(__name__)

@bp.route('/')
def index():
    return "Welcome to the Product API! Visit /products to see the product list."

@bp.route('/products', methods=['GET'])
def get_products():
    """Get all products."""
    products = ProductService.get_all_products()
    return jsonify([p.to_dict() for p in products])

@bp.route('/products', methods=['POST'])
def create_product():
    """Create a new product."""
    data = request.get_json()
    if not data or 'name' not in data or 'price' not in data:
        logger.warning('Missing required fields in product creation.')
        abort(400, 'Missing required fields')
    if not isinstance(data['price'], (int, float)) or data['price'] < 0:
        logger.warning('Invalid price value.')
        abort(400, 'Invalid price value')
    product = ProductService.create_product(data)
    logger.info(f'Product created: {product.id}')
    return jsonify(product.to_dict()), 201

@bp.route('/products/<int:id>', methods=['PUT'])
def update_product(id):
    """Update an existing product."""
    product = Product.query.get_or_404(id)
    data = request.get_json()
    if not data:
        logger.warning('No data provided for update.')
        abort(400, 'No data provided')
    if 'price' in data and (not isinstance(data['price'], (int, float)) or data['price'] < 0):
        logger.warning('Invalid price value in update.')
        abort(400, 'Invalid price value')
    product = ProductService.update_product(product, data)
    logger.info(f'Product updated: {product.id}')
    return jsonify(product.to_dict())

@bp.route('/products/<int:id>', methods=['DELETE'])
def delete_product(id):
    """Delete a product by ID."""
    product = Product.query.get_or_404(id)
    ProductService.delete_product(product)
    logger.info(f'Product deleted: {id}')
    return '', 204 