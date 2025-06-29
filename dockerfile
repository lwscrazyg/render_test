# syntax=docker/dockerfile:1          # Hace que Docker use la última sintaxis estable

# 1️⃣ Base ligera con Python 3.12
FROM python:3.12-slim AS base

# 2️⃣ Buenas prácticas
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3️⃣ Trabajaremos en /app
WORKDIR /app

# 4️⃣ Primero requirements (capas de cache más eficientes)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5️⃣ Copia el resto del código
COPY . .

# 6️⃣ Render expone la variable $PORT en tiempo de ejecución
ENV PORT=8000
EXPOSE 8000

# 7️⃣ Lanza Gunicorn, enlazado al puerto que Render te da
CMD ["gunicorn", "-b", "0.0.0.0:${PORT}", "app:app"]
