const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const Usuario = require("../models/User");

// =======================
// REGISTER
// =======================
const register = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        message: "Email y contraseña son obligatorios",
      });
    }

    const usuarioExistente = await Usuario.obtenerUsuarioPorEmail(email);

    if (usuarioExistente) {
      return res.status(400).json({
        message: "El usuario ya existe",
      });
    }

    const password_hash = await bcrypt.hash(password, 10);

    const nuevoUsuario = await Usuario.crearUsuario(email, password_hash);

    res.status(201).json({
      message: "Usuario registrado correctamente",
      usuario: nuevoUsuario,
    });
  } catch (error) {
    next(error);
  }
};

// =======================
// LOGIN
// =======================
const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    const usuario = await Usuario.obtenerUsuarioPorEmail(email);

    if (!usuario) {
      return res.status(401).json({
        message: "Credenciales inválidas",
      });
    }

    const passwordValida = await bcrypt.compare(
      password,
      usuario.password_hash
    );

    if (!passwordValida) {
      return res.status(401).json({
        message: "Credenciales inválidas",
      });
    }

    const token = jwt.sign(
      {
        id: usuario.id,
        email: usuario.email,
      },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    res.json({
      message: "Login correcto",
      token,
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  register,
  login,
};
module.exports = {
  register,
  login,
};
/*const authModel = require("../models/Auth");

const login = (req, res) => {
  const { email, password } = req.body || {};

  if (!email || !password) {
    return res.status(400).json({ error: "Email y password son obligatorios" });
  }

  authModel.buscarUsuarioPorEmail(email, (err, results) => {
    if (err) {
      console.error("ERROR LOGIN:", err);
      return res.status(500).json({ error: "Error en la consulta" });
    }

    if (results.length === 0) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    const usuario = results[0];

    if (usuario.password_hash !== password) {
      return res.status(401).json({ error: "Contraseña incorrecta" });
    }

    return res.json({
      message: "Login correcto",
      usuario,
    });
  });
};

module.exports = { login };*/