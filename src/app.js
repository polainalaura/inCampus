const express = require("express");

const eventRoutes = require("./routes/eventRoutes");
const subjectRoutes = require("./routes/subjectRoutes");
const userRoutes = require("./routes/userRoutes"); // 👈 añadimos esto

const db = require("./config/db"); // 👈 conexión MySQL

const app = express();
const PORT = 3000;

app.use(express.json());

app.get("/", (req, res) => {
  res.send("API inCampus funcionando");
});

// rutas que ya tenías
app.use("/events", eventRoutes);
app.use("/subjects", subjectRoutes);

// ruta nueva para probar MySQL
app.use("/usuarios", userRoutes);

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});