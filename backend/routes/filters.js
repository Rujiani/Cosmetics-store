// routes/filters.js
const express = require("express");
const router = express.Router();
const { FILTERS, MENU } = require("../config/filters");

router.get("/", (req, res) => {
  res.json({
    menu: MENU,
    filters: FILTERS,
  });
});

router.get("/menu", (req, res) => {
  res.json(MENU);
});

router.get("/:key", (req, res) => {
  const { key } = req.params;
  const config = FILTERS[key];

  if (!config) {
    return res.status(404).json({ message: "Фильтр не найден" });
  }

  res.json(config);
});

module.exports = router;
