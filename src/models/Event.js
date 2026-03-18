/* Con un model:
defines los campos
defines el tipo de datos
defines reglas (validaciones)
conectas con la base de datos*/

const mongoose = require("mongoose");

const eventSchema = new mongoose.Schema(
{
    title: {
    type: String,
    required: true,
    },
    description: {
    type: String,
    },
    date: {
    type: Date,
    required: true,
    },
    location: {
    type: String,
    },
},
{
    timestamps: true,
}
);

module.exports = mongoose.model("Event", eventSchema);