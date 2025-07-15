# E-Shopping Python Backend

A simple Flask-based backend for an e-shopping system with CRUD operations for products.

## Features
- CRUD for products (in-memory/SQLite)
- REST API: GET/POST/PUT/DELETE /products
- Unit tests with unittest
- Test coverage with coverage.py
- Linting with flake8
- Build automation with PyBuilder

## Setup

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Run the app:**
   ```bash
   python app.py
   ```

3. **Run tests:**
   ```bash
   python -m unittest test_app.py
   ```

4. **Check coverage:**
   ```bash
   coverage run --source=. -m unittest test_app.py
   coverage report -m
   ```

5. **Lint the code:**
   ```bash
   flake8 .
   ```

6. **Build automation (PyBuilder):**
   ```bash
   pyb clean install
   ``` 