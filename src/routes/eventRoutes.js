const express = require("express");
const router = express.Router();
const eventController = require("../controllers/eventController");

router.get("/", eventController.getEvents);
router.get("/:id", eventController.getEventById);
router.post("/", eventController.createEvent);
router.put("/:id", eventController.updateEvent);
router.delete("/:id", eventController.deleteEvent);

module.exports = router;

/*const express = require("express");
const router = express.Router();

router.get("/", (req, res) => {
res.json({ message: "Lista de eventos" });
});

module.exports = router;*/