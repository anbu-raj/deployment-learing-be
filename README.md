# Backend (FastAPI + PostgreSQL)

Simple CRUD API for a `Product` resource. Schema is managed with Alembic migrations.

## 1. Create the database

Using your local Postgres install (psql, pgAdmin, etc.), create a database:

```sql
CREATE DATABASE deployment_learning;
```

Adjust the connection details below if your Postgres user/password/host differ from the defaults.

## 2. Configure environment

```
cp .env.example .env
```

Edit `.env` if needed:

```
DATABASE_URL=postgresql://postgres@127.0.0.1:5432/deployment_learning
CORS_ORIGINS=http://localhost:4200
ENVIRONMENT=development
```

## 3. Install dependencies

```
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

## 4. Apply migrations

```
alembic upgrade head
```

## 5. Run the API

```
uvicorn app.main:app --reload --port 8000
```

API docs: http://localhost:8000/docs (disabled when `ENVIRONMENT=production`)

## Changing the schema

```
# edit app/models.py, then:
alembic revision --autogenerate -m "describe the change"
alembic upgrade head
```

## Endpoints

| Method | Path                    | Description       |
|--------|-------------------------|--------------------|
| GET    | /api/products           | List products      |
| GET    | /api/products/{id}      | Get one product    |
| POST   | /api/products           | Create a product   |
| PUT    | /api/products/{id}      | Update a product   |
| DELETE | /api/products/{id}      | Delete a product   |
