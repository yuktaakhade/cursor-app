from flask import Blueprint, request, jsonify, abort
from models import db, Product
from services import ProductService

bp = Blueprint('products', __name__)

@bp.route('/products', methods=['GET'])
def get_products():
    products = ProductService.get_all_products()
    return jsonify([p.to_dict() for p in products])

@bp.route('/products', methods=['POST'])
def create_product():
    data = request.get_json()
    if not data or 'name' not in data or 'price' not in data:
        abort(400, 'Missing required fields')
    product = ProductService.create_product(data)
    return jsonify(product.to_dict()), 201

@bp.route('/products/<int:id>', methods=['PUT'])
def update_product(id):
    product = Product.query.get_or_404(id)
    data = request.get_json()
    if not data:
        abort(400, 'No data provided')
    product = ProductService.update_product(product, data)
    return jsonify(product.to_dict())

@bp.route('/products/<int:id>', methods=['DELETE'])
def delete_product(id):
    product = Product.query.get_or_404(id)
    ProductService.delete_product(product)
    return '', 204 