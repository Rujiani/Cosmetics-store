const mongoose = require('mongoose');
require('dotenv').config();

const connectDB = async () => {
  try {
    // просто подключаемся — Mongoose сам ставит нужные опции по умолчанию
    const conn = await mongoose.connect(process.env.MONGO_URI);

    console.log(`✅ MongoDB подключена: ${conn.connection.host}`);
  } catch (error) {
    console.error('❌ Ошибка подключения к MongoDB:', error.message);
    process.exit(1);
  }
};

module.exports = connectDB;
