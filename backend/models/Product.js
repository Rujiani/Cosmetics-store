const mongoose = require("mongoose");

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
  enum: [
    "serum",
    "toner",
    "cream",
    "mask",
    "gel",
    "foam",
    "oil",
    "lotion",
    "scrub",
    "essence"
  ],
},

    inStock: {
      type: Boolean,
      default: true,
    },

   
    skinTypes: {
      type: [String],
      enum: ["oily", "combination", "normal", "dry", "any"],
      default: ["any"], 
    },

    
    purposes: {
      type: [String],
      enum: ["cleansing", "hydration", "regeneration"],
      default: [],
    },

    
    line: {
      type: String,
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
