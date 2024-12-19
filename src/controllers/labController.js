import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

// 1. Controlador para trazabilidad de muestras
export const getTrazabilidadMuestra = async (req, res) => {
  try {
    const { idMuestra } = req.params;
    const result = await prisma.$queryRaw`
            SELECT * FROM obtener_trazabilidad_muestra(${parseInt(
              idMuestra
            )}::INTEGER)
        `;

    if (!result?.length) {
      return res.status(404).json({
        success: false,
        message: "No se encontró trazabilidad para esta muestra",
      });
    }

    res.json({
      success: true,
      data: result[0],
    });
  } catch (error) {
    console.error("Error en trazabilidad:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener la trazabilidad",
      error: error.message,
    });
  }
};

// 2. Controlador para análisis demorados
export const getAnalisisDemorados = async (req, res) => {
  try {
    const result = await prisma.$queryRaw`
            SELECT * FROM obtener_analisis_demorados()
        `;

    res.json({
      success: true,
      data: result,
    });
  } catch (error) {
    console.error("Error en análisis demorados:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener análisis demorados",
      error: error.message,
    });
  }
};

// 3. Controlador para análisis repetidos
export const getAnalisisRepetidos = async (req, res) => {
  try {
    const { fechaInicio, fechaFin } = req.query;

    if (!fechaInicio || !fechaFin) {
      return res.status(400).json({
        success: false,
        message: "Se requieren fechas de inicio y fin",
      });
    }

    const result = await prisma.$queryRaw`
        SELECT * FROM obtener_analisis_repetidos(${new Date(
          fechaInicio
        )}::DATE, ${new Date(fechaFin)}::DATE)
      `;

    // Convertir BigInt a Number en el resultado
    const serializedResult = result.map((row) => ({
      ...row,
      cantidad_analisis: Number(row.cantidad_analisis),
      costo_total: Number(row.costo_total),
    }));

    res.json({
      success: true,
      data: serializedResult,
    });
  } catch (error) {
    console.error("Error en análisis repetidos:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener análisis repetidos",
      error: error.message,
    });
  }
};

// 4. Controlador para equipos críticos
export const getEquiposCriticos = async (req, res) => {
  try {
    const { fechaInicio, fechaFin } = req.query;
    let result;

    if (fechaInicio && fechaFin) {
      result = await prisma.$queryRaw`
                  SELECT * FROM obtener_equipos_criticos(${fechaInicio}::DATE, ${fechaFin}::DATE)
              `;
    } else {
      result = await prisma.$queryRaw`
                  SELECT * FROM obtener_equipos_criticos()
              `;
    }

    // Convertir BigInt a string
    const formattedResult = result.map((row) =>
      Object.fromEntries(
        Object.entries(row).map(([key, value]) => [
          key,
          typeof value === "bigint" ? value.toString() : value,
        ])
      )
    );

    res.json({
      success: true,
      data: formattedResult,
    });
  } catch (error) {
    console.error("Error en equipos críticos:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener equipos críticos",
      error: error.message,
    });
  }
};

// 5. Controlador para mantenimiento preventivo
export const getMantenimientoPreventivo = async (req, res) => {
  try {
    const { diasRevision = 90 } = req.query;

    const result = await prisma.$queryRaw`
          SELECT * FROM obtener_equipos_mantenimiento_preventivo(${parseInt(
            diasRevision
          )}::INTEGER)
        `;

    // Convertir BigInt a número o cadena
    const formattedResult = result.map((row) => ({
      ...row,
      total_analisis_realizados: Number(row.total_analisis_realizados),
      analisis_desde_mantenimiento: Number(row.analisis_desde_mantenimiento),
    }));

    res.json({
      success: true,
      data: formattedResult,
    });
  } catch (error) {
    console.error("Error en mantenimiento preventivo:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener datos de mantenimiento preventivo",
      error: error.message,
    });
  }
};

// 6. Controlador para análisis por método de pago
export const getAnalisisPorMetodoPago = async (req, res) => {
  try {
    const { mes, anio } = req.query;

    // Validar que los parámetros mes y año sean proporcionados
    if (!mes || !anio) {
      return res.status(400).json({
        success: false,
        message: "Se requieren mes y año",
      });
    }

    const result = await prisma.$queryRaw`
          SELECT * FROM obtener_analisis_por_metodo_pago(
            ${parseInt(mes)}::INTEGER, 
            ${parseInt(anio)}::INTEGER
          )
        `;

    // Convertir BigInt a número o cadena
    const formattedResult = result.map((row) => ({
      ...row,
      cantidad_analisis: Number(row.cantidad_analisis),
      total_ingresos: Number(row.total_ingresos),
      porcentaje_total: Number(row.porcentaje_total),
    }));

    res.json({
      success: true,
      data: formattedResult,
    });
  } catch (error) {
    console.error("Error en análisis por método de pago:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener análisis por método de pago",
      error: error.message,
    });
  }
};

// 7. Controlador para reactivos críticos
export const getReactivosCriticos = async (req, res) => {
  try {
    const { stockMinimo = 10 } = req.query;

    const result = await prisma.$queryRaw`
            SELECT * FROM obtener_reactivos_criticos(${parseInt(stockMinimo)})
        `;

    res.json({
      success: true,
      data: result,
    });
  } catch (error) {
    console.error("Error en reactivos críticos:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener reactivos críticos",
      error: error.message,
    });
  }
};

// 8. Controlador para análisis retrasados prioritarios
export const getAnalisisRetrasadosPrioritarios = async (req, res) => {
  try {
    const result = await prisma.$queryRaw`
            SELECT * FROM obtener_analisis_retrasados_prioritarios()
        `;

    res.json({
      success: true,
      data: result,
    });
  } catch (error) {
    console.error("Error en análisis retrasados prioritarios:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener análisis retrasados prioritarios",
      error: error.message,
    });
  }
};

// 9. Controlador para costos por proveedor
export const getCostosProveedor = async (req, res) => {
  try {
    const { anio = new Date().getFullYear() } = req.query;

    const result = await prisma.$queryRaw`
            SELECT * FROM obtener_costos_proveedor(${parseInt(anio)})
        `;

    res.json({
      success: true,
      data: result,
    });
  } catch (error) {
    console.error("Error en costos por proveedor:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener costos por proveedor",
      error: error.message,
    });
  }
};

// 10. Controlador para tiempos de respuesta
export const getTiemposRespuesta = async (req, res) => {
  try {
    const { anio = new Date().getFullYear() } = req.query;

    const result = await prisma.$queryRaw`
            SELECT * FROM obtener_tiempos_respuesta(${parseInt(anio)})
        `;

    res.json({
      success: true,
      data: result,
    });
  } catch (error) {
    console.error("Error en tiempos de respuesta:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener tiempos de respuesta",
      error: error.message,
    });
  }
};
