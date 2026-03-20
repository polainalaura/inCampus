const db = require("../config/db");

// Obtener todos los usuarios
const obtenerUsuarios = () => {
  return new Promise((resolve, reject) => {
    const sql = "SELECT * FROM usuario";

    db.query(sql, (err, results) => {
      if (err) return reject(err);
      resolve(results);
    });
  });
};

// Buscar usuario por email
const obtenerUsuarioPorEmail = (email) => {
  return new Promise((resolve, reject) => {
    const sql = "SELECT * FROM usuario WHERE email = ?";

    db.query(sql, [email], (err, results) => {
      if (err) return reject(err);
      resolve(results[0]);
    });
  });
};

// Crear usuario
const crearUsuario = (email, password_hash) => {
  return new Promise((resolve, reject) => {
    const sql = "INSERT INTO usuario (email, password_hash) VALUES (?, ?)";

    db.query(sql, [email, password_hash], (err, result) => {
      if (err) return reject(err);

      resolve({
        id: result.insertId,
        email,
      });
    });
  });
};

module.exports = {
  obtenerUsuarios,
  obtenerUsuarioPorEmail,
  crearUsuario,
};