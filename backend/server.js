const express = require("express");
const dotenv = require("dotenv");
const connectDB = require("./config/db");
const cors = require("cors");

dotenv.config(); // чтобы .env считался
connectDB(); // подключаем базу
const app = express();
// Swagger
const swaggerUi = require("swagger-ui-express");
const swaggerDocument = require("./swagger");

// до роутов:
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));
const productRotes = require("./routes/products");
const filterRotes = require("./routes/filters");

app.use(express.json());
app.use(cors());

app.use("/filters", filterRotes);
app.use("/api/products", productRotes);
app.get("/", (req, res) => {
  console.log("Привет  мир");
  res.send("Сервер работает, MongoDB подключена!");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("===================================");
  console.log(`🚀 Сервер запущен на порту ${PORT}`);
  console.log(`🌐 Открой в браузере: http://localhost:${PORT}/`);
  console.log("===================================");
});
