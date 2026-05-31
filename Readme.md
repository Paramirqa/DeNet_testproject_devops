

# Task Management API

## Описание проекта

Данный проект представляет собой REST API для управления задачами, разработанное на базе FastAPI.

В рамках тестового задания была выполнена контейнеризация приложения, настройка CI/CD процесса и централизованный сбор логов.

### Используемый стек

- Python 3.13
- FastAPI
- PostgreSQL
- Redis
- Docker
- Docker Compose
- GitHub Actions (CI/CD)
- Grafana
- Loki
- Alloy

---

## Архитектура решения

Проект состоит из следующих сервисов:

| Сервис | Назначение |
|----------|----------|
| app | FastAPI приложение |
| postgres | База данных PostgreSQL |
| redis | Кэширование и хранение временных данных |
| loki | Хранилище логов |
| alloy | Сбор логов из Docker контейнеров |
| grafana | Визуализация логов |

---

## Особенности реализации

### Docker

Для приложения используется multi-stage Docker build:

- уменьшен размер итогового образа;
- исключены build-зависимости из production образа;
- ускорена передача образов между окружениями.

Приложение запускается от отдельного non-root пользователя, что повышает безопасность контейнера.

---

## CI/CD

Для автоматизации используется GitHub Actions.

Pipeline выполняет следующие этапы:

1. Установка зависимостей.
2. Запуск тестов.
3. Сборка Docker-образа.
4. Публикация образа в Docker Registry.
5. Деплой приложения (при необходимости).

Pipeline запускается автоматически после push в репозиторий.

Выполнял CI/CD в github Actions.
Также есть файл .gitlab-ci.yml с примером конфигурации для Gitlab CI/CD.

---

## Сбор логов

Для централизованного сбора логов используется стек:

- Grafana Alloy
- Loki
- Grafana

Alloy собирает логи Docker контейнеров и отправляет их в Loki.

Grafana используется для просмотра и анализа логов.

---

## Сборка Docker-образа

```bash
docker build -t task-api:test .
```

Проверка образа:

```bash
docker images
```

---

## Запуск проекта

```bash
docker compose up --build -d
```

Проверка контейнеров:

```bash
docker ps
```

После запуска должны работать контейнеры:

- app
- postgres
- redis
- loki
- alloy
- grafana

---

## Проверка приложения

Swagger UI:

```text
http://localhost:8000/docs
```

---

## Проверка PostgreSQL

```bash
docker exec -it postgres psql -U tasks_user -d tasks
```

---

## Проверка Redis

```bash
docker exec -it redis redis-cli
PING
```

Ожидаемый ответ:

```text
PONG
```

---

## Проверка Grafana

```text
http://localhost:3000
```

Логин:

```text
admin
admin
```

---

## Просмотр логов

В Grafana открыть:

```text
Explore → Loki
```

Выполнить запрос:

```text
{}
```

---

## Безопасность

В проекте реализованы следующие практики:

- запуск контейнера от non-root пользователя;
- использование slim образов;
- хранение секретов в GitHub Secrets;
- исключение лишних файлов через .dockerignore;
- разделение build и runtime окружений через multi-stage build.
