// config/filters.js
const { PRODUCT_TYPES, SKIN_TYPES, PURPOSES, LINES } = require("./constants");


const FILTERS = {
  skinType: {
    key: "skinType",
    title: "Тип кожи",
    queryParam: "skinType", // /products?skinType=oily
    options: SKIN_TYPES.map((value) => ({
      value,
      label: {
        oily: "Жирная",
        combination: "Комбинированная",
        normal: "Нормальная",
        dry: "Сухая",
        any: "Любой тип",
      }[value],
    })),
  },

  purpose: {
    key: "purpose",
    title: "Назначение",
    queryParam: "purpose", // /products?purpose=hydration
    options: PURPOSES.map((value) => ({
      value,
      label: {
        cleansing: "Очищение",
        hydration: "Увлажнение",
        regeneration: "Регенерация",
      }[value],
    })),
  },

  productType: {
    key: "productType",
    title: "Тип средства",
    queryParam: "type", // /products?type=serum
    options: PRODUCT_TYPES.map((value) => ({
      value,
      label: {
        serum: "Сыворотка",
        toner: "Тоник",
        cream: "Крем",
        mask: "Маска",
        gel: "Гель",
        foam: "Пенка",
        oil: "Масло",
        lotion: "Лосьон",
        scrub: "Скраб",
        essence: "Эссенция",
      }[value],
    })),
  },

  line: {
    key: "line",
    title: "Линия косметики",
    queryParam: "line", // /products?line=unstress
    options: LINES.map((value) => ({
      value,
      label: {
        unstress: "Unstress",
        illuminating: "Illuminating",
        purebalance: "Pure Balance",
        royal: "Royal",
        energizing: "Energizing",
      }[value] || value,
    })),
  },
};

const MENU = [
  {
    id: "purpose",
    title: "Назначение",
    filterKey: "purpose", 
    type: "list",
  },
  {
    id: "productType",
    title: "Тип средства",
    filterKey: "productType",
    type: "list",
  },
  {
    id: "skinType",
    title: "Тип кожи",
    filterKey: "skinType",
    type: "list",
  },
  {
    id: "line",
    title: "Линия косметики",
    filterKey: "line",
    type: "list",
  },
  {
    id: "sets",
    title: "Наборы",
    filterKey: "isSet", // ?isSet=true
    type: "boolean",
  },
  {
    id: "sale",
    title: "Акции",
    filterKey: "onSale", // ?onSale=true
    type: "boolean",
  },

];

module.exports = { FILTERS, MENU };
