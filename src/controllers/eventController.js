exports.getEvents = (req, res) => {
    res.json({ message: "Lista de eventos" });
  };
  
  exports.getEventById = (req, res) => {
    res.json({ message: `Evento con id ${req.params.id}` });
  };
  
  exports.createEvent = (req, res) => {
    res.json({ message: "Evento creado" });
  };
  
  exports.updateEvent = (req, res) => {
    res.json({ message: `Evento actualizado ${req.params.id}` });
  };
  
  exports.deleteEvent = (req, res) => {
    res.json({ message: `Evento eliminado ${req.params.id}` });
  };