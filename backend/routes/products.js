const express = require("express");
const router = express.Router();
const Product = require("../models/Product");

router.get("/", async (req, res) => {
  try {
    const {
      skinType,
      purpose,
      type,
      line,
      isSet,
      onSale,
      minPrice,
      maxPrice,
      search,
      page = 1,
      limit = 20,
    } = req.query;

    const filter = {};

    if (skinType) {
      filter.skinTypes = skinType;
    }

    if (purpose) {
      filter.purposes = purpose;
    }

    if (type) {
      filter.type = type;
    }

    if (line) {
      filter.line = line;
    }

    if (isSet === "true") {
      filter.isSet = true;
    } else if (isSet === "false") {
      filter.isSet = false;
    }

    if (onSale === "true") {
      filter.isOnSale = true;
    }

    if (minPrice || maxPrice) {
      filter.price = {};
      if (minPrice) {
        filter.price.$gte = Number(minPrice); 
      }
      if (maxPrice) {
        filter.price.$lte = Number(maxPrice);
      }
    }

    if (search) {
      const regex = new RegExp(search, "i");
      filter.$or = [{ name: regex }, { description: regex }];
    }

    const pageNum = Number(page) || 1;
    const limitNum = Number(limit) || 20;
    const skip = (pageNum - 1) * limitNum;

    const total = await Product.countDocuments(filter);

    const products = await Product.find(filter).skip(skip).limit(limitNum);
    res.json({
      total,
      page: pageNum,
      limit: limitNum,
      items: products, 
    });
  } catch (err) {
    console.error("GET /products error:", err.message);
    res.status(500).json({ message: "Ошибка сервера" });
  }
});
router.get("/", async (req, res) => {
  try {
    console.log("Привет");
    const products = await Product.find();
    res.json(products);
  } catch (err) {
    console.error("GET /products error:", err.message);
    res.status(500).json({ message: "Ошибка сервера" });
  }
});

router.post("/", async (req, res) => {
  try {
    const {
      name,
      price,
      description,
      type, 
      images,
      inStock,
      skinTypes,
      purposes,
      line,
      isSet,
      isOnSale,
      characteristics,
      rating,
      reviewCount,
      discount,
      discountText,
    } = req.body;

    
    if (!name || type == null || price == null) {
      return res.status(400).json({
        message: "Поля name, price и type обязательны",
      });
    }

    const newProduct = await Product.create({
      name,
      price,
      description,
      type,
      images,
      inStock,
      skinTypes,
      purposes,
      line,
      isSet,
      isOnSale,
      characteristics,
      rating,
      reviewCount,
      discount,
      discountText,
    });

    res.status(201).json(newProduct);
  } catch (err) {
    if (err.name === "ValidationError") {
      return res.status(400).json({
        message: "Ошибка валидации",
        details: err.errors,
      });
    }
    console.error("POST /products error:", err.message);
    res.status(500).json({ message: "Ошибка сервера при создании товара" });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const {
      name,
      price,
      description,
      type, 
      images,
      inStock,
      skinTypes, 
      purposes,
      line,
      isSet,
      isOnSale,
      characteristics,
      rating,
      reviewCount,
      discount,
      discountText,
    } = req.body;

    const updated = await Product.findByIdAndUpdate(
      id,
      {
        name,
        price,
        description,
        type,
        images,
        inStock,
        skinTypes,
        purposes,
        line,
        isSet,
        isOnSale,
        characteristics,
        rating,
        reviewCount,
        discount,
        discountText,
      },
      {
        new: true, 
        runValidators: true, 
      }
    );

    if (!updated) {
      return res.status(404).json({ message: "Товар не найден" });
    }

    res.json(updated);
  } catch (err) {
    if (err.name === "CastError") {
      return res.status(400).json({ message: "Некорректный ID товара" });
    }
    if (err.name === "ValidationError") {
      return res
        .status(400)
        .json({ message: "Ошибка валидации", details: err.errors });
    }
    console.error("PUT /products/:id error:", err.message);
    res.status(500).json({ message: "Ошибка сервера при обновлении товара" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await Product.findByIdAndDelete(id);
    if (!deleted) {
      return res.status(404).json({ message: "Товар не найден" });
    }
    res.json({ message: "Товар успешно удалён" });
  } catch (err) {
    if (err.name === "CastError") {
      return res.status(400).json({ message: "Некорректный ID товара" });
    }
    console.error("DELETE /products/:id error:", err.message);
    res.status(500).json({ message: "Ошибка сервера при удалении товара" });
  }
});

module.exports = router;
