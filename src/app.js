import express from "express";
import cors from "cors";
import labRoutes from "./routes/labRoutes.js";

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/api/lab", labRoutes);

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: "Error interno del servidor",
    error: err.message,
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT}`);
});

export default app;
