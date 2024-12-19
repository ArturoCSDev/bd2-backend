// prisma/seed.js
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function clean() {
  await prisma.comprobantePago.deleteMany();
  await prisma.analisisClinico.deleteMany();
  await prisma.resultados.deleteMany();
  await prisma.registroMantenimiento.deleteMany();
  await prisma.muestra.deleteMany();
  await prisma.tipoAnalisisClinico.deleteMany();
  await prisma.claseAnalisisClinico.deleteMany();
  await prisma.equipo.deleteMany();
  await prisma.modelo.deleteMany();
  await prisma.marca.deleteMany();
  await prisma.tipoEquipo.deleteMany();
  await prisma.estadoEquipo.deleteMany();
  await prisma.personalLaboratorio.deleteMany();
  await prisma.administrador.deleteMany();
  await prisma.rol.deleteMany();
  await prisma.paciente.deleteMany();
  await prisma.estadoMuestra.deleteMany();
  await prisma.tipoMuestra.deleteMany();
  await prisma.tipoPago.deleteMany();
  await prisma.estadoPago.deleteMany();
}

async function main() {
  try {
    await clean();

    // 1. Roles y Admin
    const rol = await prisma.rol.create({
      data: { nombre: "Administrador" },
    });

    const admin = await prisma.administrador.create({
      data: {
        nombre: "Juan",
        apellidoPaterno: "Pérez",
        apellidoMaterno: "García",
        correo: "juan.perez@lab.com",
        contraseña: "123456",
        idRol: rol.id,
        fechaCreacion: new Date(),
      },
    });

    // 2. Personal
    const personal = await prisma.personalLaboratorio.create({
      data: {
        nombre: "Ana",
        apellido: "Martínez",
        apellidoMaterno: "López",
        dniPersonal: "12345678",
        especializacion: "Hematología",
        fechaContratacion: new Date(),
        idAdministrador: admin.id,
      },
    });

    // 3. Estados y Tipos
    const estadoMuestra = await prisma.estadoMuestra.create({
      data: { nombre: "En Proceso" },
    });

    const tipoMuestra = await prisma.tipoMuestra.create({
      data: { nombre: "Sangre" },
    });

    const estadoEquipo = await prisma.estadoEquipo.create({
      data: { descripcion: "Operativo" },
    });

    const claseAnalisis = await prisma.claseAnalisisClinico.create({
      data: { nombre: "Hematología" },
    });

    // 4. Equipamiento
    const marca = await prisma.marca.create({
      data: { nombre: "Medical Corp" },
    });

    const modelo = await prisma.modelo.create({
      data: { nombre: "X-2000" },
    });

    const tipoEquipo = await prisma.tipoEquipo.create({
      data: { descripcionTipoEquipo: "Analizador Hematológico" },
    });

    // 5. Equipos
    const equipo1 = await prisma.equipo.create({
      data: {
        idMarca: marca.id,
        idModelo: modelo.id,
        idTipoEquipo: tipoEquipo.id,
        idEstadoEquipo: estadoEquipo.id,
        numSerieEquipo: "SN001",
        fechaCompra: new Date("2024-01-01"),
      },
    });

    const equipo2 = await prisma.equipo.create({
      data: {
        idMarca: marca.id,
        idModelo: modelo.id,
        idTipoEquipo: tipoEquipo.id,
        idEstadoEquipo: estadoEquipo.id,
        numSerieEquipo: "SN002",
        fechaCompra: new Date("2023-01-01"),
      },
    });

    // 6. Mantenimientos
    await prisma.registroMantenimiento.createMany({
      data: [
        {
          idEquipo: equipo1.id,
          fechaMantenimiento: new Date("2024-01-10"),
          parametrosVerificados: "Calibración general",
          resultadoVerificacion: "Requiere ajustes",
        },
        {
          idEquipo: equipo1.id,
          fechaMantenimiento: new Date("2024-02-15"),
          parametrosVerificados: "Mantenimiento correctivo",
          resultadoVerificacion: "Reparación completada",
        },
        {
          idEquipo: equipo2.id,
          fechaMantenimiento: new Date("2023-10-01"),
          parametrosVerificados: "Mantenimiento preventivo",
          resultadoVerificacion: "Equipo en buen estado",
        },
      ],
    });

    // 7. Pacientes
    const paciente = await prisma.paciente.create({
      data: {
        dni: "87654321",
        nombre: "María",
        apellidoPaterno: "González",
        apellidoMaterno: "Ruiz",
        numeroTelefono: "999888777",
        edad: 30,
        direccion: "Av. Principal 123",
      },
    });

    // 8. Análisis Clínicos y Tipos
    const tipoAnalisis = await prisma.tipoAnalisisClinico.create({
      data: {
        nombreAnalisis: "Hemograma Completo",
        precio: 100.0,
        valorReferencia: "Valores normales",
        idClaseAnalisisClinico: claseAnalisis.id,
        idEquipo: equipo1.id,
      },
    });

    // 9. Muestras
    const fechaActual = new Date();
    const muestras = await prisma.muestra.createMany({
      data: [
        {
          dniPaciente: paciente.dni,
          fechaRecepcion: fechaActual,
          idEstadoMuestra: estadoMuestra.id,
          idTipoMuestra: tipoMuestra.id,
        },
        {
          dniPaciente: paciente.dni,
          fechaRecepcion: new Date(
            fechaActual.getTime() - 5 * 24 * 60 * 60 * 1000
          ),
          idEstadoMuestra: estadoMuestra.id,
          idTipoMuestra: tipoMuestra.id,
        },
        {
          dniPaciente: paciente.dni,
          fechaRecepcion: new Date("2024-01-15"),
          idEstadoMuestra: estadoMuestra.id,
          idTipoMuestra: tipoMuestra.id,
        },
        {
          dniPaciente: paciente.dni,
          fechaRecepcion: new Date("2024-02-15"),
          idEstadoMuestra: estadoMuestra.id,
          idTipoMuestra: tipoMuestra.id,
        },
      ],
    });

    // 10. Resultados
    const resultados = await prisma.resultados.create({
      data: {
        resultados: "Valores dentro del rango normal",
        reporte: "Informe completo",
        fechaEntrega: new Date(),
      },
    });

    // 11. Análisis Clínicos
    const todasLasMuestras = await prisma.muestra.findMany();

    for (let muestra of todasLasMuestras) {
      await prisma.analisisClinico.create({
        data: {
          idMuestra: muestra.id,
          idPersonal: personal.id,
          idTipoAnalisisClinico: tipoAnalisis.id,
          idResultadoAnalisis:
            muestra === todasLasMuestras[0] ? resultados.id : null,
        },
      });
    }

    // Dentro de la función main(), antes de los comprobantes de pago:

    // Crear muestras y resultados para diferentes meses
    const mesesMuestra = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    const tiemposRespuesta = [1, 2, 3, 5, 7]; // días de respuesta variados

    for (const mes of mesesMuestra) {
      // Crear 2-3 muestras por mes
      for (let i = 0; i < 3; i++) {
        const fechaRecepcion = new Date(2024, mes - 1, 15); // día 15 de cada mes

        const muestra = await prisma.muestra.create({
          data: {
            dniPaciente: paciente.dni,
            fechaRecepcion: fechaRecepcion,
            idEstadoMuestra: estadoMuestra.id,
            idTipoMuestra: tipoMuestra.id,
          },
        });

        // Crear resultado con fecha de entrega aleatoria
        const diasRespuesta =
          tiemposRespuesta[Math.floor(Math.random() * tiemposRespuesta.length)];
        const fechaEntrega = new Date(fechaRecepcion);
        fechaEntrega.setDate(fechaEntrega.getDate() + diasRespuesta);

        const resultado = await prisma.resultados.create({
          data: {
            resultados: `Resultados del mes ${mes}`,
            reporte: `Informe del mes ${mes}`,
            fechaEntrega: fechaEntrega,
          },
        });

        // Crear el análisis clínico
        await prisma.analisisClinico.create({
          data: {
            idMuestra: muestra.id,
            idPersonal: personal.id,
            idTipoAnalisisClinico: tipoAnalisis.id,
            idResultadoAnalisis: i < 2 ? resultado.id : null, // dejar algunos sin resultado
          },
        });
      }
    }

    // 12. Métodos de Pago
    const tiposPago = await prisma.tipoPago.createMany({
      data: [
        { metodoPago: "Efectivo" },
        { metodoPago: "Yape" },
        { metodoPago: "Plin" },
        { metodoPago: "Tarjeta" },
      ],
    });

    // 13. Estado de Pago
    const estadoPago = await prisma.estadoPago.create({
      data: { nombre: "Pagado" },
    });

    // 14. Comprobantes de Pago
    const analisisCompleto = await prisma.analisisClinico.findFirst({
      where: { idResultadoAnalisis: resultados.id },
    });

    const todosLosTiposPago = await prisma.tipoPago.findMany();

    for (let tipoPago of todosLosTiposPago) {
      await prisma.comprobantePago.create({
        data: {
          idAnalisisClinico: analisisCompleto.id,
          fechaPago: new Date("2024-12-15"),
          idEstadoPago: estadoPago.id,
          idTipoPago: tipoPago.id,
          dniPaciente: paciente.dni,
        },
      });
    }

    console.log("Seed completado exitosamente");
  } catch (error) {
    console.error("Error en seed:", error);
    throw error;
  } finally {
    await prisma.$disconnect();
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
