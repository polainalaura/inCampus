const express = require("express");
const router = express.Router();

router.get("/", (req, res) => {
res.json({ message: "Lista de eventos" });
});

module.exports = router;

/*const express = require("express");
const router = express.Router();

router.get("/", (req, res) => {
res.json({ message: "Lista de eventos" });
});

module.exports = router;*/