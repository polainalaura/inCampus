const subjectModel = require("../models/Subject");

const getSubjects = (req, res) => {
  subjectModel.obtenerSubjects((err, results) => {
    if (err) {
      console.error("ERROR EN CONTROLLER:", err);
      return res.status(500).json({ error: err.message });
    }

    res.json(results);
  });
};

module.exports = { getSubjects };