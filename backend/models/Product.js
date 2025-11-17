// models/Product.js
const mongoose = require("mongoose");
const {
  PRODUCT_TYPES,
  SKIN_TYPES,
  PURPOSES,
  LINES,
} = require("../config/constants");

const productSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },

    price: {
      type: Number,
      required: true,
      min: 0,
    },

    description: {
      type: String,
      default: "",
    },

    images: {
      type: [String],
      default: [],
    },

    type: {
      type: String,
      required: true,
      trim: true,
      enum: PRODUCT_TYPES,
    },

    inStock: {
      type: Boolean,
      default: true,
    },

    skinTypes: {
      type: [String],
      enum: SKIN_TYPES,
      default: ["any"],
    },

    purposes: {
      type: [String],
      enum: PURPOSES,
      default: [],
    },

    line: {
      type: String,
      enum: LINES,
      default: null,
      trim: true,
    },

    isSet: {
      type: Boolean,
      default: false,
    },

    isOnSale: {
      type: Boolean,
      default: false,
    },

    rating: {
      type: Number,
      default: null,
      min: 0,
      max: 5,
    },

    reviewCount: {
      type: Number,
      default: 0,
      min: 0,
    },

    discount: {
      type: Number,
      default: null,
      min: 0,
      max: 100,
    },

    discountText: {
      type: String,
      default: null,
    },

    characteristics: {
      type: Object,
      default: {},
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Product", productSchema);
