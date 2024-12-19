// src/routes/labRoutes.js
import { Router } from "express";
import {
  getTrazabilidadMuestra,
  getAnalisisDemorados,
  getAnalisisRepetidos,
  getEquiposCriticos,
  getMantenimientoPreventivo,
  getAnalisisPorMetodoPago,
  getReactivosCriticos,
  getAnalisisRetrasadosPrioritarios,
  getCostosProveedor,
  getTiemposRespuesta,
} from "../controllers/labController.js";

const router = Router();

// Rutas
router.get("/trazabilidad/:idMuestra", getTrazabilidadMuestra);
router.get("/analisis-demorados", getAnalisisDemorados);
router.get("/analisis-repetidos", getAnalisisRepetidos);
router.get("/equipos-criticos", getEquiposCriticos);
router.get("/mantenimiento-preventivo", getMantenimientoPreventivo);
router.get("/analisis-por-pago", getAnalisisPorMetodoPago);
router.get("/reactivos-criticos", getReactivosCriticos);
router.get("/analisis-retrasados", getAnalisisRetrasadosPrioritarios);
router.get("/costos-proveedor", getCostosProveedor);
router.get("/tiempos-respuesta", getTiemposRespuesta);

export default router;
