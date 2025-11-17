// swagger.js

const swaggerDocument = {
  openapi: "3.0.0",
  info: {
    title: "Cosmetics Store API",
    version: "1.0.0",
    description: "Backend для интернет-магазина косметики",
  },
  servers: [
    {
      url: "http://localhost:3000", // если порт другой — поменяй
      description: "Local server",
    },
  ],
  components: {
    schemas: {
      // То, что возвращает сервер
      Product: {
        type: "object",
        properties: {
          _id: { type: "string", readOnly: true },
          name: { type: "string", example: "Сыворотка для лица" },
          price: { type: "number", example: 1990 },
          description: {
            type: "string",
            example: "Увлажняющая сыворотка для жирной кожи",
          },
          images: {
            type: "array",
            items: { type: "string" },
            example: ["https://example.com/image1.jpg"],
          },
          type: {
            type: "string",
            example: "serum",
            description:
              "serum | toner | cream | mask | gel | foam | oil | lotion | scrub | essence",
          },
          inStock: { type: "boolean", example: true },
          skinTypes: {
            type: "array",
            items: { type: "string" },
            example: ["oily"],
            description: "oily | combination | normal | dry | any",
          },
          purposes: {
            type: "array",
            items: { type: "string" },
            example: ["hydration"],
            description: "cleansing | hydration | regeneration",
          },
          line: {
            type: "string",
            nullable: true,
            example: "unstress",
          },
          isSet: { type: "boolean", example: false },
          isOnSale: { type: "boolean", example: false },
          rating: { type: "number", nullable: true, example: 4.5 },
          reviewCount: { type: "number", example: 10 },
          discount: { type: "number", nullable: true, example: 10 },
          discountText: {
            type: "string",
            nullable: true,
            example: "Скидка 10%",
          },
          characteristics: {
            type: "object",
            example: { volume: "30 мл", brand: "TestBrand" },
          },
          createdAt: { type: "string", readOnly: true },
          updatedAt: { type: "string", readOnly: true },
        },
      },

      // То, что ты ВВОДИШЬ при создании/обновлении товара
      ProductInput: {
        type: "object",
        required: ["name", "price", "type"],
        properties: {
          name: { type: "string", example: "Сыворотка для лица" },
          price: { type: "number", example: 1990 },
          description: {
            type: "string",
            example: "Увлажняющая сыворотка для жирной кожи",
          },
          images: {
            type: "array",
            items: { type: "string" },
            example: ["https://example.com/image1.jpg"],
          },
          type: {
            type: "string",
            example: "serum",
          },
          inStock: { type: "boolean", example: true },
          skinTypes: {
            type: "array",
            items: { type: "string" },
            example: ["oily"],
          },
          purposes: {
            type: "array",
            items: { type: "string" },
            example: ["hydration"],
          },
          line: {
            type: "string",
            nullable: true,
            example: "unstress",
          },
          isSet: { type: "boolean", example: false },
          isOnSale: { type: "boolean", example: false },
          rating: { type: "number", nullable: true, example: 4.5 },
          reviewCount: { type: "number", example: 10 },
          discount: { type: "number", nullable: true, example: 10 },
          discountText: {
            type: "string",
            nullable: true,
            example: "Скидка 10%",
          },
          characteristics: {
            type: "object",
            example: { volume: "30 мл", brand: "TestBrand" },
          },
        },
      },

      ProductsPage: {
        type: "object",
        properties: {
          total: { type: "number", example: 1 },
          page: { type: "number", example: 1 },
          limit: { type: "number", example: 20 },
          items: {
            type: "array",
            items: { $ref: "#/components/schemas/Product" },
          },
        },
      },

      MenuItem: {
        type: "object",
        properties: {
          id: { type: "string", example: "skinType" },
          title: { type: "string", example: "Тип кожи" },
          filterKey: { type: "string", example: "skinType" },
          type: { type: "string", enum: ["list", "boolean"], example: "list" },
        },
      },

      FilterOption: {
        type: "object",
        properties: {
          value: { type: "string", example: "oily" },
          label: { type: "string", example: "Жирная" },
        },
      },

      FilterConfig: {
        type: "object",
        properties: {
          key: { type: "string", example: "skinType" },
          title: { type: "string", example: "Тип кожи" },
          queryParam: { type: "string", example: "skinType" },
          options: {
            type: "array",
            items: { $ref: "#/components/schemas/FilterOption" },
          },
        },
      },
    },
  },

  paths: {
    // ===== ТОВАРЫ =====
    "/api/products": {
      get: {
        summary: "Список товаров с фильтрацией и пагинацией",
        tags: ["Products"],
        parameters: [
          {
            name: "skinType",
            in: "query",
            schema: { type: "string" },
            description: "Тип кожи (oily, combination, normal, dry, any)",
          },
          {
            name: "purpose",
            in: "query",
            schema: { type: "string" },
            description: "Назначение (cleansing, hydration, regeneration)",
          },
          {
            name: "type",
            in: "query",
            schema: { type: "string" },
            description: "Тип средства (serum, toner, cream, ...)",
          },
          {
            name: "line",
            in: "query",
            schema: { type: "string" },
            description: "Линия косметики (unstress, ...)",
          },
          {
            name: "isSet",
            in: "query",
            schema: { type: "string", enum: ["true", "false"] },
          },
          {
            name: "onSale",
            in: "query",
            schema: { type: "string", enum: ["true"] },
          },
          {
            name: "minPrice",
            in: "query",
            schema: { type: "number" },
          },
          {
            name: "maxPrice",
            in: "query",
            schema: { type: "number" },
          },
          {
            name: "search",
            in: "query",
            schema: { type: "string" },
            description: "Поиск по имени и описанию",
          },
          {
            name: "page",
            in: "query",
            schema: { type: "number" },
            description: "Номер страницы (по умолчанию 1)",
          },
          {
            name: "limit",
            in: "query",
            schema: { type: "number" },
            description: "Размер страницы (по умолчанию 20)",
          },
        ],
        responses: {
          200: {
            description: "Список товаров (с пагинацией)",
            content: {
              "application/json": {
                schema: { $ref: "#/components/schemas/ProductsPage" },
              },
            },
          },
        },
      },

      post: {
        summary: "Создать товар",
        tags: ["Products"],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/ProductInput" },
            },
          },
        },
        responses: {
          201: {
            description: "Созданный товар",
            content: {
              "application/json": {
                schema: { $ref: "#/components/schemas/Product" },
              },
            },
          },
          400: { description: "Ошибка валидации" },
        },
      },
    },

    // ✅ НОВЫЙ маршрут: все товары + total, без пагинации
    "/api/products/all": {
      get: {
        summary: "Получить все товары без пагинации",
        tags: ["Products"],
        responses: {
          200: {
            description: "Все товары и их общее количество",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    total: {
                      type: "number",
                      example: 42,
                      description: "Общее количество товаров",
                    },
                    items: {
                      type: "array",
                      items: { $ref: "#/components/schemas/Product" },
                    },
                  },
                },
              },
            },
          },
          500: { description: "Ошибка сервера" },
        },
      },
    },

    "/api/products/{id}": {
      get: {
        summary: "Получить товар по ID",
        tags: ["Products"],
        parameters: [
          {
            name: "id",
            in: "path",
            required: true,
            schema: { type: "string" },
          },
        ],
        responses: {
          200: {
            description: "Товар найден",
            content: {
              "application/json": {
                schema: { $ref: "#/components/schemas/Product" },
              },
            },
          },
          400: { description: "Некорректный ID" },
          404: { description: "Товар не найден" },
        },
      },

      put: {
        summary: "Обновить товар",
        tags: ["Products"],
        parameters: [
          {
            name: "id",
            in: "path",
            required: true,
            schema: { type: "string" },
          },
        ],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/ProductInput" },
            },
          },
        },
        responses: {
          200: {
            description: "Обновлённый товар",
            content: {
              "application/json": {
                schema: { $ref: "#/components/schemas/Product" },
              },
            },
          },
          400: { description: "Ошибка валидации / некорректный ID" },
          404: { description: "Товар не найден" },
        },
      },

      delete: {
        summary: "Удалить товар",
        tags: ["Products"],
        parameters: [
          {
            name: "id",
            in: "path",
            required: true,
            schema: { type: "string" },
          },
        ],
        responses: {
          200: { description: "Товар успешно удалён" },
          400: { description: "Некорректный ID" },
          404: { description: "Товар не найден" },
        },
      },
    },

    // ===== ФИЛЬТРЫ =====
    "/filters": {
      get: {
        summary: "Получить меню и все фильтры",
        tags: ["Filters"],
        responses: {
          200: {
            description: "Меню каталога и конфиги фильтров",
            content: {
              "application/json": {
                schema: {
                  type: "object",
                  properties: {
                    menu: {
                      type: "array",
                      items: { $ref: "#/components/schemas/MenuItem" },
                    },
                    filters: {
                      type: "object",
                    },
                  },
                },
              },
            },
          },
        },
      },
    },

    "/filters/menu": {
      get: {
        summary: "Получить только меню каталога",
        tags: ["Filters"],
        responses: {
          200: {
            description: "Список пунктов меню",
            content: {
              "application/json": {
                schema: {
                  type: "array",
                  items: { $ref: "#/components/schemas/MenuItem" },
                },
              },
            },
          },
        },
      },
    },

    "/filters/{key}": {
      get: {
        summary: "Получить конфиг конкретного фильтра",
        tags: ["Filters"],
        parameters: [
          {
            name: "key",
            in: "path",
            required: true,
            schema: { type: "string" },
            description: "skinType | purpose | productType | line",
          },
        ],
        responses: {
          200: {
            description: "Конфиг фильтра",
            content: {
              "application/json": {
                schema: { $ref: "#/components/schemas/FilterConfig" },
              },
            },
          },
          404: { description: "Фильтр не найден" },
        },
      },
    },
  },
};

module.exports = swaggerDocument;
