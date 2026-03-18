const db = require("../config/db");

const getUsuarios = (req, res) => {
  const sql = "SELECT * FROM usuario";

  db.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: "Error en la consulta" });
    }

    res.json(results);
  });
};

module.exports = { getUsuarios };