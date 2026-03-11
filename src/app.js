const express = require("express");
const eventRoutes = require("./routes/eventRoutes");
const subjectRoutes = require("./routes/subjectRoutes");

const app = express();
const PORT = 3000;

app.use(express.json());

app.get("/", (req, res) => {
  res.send("API inCampus funcionando");
});

app.use("/events", eventRoutes);
app.use("/subjects", subjectRoutes);

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});